use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Structs;

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-container-information.h

sub gupnp_dlna_container_information_get_mime (
  GUPnPDLNAContainerInformation $info
)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_container_information_get_mpeg_version (
  GUPnPDLNAContainerInformation $info
)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_container_information_get_packet_size (
  GUPnPDLNAContainerInformation $info
)
  returns GUPnPDLNAIntValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_container_information_get_profile (
  GUPnPDLNAContainerInformation $info
)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_container_information_get_type ()
  returns GType
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_container_information_get_variant (
  GUPnPDLNAContainerInformation $info
)
  returns GUPnPDLNAStringValue
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_container_information_is_system_stream (
  GUPnPDLNAContainerInformation $info
)
  returns GUPnPDLNABoolValue
  is native(gupnp-dlna)
  is export
{ * }
