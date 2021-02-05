use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Structs;

unit package GUPnP::Raw::DlnaInformation;

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-information.h

sub gupnp_dlna_information_get_audio_information (GUPnPDLNAInformation $info)
  returns GUPnPDLNAAudioInformation
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_information_get_container_information (
  GUPnPDLNAInformation $info
)
  returns GUPnPDLNAContainerInformation
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_information_get_image_information (GUPnPDLNAInformation $info)
  returns GUPnPDLNAImageInformation
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_information_get_profile_name (GUPnPDLNAInformation $info)
  returns Str
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_information_get_uri (GUPnPDLNAInformation $info)
  returns Str
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_information_get_video_information (GUPnPDLNAInformation $info)
  returns GUPnPDLNAVideoInformation
  is native(gupnp-dlna)
  is export
{ * }
