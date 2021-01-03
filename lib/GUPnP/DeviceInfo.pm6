use v6.c;

use GUPnP::Raw::Types;
use GUPnP::Raw::DeviceInfo;

use GLib::Roles::Object;

our subset GUPnPDeviceInfoAncestry is export of Mu
  where GUPnPDeviceInfo | GObject;

class GUPnP::DeviceInfo {
  also does GLib::Roles::Object;

  has GUPnPDeviceInfo $!di;

  submethod BUILD (:$device-info) {
    self.setGUPnPDeviceInfo($device-info) if $device-info;
  }

  method setGUPnPDeviceInfo (GUPnPDeviceInfoAncestry $_) {
    my $to-parent;

    $!di = do {
      when GUPnPDeviceInfo {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDeviceInfo, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDeviceInfo
  { $!di }

  method new (GUPnPDeviceInfoAncestry $device-info, :$!ref = True) {
    return Nil unless $device-info;

    my $o = self.bless( :$device-info );
    $o.ref if $ref;
    $o;
  }

  method get_context {
    gupnp_device_info_get_context($!di);
  }

  method get_description_value (Str() $element) {
    gupnp_device_info_get_description_value($!di, $element);
  }

  method get_device (Str() $type) {
    gupnp_device_info_get_device($!di, $type);
  }

  method get_device_type {
    gupnp_device_info_get_device_type($!di);
  }

  method get_friendly_name {
    gupnp_device_info_get_friendly_name($!di);
  }

  proto method get_icon_url (|)
  { * }

  multi method get_icon_url (
    Str() $requested_mime_type,
    Int() $requested_depth,
    Int() $requested_width,
    Int() $requested_height,
    Int() $prefer_bigger,
          :$all                = True
  ) {
    samewith(
      $requested_mime_type,
      $requested_depth,
      $requested_width,
      $requested_height,
      $prefer_bigger,
      $, $, $, $,
      :$all
    );
  }
  multi method get_icon_url (
    Str() $requested_mime_type,
    Int() $requested_depth,
    Int() $requested_width,
    Int() $requested_height,
    Int() $prefer_bigger,
          $mime_type           is rw,
          $depth               is rw,
          $width               is rw,
          $height              is rw
          :$all                =  False
  ) {
    my ($rd, $rw, $rh) =
      ($requested_width, $requested_width, $requested_height);Int()
    my $p = $prefer_bigger.so.Int;
    (my $mt = CArray[Str].new)[0] = Str;
    my gint ($d, $w, $h)          = 0 xx 3;

    my $url = gupnp_device_info_get_icon_url(
      $!di,
      $requested_mime_type,
      $rd,
      $rw,
      $rh,
      $pb,
      $mt,
      $d,
      $w,
      $h
    );
    ($mime_type, $depth, $width, $height) = (ppr($mt), $d, $w, $h);
    return $all.not ?? $url !! ($url, $mime_type, $depth, $width, $height);
  }

  method get_location {
    gupnp_device_info_get_location($!di);
  }

  method get_manufacturer {
    gupnp_device_info_get_manufacturer($!di);
  }

  method get_manufacturer_url {
    gupnp_device_info_get_manufacturer_url($!di);
  }

  method get_model_description {
    gupnp_device_info_get_model_description($!di);
  }

  method get_model_name {
    gupnp_device_info_get_model_name($!di);
  }

  method get_model_number {
    gupnp_device_info_get_model_number($!di);
  }

  method get_model_url {
    gupnp_device_info_get_model_url($!di);
  }

  method get_presentation_url {
    gupnp_device_info_get_presentation_url($!di);
  }

  method get_resource_factory {
    gupnp_device_info_get_resource_factory($!di);
  }

  method get_serial_number {
    gupnp_device_info_get_serial_number($!di);
  }

  method get_service (Str() $type, :$raw = False) {
    my $s = gupnp_device_info_get_service($!di, $type);

    $s ??
      ( $raw ?? $s !! GUPnP::ServiceInfo.new($s, :!ref) )
      !!
      Nil;
  }

  method get_udn {
    gupnp_device_info_get_udn($!di);
  }

  method get_upc {
    gupnp_device_info_get_upc($!di);
  }

  method get_url_base (:$raw = False) {
    my $ub = gupnp_device_info_get_url_base($!di);

    $ub ??
      ( $raw ?? $ub !! SOUP::URI.new($ub, :!ref) )
      !!
      Nil;
  }

  method list_device_types (:$glist = False, :$raw = False) {
    my $rl = my $dtl = gupnp_device_info_list_device_types($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[Str];
    return $rl if $glist;

    $rl.Array;
  }

  method list_devices (:$glist = False, :$raw = False) {
    my $rl = gupnp_device_info_list_devices($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[GUPnPDeviceInfo];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ GUPnP::DeviceInfo.new($_, :!ref) });
  }

  method list_dlna_capabilities (:$glist = False, :$raw = False) {
    my $rl = gupnp_device_info_list_dlna_capabilities($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[GUPnPDeviceInfo];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ GUPnP::DeviceInfo.new($_, :!ref) });
  }

  method list_dlna_device_class_identifier (:$glist = False, :$raw = False) {
    my $rl = gupnp_device_info_list_dlna_device_class_identifier($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[Str];
    return $rl if $glist;

    $rl.Array;
  }

  method list_service_types (:$glist = False, :$raw = False) {
    my $rl = gupnp_device_info_list_service_types($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[Str];
    return $rl if $glist;

    $rl.Array;
  }

  method list_services (:$glist = False, :$raw = False) {
    my $rl = gupnp_device_info_list_services($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[GUPnPServiceInfo];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ GUPnP::ServiceInfo.new($_, :!ref) });
  }

}
