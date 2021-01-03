use v6.c;

use GUPnP::Raw::Types;
use GUPnP::Raw::ServiceInfo;

use GLib::Roles::Object;

class GUPnP::ServiceInfo {
  also does GLib:Roles::Object;

  has GUPnPServiceInfo $!si;

  # Type: GUPnPContext
  method context (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GUPnP::Context.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('context', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(GUPnPContext, $o);
        return $o if $raw;

        GUPnP::Context.new($o, :!ref);
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
  method service-type is rw  {
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
  method url-base (:$raw = False) is rw  {
    my $gv = GLib::Value.new( SOUP::URI.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('url-base', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(SoupURI, $o);
        return $o if $raw;

        SOUP::URI.new($o, :!ref);
      },
      STORE => -> $,  $val is copy {
        warn 'url-base is a construct-only attribute'
      }
    );
  }

  method get_context (:$raw = False) {
    my $c = gupnp_service_info_get_context($!si);

    $c ??
      ( $raw ?? $c !! GUPnP::Context.new($c) )
      !!
      Nil;
  }

  method get_control_url {
    gupnp_service_info_get_control_url($!si);
  }

  method get_event_subscription_url {
    gupnp_service_info_get_event_subscription_url($!si);
  }

  method get_id {
    gupnp_service_info_get_id($!si);
  }

  method get_introspection_async (
             &callback,
    gpointer $user_data = gpointer
  ) {
    gupnp_service_info_get_introspection_async($!si, &callback, $user_data);
  }

  proto method get_introspection_async_full (|)
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

  method get_location {
    gupnp_service_info_get_location($!si);
  }

  method get_scpd_url {
    gupnp_service_info_get_scpd_url($!si);
  }

  method get_service_type {
    gupnp_service_info_get_service_type($!si);
  }

  method get_udn {
    gupnp_service_info_get_udn($!si);
  }

  method get_url_base (:$raw = False) {
    my $su = gupnp_service_info_get_url_base($!si);

    $su ??
      # cw: -XXX-
      #     Should NEVER be freed since it is constant. Need a mechanism
      #     for this too in ALL GObjects... *sigh*
      ( $raw ?? $su !! SOUP::URI.new($su) )
      !!
      Nil;
  }

  proto method introspect_async (|)
  { * }

  multi method introspect_async (
                   &callback,
    gpointer       $user_data    = gpointer
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
  ) {
    clear_error;
    my $si = gupnp_service_info_introspect_finish($!si, $res, $error);
    set_error($error);

    $si ??
      ( $raw ?? $si !! GUPnP::ServiceIntrospection.new($si, :!ref) )
      !!
      Nil;
  }

}
