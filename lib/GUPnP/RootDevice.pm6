use v6.c;

use GUPnP::Raw::Types;
use GUPnP::Raw::RootDevice;

use GUPnP::Device;

our subset GUPnPRootDeviceAncestry is export of Mu
  where GUPnPRootDevice | GUPnPRootDeviceAncestry;

class GUPnP::RootDevice is GUPnP::Device {
  has GUPnPRootDevice $!rd;

  submethod BUILD (:$root) {
    self.setGUPnPRootDevice($root) if $root;
  }

  method setGUPnPRootDevice (GUPnPRootAncestry $_) {
    my $to-parent;

    $!rd = do {
      when GUPnPRootDevice {
        $to-parent = cast(GUPnPDevice, $_);
        $_;
      }

      defaualt {
        $to-parent = $_;
        cast(GUPnpRootDevice, $_);
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

  method new (
    Str()                   $description_path,
    Str()                   $description_dir,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my $root = gupnp_root_device_new(
      $!rd,
      $description_path,
      $description_dir,
      $error
    );

    $root ?? self.bless( :$root ) !! Nil
  }

  method new_full (
    GUPnPResourceFactory()  $factory,
    GUPnPXMLDoc()           $description_doc,
    Str()                   $description_path,
    Str()                   $description_dir,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my $root = gupnp_root_device_new_full(
      $!rd,
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
  method description-dir is rw  {
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
  method description-path is rw  {
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

  method set_available (Int() $available) {
    my gboolean $a = $available.so.Int;

    gupnp_root_device_set_available($!rd, $a);
  }

  method get_available {
    so gupnp_root_device_get_available($!rd);
  }

  method get_description_dir {
    gupnp_root_device_get_description_dir($!rd);
  }

  method get_description_path {
    gupnp_root_device_get_description_path($!rd);
  }

  method get_relative_location {
    gupnp_root_device_get_relative_location($!rd);
  }

  method get_ssdp_resource_group ($raw = False) {
    my $rg = gupnp_root_device_get_ssdp_resource_group($!rd);

    $rg ??
      ( $raw ?? $rg !! GSSDP::ResourceGroup.new($rg) )
      !!
      Nil;
  }

}
