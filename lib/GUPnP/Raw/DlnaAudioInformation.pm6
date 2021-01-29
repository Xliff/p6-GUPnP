use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Structs;

unit package GUPnP::Raw::DlnaAudioInformation;

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-audio-information.h

sub gupnp_dlna_audio_information_get_bitrate (GUPnPDLNAAudioInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_channels (GUPnPDLNAAudioInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_depth (GUPnPDLNAAudioInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_layer (GUPnPDLNAAudioInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_level (GUPnPDLNAAudioInformation $info)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_mime (GUPnPDLNAAudioInformation $info)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_mpeg_audio_version (
  GUPnPDLNAAudioInformation $info
)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_mpeg_version (
  GUPnPDLNAAudioInformation $info
)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_profile (GUPnPDLNAAudioInformation $info)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_rate (GUPnPDLNAAudioInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_stream_format (
  GUPnPDLNAAudioInformation $info
)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_type ()
  returns GType
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_audio_information_get_wma_version (
  GUPnPDLNAAudioInformation $info
)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }
