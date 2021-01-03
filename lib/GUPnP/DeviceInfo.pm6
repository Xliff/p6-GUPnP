use v6.c;

use Method::Also;

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
    is also<GUPnPDeviceInfo>
  { $!di }

  method new (GUPnPDeviceInfoAncestry $device-info, :$!ref = True) {
    return Nil unless $device-info;

    my $o = self.bless( :$device-info );
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
  method device-type is rw  is also<device_type> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('device-type', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'device-type is a construct-only attribute'
      }
    );
  }

  # Type: GUPnPXMLDoc
  method document is rw  {
    my $gv = GLib::Value.new( GUPnP::XMLDoc.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('document', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(GUPnPXMLDoc, $o);
        return $o if $raw;

        GUPnP::XMLDoc.new($o, :!ref);
      },
      STORE => -> $,  $val is copy {
        warn 'document is a construct-only attribute'
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

  # Type: GUPnPResourceFactory
  method resource-factory is rw  is also<resource_factory> {
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
      STORE => -> $,  $val is copy {
        warn 'resource-factory is a construct-only attribute'
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
  method url-base is rw  is also<url_base> {
    my $gv = GLib::Value.new( SOUP::URI.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('url-base', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(SOUPUri, $o);
        return $o if $raw;

        SOUP::URI.new($o, :!ref);
      },
      STORE => -> $,  $val is copy {
        warn 'url-base is a construct-only attribute'
      }
    );
  }

  method get_context is also<get-context> {
    gupnp_device_info_get_context($!di);
  }

  method get_description_value (Str() $element)
    is also<get-description-value>
  {
    gupnp_device_info_get_description_value($!di, $element);
  }

  method get_device (Str() $type) is also<get-device> {
    gupnp_device_info_get_device($!di, $type);
  }

  method get_device_type is also<get-device-type> {
    gupnp_device_info_get_device_type($!di);
  }

  method get_friendly_name is also<get-friendly-name> {
    gupnp_device_info_get_friendly_name($!di);
  }

  proto method get_icon_url (|)
      is also<get-icon-url>
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

  method get_location is also<get-location> {
    gupnp_device_info_get_location($!di);
  }

  method get_manufacturer is also<get-manufacturer> {
    gupnp_device_info_get_manufacturer($!di);
  }

  method get_manufacturer_url is also<get-manufacturer-url> {
    gupnp_device_info_get_manufacturer_url($!di);
  }

  method get_model_description is also<get-model-description> {
    gupnp_device_info_get_model_description($!di);
  }

  method get_model_name is also<get-model-name> {
    gupnp_device_info_get_model_name($!di);
  }

  method get_model_number is also<get-model-number> {
    gupnp_device_info_get_model_number($!di);
  }

  method get_model_url is also<get-model-url> {
    gupnp_device_info_get_model_url($!di);
  }

  method get_presentation_url is also<get-presentation-url> {
    gupnp_device_info_get_presentation_url($!di);
  }

  method get_resource_factory is also<get-resource-factory> {
    gupnp_device_info_get_resource_factory($!di);
  }

  method get_serial_number is also<get-serial-number> {
    gupnp_device_info_get_serial_number($!di);
  }

  method get_service (Str() $type, :$raw = False) is also<get-service> {
    my $s = gupnp_device_info_get_service($!di, $type);

    $s ??
      ( $raw ?? $s !! GUPnP::ServiceInfo.new($s, :!ref) )
      !!
      Nil;
  }

  method get_udn is also<get-udn> {
    gupnp_device_info_get_udn($!di);
  }

  method get_upc is also<get-upc> {
    gupnp_device_info_get_upc($!di);
  }

  method get_url_base (:$raw = False) is also<get-url-base> {
    my $ub = gupnp_device_info_get_url_base($!di);

    $ub ??
      ( $raw ?? $ub !! SOUP::URI.new($ub, :!ref) )
      !!
      Nil;
  }

  method list_device_types (:$glist = False, :$raw = False)
    is also<list-device-types>
  {
    my $rl = my $dtl = gupnp_device_info_list_device_types($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[Str];
    return $rl if $glist;

    $rl.Array;
  }

  method list_devices (:$glist = False, :$raw = False) is also<list-devices> {
    my $rl = gupnp_device_info_list_devices($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[GUPnPDeviceInfo];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ GUPnP::DeviceInfo.new($_, :!ref) });
  }

  method list_dlna_capabilities (:$glist = False, :$raw = False)
    is also<list-dlna-capabilities>
  {
    my $rl = gupnp_device_info_list_dlna_capabilities($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[GUPnPDeviceInfo];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ GUPnP::DeviceInfo.new($_, :!ref) });
  }

  method list_dlna_device_class_identifier (:$glist = False, :$raw = False)
    is also<list-dlna-device-class-identifier>
  {
    my $rl = gupnp_device_info_list_dlna_device_class_identifier($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[Str];
    return $rl if $glist;

    $rl.Array;
  }

  method list_service_types (:$glist = False, :$raw = False)
    is also<list-service-types>
  {
    my $rl = gupnp_device_info_list_service_types($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[Str];
    return $rl if $glist;

    $rl.Array;
  }

  method list_services (:$glist = False, :$raw = False)
    is also<list-services>
  {
    my $rl = gupnp_device_info_list_services($!di);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[GUPnPServiceInfo];
    return $rl if $glist;

    $raw ?? $rl.Array !! $rl.Array.map({ GUPnP::ServiceInfo.new($_, :!ref) });
  }

}
