use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Structs;

unit package GUPnP::Raw::DlnaImageInformation;

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-image-information.h

sub gupnp_dlna_image_information_get_depth (GUPnPDLNAImageInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_image_information_get_height (GUPnPDLNAImageInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_image_information_get_mime (GUPnPDLNAImageInformation $info)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_image_information_get_type ()
  returns GType
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_image_information_get_width (GUPnPDLNAImageInformation $info)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }
