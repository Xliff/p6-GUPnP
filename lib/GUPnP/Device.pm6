use v6.c;

use Method::Also;

use GUPnP::Raw::Types;

use GUPnP::DeviceInfo;

our subset GUPnPDeviceAncestry is export of Mu
  where GUPnPDevice | GUPnPDeviceInfoAncestry;

class GUPnP::Device is GUPnP::DeviceInfo {
  has GUPnPDevice $!d;

  submethod BUILD (:$device) {
    self.setGUPnPDevice($device) if $device;
  }

  method setGUPnPDevice (GUPnPDeviceAncestry $_) {
    my $to-parent;

    $!d = do {
      when GUPnPDevice {
        $to-parent = cast(GUPnPDeviceInfo, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDevice, $_);
      }
    }
    self.setGUPnPDeviceInfo($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDevice
    is also<GUPnPDevice>
  { $!d }

  method new (GUPnPDeviceAncestry $device, :$ref = True) {
    return Nil unless $device;

    my $o = self.bless( :$device );
    $o.ref if $ref;
    $o;
  }

  # Type: GUPnPRootDevice
  method root-device (:$raw = False) is rw  {
    my $gv = GLib::Value.new( ::('GUPnP::RootDevice').get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('root-device', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(GUPnPRootDevice, $_);
        return $o if $raw;

        ::('GUPnP::RootDevice').new($o, :!ref);
      },
      STORE => -> $,  $val is copy {
        warn 'root-device is a construct-only attribute'
      }
    );
  }

}
