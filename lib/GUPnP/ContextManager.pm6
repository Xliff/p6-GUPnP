use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::ContextManager;

use GLib::Roles::Object;

our subset GUPnPContextManagerAncestry is export of Mu
  where GUPnPContextManager | GObject;

class GUPnP::ContextManager {
  also does GLib::Roles::Object;

  has GUPnPContextManager $!cm;

  submethod BUILD (:$context-manager) {
    self.setGUPnPContextManager($context-manager) if $context-manager;
  }

  method setGUPnPContextManager (GUPnPContextManagerAncestry $_) {
    my $to-parent;

    $!cm = do {
      when GUPnPContextManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPContextManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method create is also<new> {
    my $context-manager = gupnp_context_manager_create($!cm);

    $context-manager ?? self.bless( :$context-manager ) !! Nil;
  }

  method create_full (
    Int()           $uda_version,
    GSocketFamily() $family,
    Int()           $port
  )
    is also<
      create-full
      new_full
      new-full
    >
  {
    my GSSDPUDAVersion $u  = $uda_version;
    my guint           $p  = $port;
    my                 $cm = gupnp_context_manager_create_full($u, $family, $p);

    $cm ?? self.bless( context-manager => $cm ) !! Nil;
  }

  # Type: guint
  method port is rw  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('port', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'port is a construct-only attribute'
      }
    );
  }

  # Type: GUPnPWhiteList
  method white-list (:$raw = False) is rw  is also<white_list> {
    my $gv = GLib::Value.new( GUPnP::WhiteList.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('white-list', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(GUPnPWhiteList, $_);
        return $o if $raw;

        GUPnP::WhiteList.new($o, :!ref);
      },
      STORE => -> $, $val is copy {
        warn 'white-list does not allow writing'
      }
    );
  }

  # Is originally:
  # GUPnPContextManager, GUPnPContext, gpointer --> void
  method context-available is also<context_available> {
    self.connect-context($!cm, 'context-available');
  }

  # Is originally:
  # GUPnPContextManager, GUPnPContext, gpointer --> void
  method context-unavailable is also<context_unavailable> {
    self.connect-context($!cm, 'context-unavailable');
  }

  method get_port is also<get-port> {
    gupnp_context_manager_get_port($!cm);
  }

  method get_socket_family is also<get-socket-family> {
    gupnp_context_manager_get_socket_family($!cm);
  }

  method get_uda_version is also<get-uda-version> {
    GSSDPUDAVersionEnum( gupnp_context_manager_get_uda_version($!cm) )
  }

  method get_white_list (:$raw = False) is also<get-white-list> {
    my $wl = gupnp_context_manager_get_white_list($!cm);

    $wl ??
      ( $raw ?? $wl !! GUPnP::WhiteList.new($wl) )
      !!
      Nil;
  }

  method manage_control_point (GUPnPControlPoint() $control_point)
    is also<manage-control-point>
  {
    gupnp_context_manager_manage_control_point($!cm, $control_point);
  }

  method manage_root_device (GUPnPRootDevice() $root_device)
    is also<manage-root-device>
  {
    gupnp_context_manager_manage_root_device($!cm, $root_device);
  }

  method rescan_control_points is also<rescan-control-points> {
    gupnp_context_manager_rescan_control_points($!cm);
  }

}
