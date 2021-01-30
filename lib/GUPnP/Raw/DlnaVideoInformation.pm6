use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Structs;

unit package GUPnP::Raw::DlnaVideoInformation;

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-video-information.h

sub gupnp_dlna_video_information_get_bitrate (GUPnPDLNAVideoInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_framerate (
  GUPnPDLNAVideoInformation $info
)
  returns GUPnPDLNAFractionValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_height (GUPnPDLNAVideoInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_level (GUPnPDLNAVideoInformation $info)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_mime (GUPnPDLNAVideoInformation $info)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_mpeg_version (
  GUPnPDLNAVideoInformation $info
)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_pixel_aspect_ratio (
  GUPnPDLNAVideoInformation $info
)
  returns GUPnPDLNAFractionValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_profile (GUPnPDLNAVideoInformation $info)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_type ()
  returns GType
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_get_width (GUPnPDLNAVideoInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_is_interlaced (
  GUPnPDLNAVideoInformation $info
)
  returns GUPnPDLNABoolValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_video_information_is_system_stream (
  GUPnPDLNAVideoInformation $info
)
  returns GUPnPDLNABoolValue
  is native(gupnp-dlna)
  is export
{ * }
