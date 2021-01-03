use v6.c;

use Method::Also;

use GUPnP::Raw::Types;

use GUPnP::DeviceInfo;

our subset GUPnPDeviceProxyAncestry is export of Mu
  where GUPnPDeviceProxy | GUPnPDeviceInfoAncestry;

class GUPnP::DeviceProxy is GUPnP::DeviceInfo {
  has GUPnPDeviceProxy $!dp;

  submethod BUILD (:$device-proxy) {
    self.setGUPnPDeviceProxy($device-proxy) if $device-proxy;
  }

  method setGUPnPDeviceProxy (GUPnPDeviceProxyAncestry $_) {
    my $to-parent;

    $!dp = do {
      when GUPnPDeviceProxy {
        $to-parent = cast(GUPnPDeviceInfo, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDeviceProxy, $_);
      }
    }
    self.setGUPnPDeviceInfo($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDeviceProxy
    is also<GUPnPDeviceProxy>
  { $!dp }

  method new (GUPnPDeviceProxyAncestry $device-proxy, :$ref = True) {
    return Nil unless $device-proxy;

    my $o = self.bless( :$device-proxy );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gupnp_device_proxy_get_type, $n, $t );
  }

}
