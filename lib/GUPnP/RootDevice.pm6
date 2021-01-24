use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;
use GUPnP::Raw::RootDevice;

use GUPnP::Device;

our subset GUPnPRootDeviceAncestry is export of Mu
  where GUPnPRootDevice | GUPnPDeviceAncestry;

class GUPnP::RootDevice is GUPnP::Device {
  has GUPnPRootDevice $!rd;

  submethod BUILD (:$root) {
    self.setGUPnPRootDevice($root) if $root;
  }

  method setGUPnPRootDevice (GUPnPRootDeviceAncestry $_) {
    my $to-parent;

    $!rd = do {
      when GUPnPRootDevice {
        $to-parent = cast(GUPnPDevice, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPRootDevice, $_);
      }
    }
    self.setGUPnPDevice($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPRootDevice
  { $!rd }

  multi method new (GUPnPRootDeviceAncestry $root, :$ref = True) {
    return Nil unless $root;

    my $o = self.bless( :$root );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GUPnPContext()          $context,
    Str()                   $description_path,
    Str()                   $description_dir,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my $root = gupnp_root_device_new(
      $context,
      $description_path,
      $description_dir,
      $error
    );

    $root ?? self.bless( :$root ) !! Nil
  }

  method new_full (
    GUPnPContext()          $context,
    GUPnPResourceFactory()  $factory,
    GUPnPXMLDoc()           $description_doc,
    Str()                   $description_path,
    Str()                   $description_dir,
    CArray[Pointer[GError]] $error            = gerror
  )
    is also<new-full>
  {
    my $root = gupnp_root_device_new_full(
      $context,
      $factory,
      $description_doc,
      $description_path,
      $description_dir,
      $error
    );

    $root ?? self.bless( :$root ) !! Nil;
  }

  # Type: gboolean
  method available is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('available', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('available', $gv);
      }
    );
  }

  # Type: gchar
  method description-dir is rw  is also<description_dir> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('description-dir', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'description-dir is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method description-path is rw  is also<description_path> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('description-path', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'description-path is a construct-only attribute'
      }
    );
  }

  method set_available (Int() $available) is also<set-available> {
    my gboolean $a = $available.so.Int;

    gupnp_root_device_set_available($!rd, $a);
  }

  method get_available is also<get-available> {
    so gupnp_root_device_get_available($!rd);
  }

  method get_description_dir is also<get-description-dir> {
    gupnp_root_device_get_description_dir($!rd);
  }

  method get_description_path is also<get-description-path> {
    gupnp_root_device_get_description_path($!rd);
  }

  method get_relative_location
    is also<
      get-relative-location
      relative_location
      relative-location
    >
  {
    gupnp_root_device_get_relative_location($!rd);
  }

  method get_ssdp_resource_group ($raw = False)
    is also<
      get-ssdp-resource-group
      ssdp_resource_group
      ssdp-resource-group
    >
  {
    my $rg = gupnp_root_device_get_ssdp_resource_group($!rd);

    $rg ??
      ( $raw ?? $rg !! GSSDP::ResourceGroup.new($rg) )
      !!
      Nil;
  }

}
