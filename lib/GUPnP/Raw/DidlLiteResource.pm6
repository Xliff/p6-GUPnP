use v6.c;

use NativeCall;

use LibXML::Raw;
use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::DidlLiteResource;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-didl-lite-resource.h

sub gupnp_didl_lite_resource_get_audio_channels (
  GUPnPDIDLLiteResource $resource
)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_bitrate (GUPnPDIDLLiteResource $resource)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_bits_per_sample (
  GUPnPDIDLLiteResource $resource
)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_cleartext_size (
  GUPnPDIDLLiteResource $resource
)
  returns gint64
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_color_depth (GUPnPDIDLLiteResource $resource)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_dlna_namespace (
  GUPnPDIDLLiteResource $resource
)
  returns Pointer # xmlNsPtr
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_duration (GUPnPDIDLLiteResource $resource)
  returns long
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_height (GUPnPDIDLLiteResource $resource)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_import_uri (GUPnPDIDLLiteResource $resource)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_protection (GUPnPDIDLLiteResource $resource)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_protocol_info (GUPnPDIDLLiteResource $resource)
  returns GUPnPProtocolInfo
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_pv_namespace (GUPnPDIDLLiteResource $resource)
  returns Pointer # xmlNsPtr
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_sample_freq (GUPnPDIDLLiteResource $resource)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_size (GUPnPDIDLLiteResource $resource)
  returns long
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_size64 (GUPnPDIDLLiteResource $resource)
  returns gint64
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_subtitle_file_type (
  GUPnPDIDLLiteResource $resource
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_subtitle_file_uri (
  GUPnPDIDLLiteResource $resource
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_track_total (GUPnPDIDLLiteResource $resource)
  returns guint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_update_count (GUPnPDIDLLiteResource $resource)
  returns guint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_uri (GUPnPDIDLLiteResource $resource)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_width (GUPnPDIDLLiteResource $resource)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_get_xml_node (GUPnPDIDLLiteResource $resource)
  returns xmlNode
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_audio_channels (
  GUPnPDIDLLiteResource $resource,
  gint                  $n_channels
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_bitrate (
  GUPnPDIDLLiteResource $resource,
  gint                  $bitrate
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_bits_per_sample (
  GUPnPDIDLLiteResource $resource,
  gint                  $sample_size
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_cleartext_size (
  GUPnPDIDLLiteResource $resource,
  gint64                $cleartext_size
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_color_depth (
  GUPnPDIDLLiteResource $resource,
  gint $color_depth
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_duration (
  GUPnPDIDLLiteResource $resource,
  glong                 $duration
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_height (
  GUPnPDIDLLiteResource $resource,
  gint                  $height
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_import_uri (
  GUPnPDIDLLiteResource $resource,
  Str                   $import_uri
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_protection (
  GUPnPDIDLLiteResource $resource,
  Str                   $protection
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_protocol_info (
  GUPnPDIDLLiteResource $resource,
  GUPnPProtocolInfo     $info
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_sample_freq (
  GUPnPDIDLLiteResource $resource,
  gint                  $sample_freq
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_size (
  GUPnPDIDLLiteResource $resource,
  glong                 $size
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_size64 (
  GUPnPDIDLLiteResource $resource,
  gint64                $size
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_subtitle_file_type (
  GUPnPDIDLLiteResource $resource,
  Str                   $type
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_subtitle_file_uri (
  GUPnPDIDLLiteResource $resource,
  Str                   $uri
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_track_total (
  GUPnPDIDLLiteResource $resource,
  guint                 $track_total
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_update_count (
  GUPnPDIDLLiteResource $resource,
  guint                 $update_count
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_uri (GUPnPDIDLLiteResource $resource, Str $uri)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_set_width (
  GUPnPDIDLLiteResource $resource,
  gint                  $width
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_track_total_is_set (
  GUPnPDIDLLiteResource $resource
)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_unset_track_total (
  GUPnPDIDLLiteResource $resource
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_unset_update_count (
  GUPnPDIDLLiteResource $resource
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_resource_update_count_is_set (
  GUPnPDIDLLiteResource $resource
)
  returns uint32
  is native(gupnp-av)
  is export
{ * }
