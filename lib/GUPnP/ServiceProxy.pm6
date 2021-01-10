use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;
use GUPnP::Raw::ServiceProxy;
use GUPnP::Raw::ServiceProxyAction;

use GUPnP::ServiceInfo;

use GLib::Roles::Object;

use GUPnP::Roles::Signals::ServiceProxy;

our subset GUPnPServiceProxyAncestry is export of Mu
  where GUPnPServiceProxy | GUPnPServiceInfo;

class GUPnP::ServiceProxy is GUPnP::ServiceInfo {
  also does GUPnP::Roles::Signals::ServiceProxy;

  has GUPnPServiceProxy $!sp;

  submethod BUILD (:$proxy) {
    self.setGUPnPServiceProxy($proxy) if $proxy;
  }

  method setGUPnPServiceProxy(GUPnPServiceProxyAncestry $_) {
    my $to-parent;

    $!sp = do {
      when GUPnPServiceProxy {
        $to-parent = cast(GUPnPServiceInfo, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPServiceProxy, $_);
      }
    }
    self.setGUPnPServiceInfo($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPServiceProxy
    is also<GUPnPServiceProxy>
  { $!sp }

  method new (GUPnPServiceProxyAncestry $proxy, :$ref = True) {
    return Nil unless $proxy;

    my $o = self.bless( :$proxy );
    $o.ref if $ref;
    $o;
  }

  # Type: gboolean
  method subscribed is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('subscribed', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('subscribed', $gv);
      }
    );
  }

  # Is originally:
  # GUPnPServiceProxy, gpointer, gpointer --> void
  method subscription-lost is also<subscription_lost> {
    self.connect-subscription-lost($!sp);
  }

  method add_notify (
    Str()    $variable,
    GType    $type,
             &callback,
    gpointer $user_data = gpointer
  )
    is also<add-notify>
  {
    my GType $t = $type;

    so gupnp_service_proxy_add_notify(
      $!sp,
      $variable,
      $t,
      &callback,
      $user_data
    );
  }

  method add_notify_full (
    Str()    $variable,
    Int()    $type,
             &callback,
    gpointer $user_data = gpointer,
             &notify    = Callable
  )
    is also<add-notify-full>
  {
    my GType $t = $type;

    so gupnp_service_proxy_add_notify_full(
      $!sp,
      $variable,
      $t,
      &callback,
      $user_data,
      &notify
    );
  }

  method add_raw_notify (
             &callback,
    gpointer $user_data,
             &notify
  )
    is also<add-raw-notify>
  {
    so gupnp_service_proxy_add_raw_notify(
      $!sp,
      &callback,
      $user_data,
      &notify
    );
  }

  method begin_action_list (
    Str()    $action,
    GList()  $in_names,
    GList()  $in_values,
             &callback,
    gpointer $user_data = gpointer
  )
    is also<begin-action-list>
  {
    gupnp_service_proxy_begin_action_list(
      $!sp,
      $action,
      $in_names,
      $in_values,
      &callback,
      $user_data
    );
  }

  method call_action (
    GUPnPServiceProxyAction() $action,
    GCancellable()            $cancellable = GCancellable,
    CArray[Pointer[GError]]   $error       = gerror
  )
    is also<call-action>
  {
    clear_error;
    my $spa = gupnp_service_proxy_call_action(
      $!sp,
      $action,
      $cancellable,
      $error
    );
    set_error($error);
    $spa;
  }

  proto method call_action_async (|)
      is also<call-action-async>
  { * }

  multi method call_action_async (
    GUPnPServiceProxyAction $action,
                            &callback,
    gpointer                $user_data    = gpointer,
    GCancellable            :$cancellable = GCancellable
  ) {
    samewith($action, $cancellable, &callback, $user_data);
  }
  multi method call_action_async (
    GUPnPServiceProxyAction $action,
    GCancellable()          $cancellable,
                            &callback,
    gpointer                $user_data = gpointer
  ) {
    gupnp_service_proxy_call_action_async(
      $!sp,
      $action,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method call_action_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<call-action-finish>
  {
    clear_error;
    my $spa = gupnp_service_proxy_call_action_finish($!sp, $result, $error);
    set_error($error);
    $spa;
  }

  method cancel_action (GUPnPServiceProxyAction $action)
    is also<cancel-action>
  {
    gupnp_service_proxy_cancel_action($!sp, $action);
  }

  method end_action_hash (
    GUPnPServiceProxyAction $action,
    GHashTable()            $hash,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<end-action-hash>
  {
    clear_error;
    my $rv = so gupnp_service_proxy_end_action_hash(
      $!sp,
      $action,
      $hash,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method end_action_list (|)
      is also<end-action-list>
  { * }

  multi method end_action_list (
    GUPnPServiceProxyAction $action,
    CArray[Pointer[GError]] $error       = gerror,
                            :$glist      = False,
                            :$raw        = False
  ) {
    my ($on, $ot) = GList.new xx 2;
    (my $ov       = CArray[Pointer[GList]].new)[0] = Pointer[GList];
    my $rv        = samewith($action, $on, $ot, $ov, :$glist, :$raw);

    $rv[0] ?? $rv.skip(1) !! Nil;
  }
  multi method end_action_list (
    GUPnPServiceProxyAction $action,
    GList()                 $out_names,
    GList()                 $out_types,
    CArray[Pointer[GList]]  $out_values,
    CArray[Pointer[GError]] $error       = gerror,
                            :$glist      = False,
                            :$raw        = False
  ) {
    my $rv = so gupnp_service_proxy_end_action_list(
      $!sp,
      $action,
      $out_names,
      $out_types,
      $out_values,
      $error
    );

    handle-out-ntv($rv, $out_names, $out_types, $out_values, $glist, $raw);
  }

  method get_subscribed is also<get-subscribed> {
    so gupnp_service_proxy_get_subscribed($!sp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gupnp_service_proxy_get_type, $n, $t );
  }

  method remove_notify (
    Str()    $variable,
             &callback,
    gpointer $user_data = gpointer
  )
    is also<remove-notify>
  {
    so gupnp_service_proxy_remove_notify(
      $!sp,
      $variable,
      &callback,
      $user_data
    );
  }

  method remove_raw_notify (
             &callback,
    gpointer $user_data = gpointer
  )
    is also<remove-raw-notify>
  {
    so gupnp_service_proxy_remove_raw_notify($!sp, &callback, $user_data);
  }


  proto method send_action_list (|)
      is also<send-action-list>
  { * }

  multi method send_action_list (
    Str() $action,
          @names,
          @values,
          :$glist  = False,
          :$raw    = False
  ) {
    samewith(
      $action,
      GLib::GList.new(@names),
      GLib::GList.new(@values),
      :$glist,
      :$raw
    );
  }
  multi method send_action_list (
    Str()   $action,
    GList() $in_names,
    GList() $in_values,
            :$glist     = False,
            :$raw       = False
  ) {
    my ($on, $ot) = GList.new xx 2;
    (my $ov       = CArray[Pointer[GList]].new)[0] = Pointer[GList];
    my $rv        = samewith($action, $on, $ot, $ov, :$glist, :$raw);

    $rv[0] ?? $rv.skip(1) !! Nil;
  }
  multi method send_action_list (
    Str()                   $action,
    GList()                 $in_names,
    GList()                 $in_values,
    GList()                 $out_names,
    GList()                 $out_types,
    CArray[Pointer[GList]]  $out_values,
    CArray[Pointer[GError]] $error       = gerror,
                            :$glist      = False,
                            :$raw        = False
  ) {
    clear_error;
    my $rv = gupnp_service_proxy_send_action_list(
      $!sp,
      $action,
      $in_names,
      $in_values,
      $out_names,
      $out_types,
      $out_values,
      $error
    );
    set_error($error);

    handle-out-ntv($rv, $out_names, $out_types, $out_values, $glist, $raw);
  }

  method set_subscribed (Int() $subscribed) is also<set-subscribed> {
    my gboolean $s = $subscribed.so.Int;

    gupnp_service_proxy_set_subscribed($!sp, $s);
  }
}
