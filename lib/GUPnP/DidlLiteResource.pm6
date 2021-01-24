use v6.c;

use Method::Also;

use LibXML::Raw;
use GUPnP::Raw::Types;
use GUPnP::Raw::DidlLiteResource;

use GLib::Roles::Object;

our subset GUPnPDIDLLiteResourceAncestry is export of Mu
  where GUPnPDIDLLiteResource | GObject;

class GUPnP::DidlLiteResource {
  also does GLib::Roles::Object;

  has GUPnPDIDLLiteResource $!dlr;

  submethod BUILD (:$resource) {
    self.setGUPnPDIDLLiteResource($resource) if $resource;
  }

  method setGUPnPDIDLLiteResource (GUPnPDIDLLiteResourceAncestry $_) {
    my $to-parent;

    $!dlr = do {
      when GUPnPDIDLLiteResource {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDIDLLiteResource, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDIDLLiteResource
    is also<GUPnPDIDLLiteResource>
  { $!dlr }

  method new (GUPnPDIDLLiteResourceAncestry $resource, :$ref = True) {
    return Nil unless $resource;

    my $o = self.bless( :$resource );
    $o.ref if $ref;
    $o;
  }

  # Type: gint
  method audio-channels is rw  is also<audio_channels> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('audio-channels', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('audio-channels', $gv);
      }
    );
  }

  # Type: gint
  method bitrate is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('bitrate', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('bitrate', $gv);
      }
    );
  }

  # Type: gint
  method bits-per-sample is rw  is also<bits_per_sample> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('bits-per-sample', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('bits-per-sample', $gv);
      }
    );
  }

  # Type: gint
  method color-depth is rw  is also<color_depth> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('color-depth', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('color-depth', $gv);
      }
    );
  }

  # Type: glong
  method duration is rw  {
    my $gv = GLib::Value.new( G_TYPE_LONG );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('duration', $gv)
        );
        $gv.long;
      },
      STORE => -> $, Int() $val is copy {
        $gv.long = $val;
        self.prop_set('duration', $gv);
      }
    );
  }

  # Type: gint
  method height is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('height', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  # Type: gchar
  method import-uri is rw  is also<import_uri> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('import-uri', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('import-uri', $gv);
      }
    );
  }

  # Type: gchar
  method protection is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('protection', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('protection', $gv);
      }
    );
  }

  # Type: GUPnPProtocolInfo
  method protocol-info (:$raw = False) is rw is also<protocol_info> {
    my $gv = GLib::Value.new( GUPnP::ProtocolInfo.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('protocol-info', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(GUPnPProtocolInfo, $o);
        return $o if $raw;

        GUPnP::ProtocolInfo.new($o, :!ref);
      },
      STORE => -> $, GUPnPProtocolInfo() $val is copy {
        $gv.object = $val;
        self.prop_set('protocol-info', $gv);
      }
    );
  }

  # Type: gint
  method sample-freq is rw  is also<sample_freq> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('sample-freq', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('sample-freq', $gv);
      }
    );
  }

  # Type: glong
  method size is rw  {
    my $gv = GLib::Value.new( G_TYPE_LONG );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('size', $gv)
        );
        $gv.long;
      },
      STORE => -> $, Int() $val is copy {
        $gv.long = $val;
        self.prop_set('size', $gv);
      }
    );
  }

  # Type: gint64
  method size64 is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('size64', $gv)
        );
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('size64', $gv);
      }
    );
  }

  # Type: guint
  method update-count is rw  is also<update_count> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('update-count', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('update-count', $gv);
      }
    );
  }

  # Type: gchar
  method uri is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('uri', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('uri', $gv);
      }
    );
  }

  # Type: gint
  method width is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('width', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  # Type: gpointer (xmlNode)
  method xml-node is rw  is also<xml_node> {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('xml-node', $gv)
        );

        my $p = $gv.p;
        return Nil unless $p;
        cast(xmlNode, $p);
      },
      STORE => -> $, $val is copy {
        warn 'xml-node is a construct-only attribute'
      }
    );
  }

  method get_audio_channels is also<get-audio-channels> {
    gupnp_didl_lite_resource_get_audio_channels($!dlr);
  }

  method get_bitrate is also<get-bitrate> {
    gupnp_didl_lite_resource_get_bitrate($!dlr);
  }

  method get_bits_per_sample is also<get-bits-per-sample> {
    gupnp_didl_lite_resource_get_bits_per_sample($!dlr);
  }

  method get_cleartext_size is also<get-cleartext-size> {
    gupnp_didl_lite_resource_get_cleartext_size($!dlr);
  }

  method get_color_depth is also<get-color-depth> {
    gupnp_didl_lite_resource_get_color_depth($!dlr);
  }

  method get_dlna_namespace is also<get-dlna-namespace> {
    gupnp_didl_lite_resource_get_dlna_namespace($!dlr);
  }

  method get_duration is also<get-duration> {
    gupnp_didl_lite_resource_get_duration($!dlr);
  }

  method get_height is also<get-height> {
    gupnp_didl_lite_resource_get_height($!dlr);
  }

  method get_import_uri is also<get-import-uri> {
    gupnp_didl_lite_resource_get_import_uri($!dlr);
  }

  method get_protection is also<get-protection> {
    gupnp_didl_lite_resource_get_protection($!dlr);
  }

  method get_protocol_info is also<get-protocol-info> {
    gupnp_didl_lite_resource_get_protocol_info($!dlr);
  }

  method get_pv_namespace is also<get-pv-namespace> {
    gupnp_didl_lite_resource_get_pv_namespace($!dlr);
  }

  method get_sample_freq is also<get-sample-freq> {
    gupnp_didl_lite_resource_get_sample_freq($!dlr);
  }

  method get_size is also<get-size> {
    gupnp_didl_lite_resource_get_size($!dlr);
  }

  method get_size64 is also<get-size64> {
    gupnp_didl_lite_resource_get_size64($!dlr);
  }

  method get_subtitle_file_type is also<get-subtitle-file-type> {
    gupnp_didl_lite_resource_get_subtitle_file_type($!dlr);
  }

  method get_subtitle_file_uri is also<get-subtitle-file-uri> {
    gupnp_didl_lite_resource_get_subtitle_file_uri($!dlr);
  }

  method get_track_total is also<get-track-total> {
    gupnp_didl_lite_resource_get_track_total($!dlr);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_didl_lite_resource_get_type,
      $n,
      $t
    );
  }

  method get_update_count is also<get-update-count> {
    gupnp_didl_lite_resource_get_update_count($!dlr);
  }

  method get_uri is also<get-uri> {
    gupnp_didl_lite_resource_get_uri($!dlr);
  }

  method get_width is also<get-width> {
    gupnp_didl_lite_resource_get_width($!dlr);
  }

  method get_xml_node is also<get-xml-node> {
    gupnp_didl_lite_resource_get_xml_node($!dlr);
  }

  method set_audio_channels (Int() $n_channels) is also<set-audio-channels> {
    my gint $n = $n_channels;
    gupnp_didl_lite_resource_set_audio_channels($!dlr, $n);
  }

  method set_bitrate (Int() $bitrate) is also<set-bitrate> {
    my gint $b = $bitrate;
    gupnp_didl_lite_resource_set_bitrate($!dlr, $b);
  }

  method set_bits_per_sample (Int() $sample_size)
    is also<set-bits-per-sample>
  {
    my gint $s = $sample_size;
    gupnp_didl_lite_resource_set_bits_per_sample($!dlr, $s);
  }

  method set_cleartext_size (Int() $cleartext_size)
    is also<set-cleartext-size>
  {
    my gint64 $c = $cleartext_size;
    gupnp_didl_lite_resource_set_cleartext_size($!dlr, $c);
  }

  method set_color_depth (Int() $color_depth) is also<set-color-depth> {
    my gint $c = $color_depth;
    gupnp_didl_lite_resource_set_color_depth($!dlr, $c);
  }

  method set_duration (Int() $duration) is also<set-duration> {
    my glong $d = $duration;
    gupnp_didl_lite_resource_set_duration($!dlr, $d);
  }

  method set_height (Int() $height) is also<set-height> {
    my gint $h = $height;
    gupnp_didl_lite_resource_set_height($!dlr, $h);
  }

  method set_import_uri (Str() $import_uri) is also<set-import-uri> {
    gupnp_didl_lite_resource_set_import_uri($!dlr, $import_uri);
  }

  method set_protection (Str() $protection) is also<set-protection> {
    gupnp_didl_lite_resource_set_protection($!dlr, $protection);
  }

  method set_protocol_info (GUPnPProtocolInfo() $info)
    is also<set-protocol-info>
  {
    gupnp_didl_lite_resource_set_protocol_info($!dlr, $info);
  }

  method set_sample_freq (Int() $sample_freq) is also<set-sample-freq> {
    my gint $s = $sample_freq;
    gupnp_didl_lite_resource_set_sample_freq($!dlr, $s);
  }

  method set_size (Int() $size) is also<set-size> {
    my glong $s = $size;
    gupnp_didl_lite_resource_set_size($!dlr, $s);
  }

  method set_size64 (Int() $size) is also<set-size64> {
    my gint64 $s = $size;
    gupnp_didl_lite_resource_set_size64($!dlr, $s);
  }

  method set_subtitle_file_type (Str() $type) is also<set-subtitle-file-type> {
    gupnp_didl_lite_resource_set_subtitle_file_type($!dlr, $type);
  }

  method set_subtitle_file_uri (Str() $uri) is also<set-subtitle-file-uri> {
    gupnp_didl_lite_resource_set_subtitle_file_uri($!dlr, $uri);
  }

  method set_track_total (Int() $track_total) is also<set-track-total> {
    my guint $t = $track_total;
    gupnp_didl_lite_resource_set_track_total($!dlr, $t);
  }

  method set_update_count (Int() $update_count) is also<set-update-count> {
    my guint $u = $update_count;
    gupnp_didl_lite_resource_set_update_count($!dlr, $u);
  }

  method set_uri (Str() $uri) is also<set-uri> {
    gupnp_didl_lite_resource_set_uri($!dlr, $uri);
  }

  method set_width (Int() $width) is also<set-width> {
    my gint $w = $width;
    gupnp_didl_lite_resource_set_width($!dlr, $w);
  }

  method track_total_is_set is also<track-total-is-set> {
    so gupnp_didl_lite_resource_track_total_is_set($!dlr);
  }

  method unset_track_total is also<unset-track-total> {
    gupnp_didl_lite_resource_unset_track_total($!dlr);
  }

  method unset_update_count is also<unset-update-count> {
    gupnp_didl_lite_resource_unset_update_count($!dlr);
  }

  method update_count_is_set is also<update-count-is-set> {
    gupnp_didl_lite_resource_update_count_is_set($!dlr);
  }

}
