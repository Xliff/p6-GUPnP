use v6.c;

use GUPnP::Raw::Types;
use GUPnP::Raw::ServiceProxy;

use GLib::Roles::Object;

use GUPnP::Roles::Signals::ServiceProxy;

our GUPnPServiceProxyAncestry is export of Mu
  where GUPnPServiceProxy | GObject;

class GUPnP::ServiceProxy {
  also does GLib::Roles::Object;
  also does GUPnP::Roles::Signals::ServiceProxy;

  has GUPnPSericeProxy $!sp;

  submethod BUILD (:$proxy) {
    self.setGUPnPServiceProxy($proxy) if $proxy;
  }

  method setGUPnPServiceProxy(GUPnPServiceProxyAncestry $_) {
    my $to-parent;

    $!sp = do {
      when GUPnpServiceProxy {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default{
        $to-parent = $_;
        cast(GUPnpServiceProxy, $_);
      }
    }
    self!setObject($to-parent);s
  }

  method GUPnP::Raw::Definitions::GUPnpServiceProxy
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
  method subscription-lost {
    self.connect-subscription-lost($!w);
  }

  method add_notify (
    Str()    $variable,
    GType    $type,
             &callback,
    gpointer $user_data = gpointer
  ) {
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
  ) {
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
  ) {
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
  ) {
    gupnp_service_proxy_begin_action_list(
      $!sp,
      $action,
      $in_names,
      $in_values,
      $callback,
      $user_data
    );
  }

  method call_action (
    GUPnPServiceProxyAction() $action,
    GCancellable()            $cancellable = GCancellable,
    CArray[Pointer[GError]]   $error       = gerror
  ) {
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
  ) {
    clear_error;
    my $spa = gupnp_service_proxy_call_action_finish($!sp, $result, $error);
    set_error($error);
    $spa;
  }

  method cancel_action (GUPnPServiceProxyAction $action) {
    gupnp_service_proxy_cancel_action($!sp, $action);
  }

  method end_action_hash (
    GUPnPServiceProxyAction $action,
    GHashTable()            $hash,
    CArray[Pointer[GError]] $error = gerror
  ) {
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

  method get_subscribed {
    so gupnp_service_proxy_get_subscribed($!sp);
  }

  method remove_notify (
    Str()    $variable,
             &callback,
    gpointer $user_data = gpointer
  ) {
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
  ) {
    so gupnp_service_proxy_remove_raw_notify($!sp, $callback, $user_data);
  }


  proto method send_action_list (|)
  { * }

  multi method send_action_list (
    Str $action,
        @names,
        @values,
        :$glist  = False,
        :$raw    = False
  ) {
    samewith(
      $actions,
      GLib::GList.new(@names),
      GLib::GList.new(@values),
      :$glist,
      :$taw
    );
  }
  multi method send_action_list (
    Str()                   $action,
    GList()                 $in_names,
    GList()                 $in_values,
                            :$glist     = False
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
                            :$glist      = False
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

  method set_subscribed (Int() $subscribed) {
    my gboolean $s = $subscribed.so.Int;

    gupnp_service_proxy_set_subscribed($!sp, $s);
  }
}

my $serviceProxyReturnHash = True;
class GUPnPServiceProxyAction is repr<CPointer> is export does GLib::Roles::Pointers {

  method hashByDefault (GUPnPServiceProxyAction:U: $b) is rw {
    $serviceProxyReturnHash
  }

  multi method new_from_list (Str() $action, @names, @values) {
    my ($n, $v) = ( GLib::GList.new(@names), GLib::GList.new(@values) );
    samewith($action, $n, $v);
  }
  multi method new_from_list (
    Str()   $action,
    GList() $in_names,
    GList() $in_values
  ) {
    gupnp_service_proxy_action_new_from_list($action, $in_names, $in_values);
  }

  method get_type {
    unstable_get_type(
      self.^name,
      &gupnp_service_proxy_action_get_type,
      $n,
      $t
    );
  }

  method ref {
    gupnp_service_proxy_action_ref(self);
    self;
  }

  method unref {
    gupnp_service_proxy_action_unref(self);
  }

  method get_result (:$list is copy, :$hash is copy) {
    die 'Cannot use both :list and :hash with .get_result!'
      unless $hash && $list ^^ $hash;
    $hash //= $returnHash unless $list;

    return self.get_result_hash if $hash;
    self.get_result_list;
  }

  multi method get_result_hash (CArray[Pointer[GError]] $error = gerror) {
    my $h  = GHashTable.new;
    my $rv = callwith($h, $error);

    $rv ?? $rv[0] !! Nil;
  }
  multi method get_result_hash (
    GHashTable()            $out_hash,
    CArray[Pointer[GError]] $error     = gerror,
                            :$raw      = False
  ) {
      my $rv = so gupnp_service_proxy_action_get_result_hash(
        self,
        $out_hash,
        $error
      );

      $out_hash ??
        ( $raw ?? $out_hash !! GLib::HashTable.new($!pa, :!ref) )
        !!
        Nil;

      $rv;
    }
  }

  multi method get_result_list (:$glist, :$raw) {
    my ($on, $ot) = GList.new xx 2;
    (my $ov       = CArray[Pointer[GList]].new)[0] = Pointer[GList];
    my $rv        = callwith($on, $ot, $ov, :$glist, :$raw);

    $rv ?? $rv.skip(1) !! Nil;
  }
  multi method get_result_list (
    GList()                 $out_names,
    GList()                 $out_types,
    CArray[Pointer[GList]]  $out_values,
    CArray[Pointer[GError]] $error       = gerror
                            :$glist      = False,
                            :$raw        = False
  ) {
    clear_error;
    my $rv = so gupnp_service_proxy_action_get_result_list(
      $!sp,
      $out_names,
      $out_types,
      $out_values,
      $error
    );
    set_error($error);

    handle-out-ntv($rv, $out_names, $out_types, $out_values, $glist, $raw);
  }
}

sub handle-out-ntv ($rv, $on is copy, $ot is copy, $ov is copy, $glist, $raw) {
  $ov = ppr($ov);
  return ($rv, $on, $ot, $ov) if $glist && $raw;

  $on = GLib::GList.new($on) but GLib::Roles::ListData[Str];
  $ot = GLib::GList.new($ot) but GLib::Roles::ListData[GType];
  $ov = GLib::GList.new($ov) but GLib::Roles::ListData[GValue];
  return ($rv, $on, $ot, $ov) if $glist;

  (
    $rv,
    $on.Array,
    $ot.Array,
    $raw ?? $ov.Array !! $ov.Array.map({ GLib::GValue.new($_) })
  );
}
