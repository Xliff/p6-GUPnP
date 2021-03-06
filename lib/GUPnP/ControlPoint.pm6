use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::ControlPoint;

use GSSDP::ResourceBrowser;

use GUPnP::Roles::Signals::ControlPoint;

our subset GUPnPControlPointAncestry is export
  where GUPnPControlPoint | GSSDPResourceBrowserAncestry;

class GUPnP::ControlPoint is GSSDP::ResourceBrowser {
  also does GUPnP::Roles::Signals::ControlPoint;

  has GUPnPControlPoint $!cp;

  submethod BUILD (:$control-point) {
    self.setGUPnPControlPoint($control-point) if $control-point;
  }

  method setGUPnPControlPoint (GUPnPControlPointAncestry $_) {
    my $to-parent;

    $!cp = do {
      when GUPnPControlPoint {
        $to-parent = cast(GSSDPResourceBrowser, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPControlPoint, $_);
      }
    }
    self.setGSSDPResourceBrowser($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPControlPoint
    is also<GUPnPControlPoint>
  { $!cp }

  method new (GUPnPContext() $context, Str() $target) {
    my $control-point = gupnp_control_point_new($context, $target);

    $control-point ?? self.bless( :$control-point ) !! Nil;
  }

  method new_full (
    GUPnPContext()         $context,
    GUPnPResourceFactory() $factory,
    Str()                  $target
  )
    is also<new-full>
  {
    my $control-point = gupnp_control_point_new_full(
      $context,
      $factory,
      $target
    );

    $control-point ?? self.bless( :$control-point ) !! Nil;
  }

  # Is originally:
  # GUPnPControlPoint, GUPnPDeviceProxy, gpointer --> void
  method device-proxy-available is also<device_proxy_available> {
    self.connect-device-proxy($!cp, 'device-proxy-available');
  }

  # Is originally:
  # GUPnPControlPoint, GUPnPDeviceProxy, gpointer --> void
  method device-proxy-unavailable is also<device_proxy_unavailable> {
    self.connect-device-proxy($!cp, 'device-proxy-unavailable');
  }

  # Is originally:
  # GUPnPControlPoint, GUPnPServiceProxy, gpointer --> void
  method service-proxy-available is also<service_proxy_available> {
    self.connect-service-proxy($!cp, 'service-proxy-available');
  }

  # Is originally:
  # GUPnPControlPoint, GUPnPServiceProxy, gpointer --> void
  method service-proxy-unavailable is also<service_proxy_unavailable> {
    self.connect-service-proxy($!cp, 'service-proxy-unavailable');
  }

  # Type: GUPnPResourceFactory
  method resource-factory (:$raw = False) is rw  is also<resource_factory> {
    my $gv = GLib::Value.new( GUPnP::ResourceFactory.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('resource-factory', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(GUPnPResourceFactory, $o);
        return $o if $raw;

        GUPnP::ResourceFactory.new($o, :!ref);
      },
      STORE => -> $, $val is copy {
        warn 'resource-factory is a construct-only attribute'
      }
    );
  }

  method get_context (:$raw = False) is also<get-context> {
    my $c = gupnp_control_point_get_context($!cp);

    $c ??
      ( $raw ?? $c !! GUPnP::Context.new($c) )
      !!
      Nil
  }

  method get_resource_factory ( :$raw = False ) is also<get-resource-factory> {
    my $f = gupnp_control_point_get_resource_factory($!cp);

    $f ??
      ( $raw ?? $f !! GUPnP::ResourceFactory.new($f) )
      !!
      Nil;
  }

  method list_device_proxies (:$glist = False, :$raw = False)
    is also<list-device-proxies>
  {
    my $rl = gupnp_control_point_list_device_proxies($!cp);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[GUPnPDeviceProxy];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ GUPnP::Device.new($_) });
  }

  method list_service_proxies (:$glist = False, :$raw = False)
    is also<list-service-proxies>
  {
    my $rl = gupnp_control_point_list_service_proxies($!cp);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[GUPnPServiceProxy];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ GUPnP::Service.new($_) });
  }

}
