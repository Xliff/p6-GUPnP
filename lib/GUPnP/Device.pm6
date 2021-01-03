use v6.c;

use Method::Also;

use GUPnP::Raw::Types;

use GUPnP::DeviceInfo;

class GUPnP::Device is GUPnP::DeviceInfo {
  has GUPnPDevice $!d;

  submethod BUILD (:$device) {
    self.setGPnPDevice($device) if $device;
  }

  method setGPnPDevice (GPnPDeviceAncestry $_) {
    my $to-parent;

    $!d = do {
      when GPnPDevice {
        $to-parent = cast(GPnPDeviceInfo, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GPnPDevice, $_);
      }
    }
    self.setGPnPDeviceInfo($to-parent);
  }

  method GUPnP::Raw::Definitions::GPnPDevice
    is also<GPnPDevice>
  { $!d }

  method new (GPnPDeviceAncestry $device, :$ref = True) {
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
