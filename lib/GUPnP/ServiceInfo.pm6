use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;
use SOUP::Raw::Definitions;
use GUPnP::Raw::ServiceInfo;

use GLib::Roles::Object;

our subset GUPnPServiceInfoAncestry is export of Mu
  where GUPnPServiceInfo | GObject;

class GUPnP::ServiceInfo {
  also does GLib::Roles::Object;

  has GUPnPServiceInfo $!si;

  submethod BUILD (:$service-info) {
    self.setGUPnPServiceInfo($service-info) if $service-info;
  }

  method setGUPnPServiceInfo (GUPnPServiceInfoAncestry $_) {
    my $to-parent;

    $!si = do {
      when GUPnPServiceInfo {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPServiceInfo, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPServiceInfo
    is also<GUPnPServiceInfo>
  { $!si }

  method new (GUPnPServiceInfoAncestry $service-info, :$ref = True) {
    return Nil unless $service-info;

    my $o = self.bless( :$service-info );
    $o.ref if $ref;
    $o;
  }

  # Type: GUPnPContext
  method context (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GUPnP::Context.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('context', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          GUPnPContext,
          GUPnP::Context
        );
      },
      STORE => -> $,  $val is copy {
        warn 'context is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method location is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('location', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'location is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method service-type is rw  is also<service_type> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('service-type', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'service-type is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method udn is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('udn', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'udn is a construct-only attribute'
      }
    );
  }

  # Type: SoupURI
  method url-base (:$raw = False) is rw  is also<url_base> {
    my $gv = GLib::Value.new( SOUP::URI.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('url-base', $gv)
        );

        propReturnObject(
          $gv.object;
          $raw,
          SoupURI,
          SOUP::URI
        );
      },
      STORE => -> $,  $val is copy {
        warn 'url-base is a construct-only attribute'
      }
    );
  }

  # Transfer: none (implies default)
  method get_context (:$raw = False) is also<get-context> {
    my $c = gupnp_service_info_get_context($!si);

    $c ??
      ( $raw ?? $c !! GUPnP::Context.new($c) )
      !!
      Nil;
  }

  method get_control_url is also<get-control-url> {
    gupnp_service_info_get_control_url($!si);
  }

  method get_event_subscription_url is also<get-event-subscription-url> {
    gupnp_service_info_get_event_subscription_url($!si);
  }

  method get_id is also<get-id> {
    gupnp_service_info_get_id($!si);
  }

  method get_introspection_async (
             &callback,
    gpointer $user_data = gpointer
  )
    is also<get-introspection-async>
  {
    gupnp_service_info_get_introspection_async($!si, &callback, $user_data);
  }

  proto method get_introspection_async_full (|)
      is also<get-introspection-async-full>
  { * }

  multi method get_introspection_async_full (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(&callback, $cancellable, $user_data);
  }
  multi method get_introspection_async_full (
                   &callback,
    GCancellable() $cancellable,
    gpointer       $user_data   = gpointer
  ) {
    gupnp_service_info_get_introspection_async_full(
      $!si,
      &callback,
      $cancellable,
      $user_data
    );
  }

  method get_location is also<get-location> {
    gupnp_service_info_get_location($!si);
  }

  method get_scpd_url is also<get-scpd-url> {
    gupnp_service_info_get_scpd_url($!si);
  }

  method get_service_type is also<get-service-type> {
    gupnp_service_info_get_service_type($!si);
  }

  method get_udn is also<get-udn> {
    gupnp_service_info_get_udn($!si);
  }

  method get_url_base (:$raw = False) is also<get-url-base> {
    my $su = gupnp_service_info_get_url_base($!si);

    $su ??
      ( $raw ?? $su !! SOUP::URI.new($su, :fixed) )
      !!
      Nil;
  }

  proto method introspect_async (|)
      is also<introspect-async>
  { * }

  multi method introspect_async (
                   &callback,
    gpointer       $user_data    = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method introspect_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    gupnp_service_info_introspect_async(
      $!si,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method introspect_finish (
    GAsyncResult()          $res,
    CArray[Pointer[GError]] $error = gerror,
                            :$raw  = False
  )
    is also<introspect-finish>
  {
    clear_error;
    my $si = gupnp_service_info_introspect_finish($!si, $res, $error);
    set_error($error);

    $si ??
      ( $raw ?? $si !! GUPnP::ServiceIntrospection.new($si, :!ref) )
      !!
      Nil;
  }

}
