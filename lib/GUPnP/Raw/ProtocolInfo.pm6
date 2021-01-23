use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Enums;
use GUPnP::Raw::Structs;

unit package GUPnP::Raw::ProtocolInfo;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-protocol-info.h

sub gupnp_protocol_info_get_dlna_conversion (GUPnPProtocolInfo $info)
  returns GUPnPDLNAConversion
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_get_dlna_flags (GUPnPProtocolInfo $info)
  returns GUPnPDLNAFlags
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_get_dlna_operation (GUPnPProtocolInfo $info)
  returns GUPnPDLNAOperation
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_get_dlna_profile (GUPnPProtocolInfo $info)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_get_mime_type (GUPnPProtocolInfo $info)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_get_network (GUPnPProtocolInfo $info)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_get_play_speeds (GUPnPProtocolInfo $info)
  returns CArray[Str]
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_get_protocol (GUPnPProtocolInfo $info)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_is_compatible (
  GUPnPProtocolInfo $info1,
  GUPnPProtocolInfo $info2
)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_new ()
  returns GUPnPProtocolInfo
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_new_from_string (
  Str                     $protocol_info,
  CArray[Pointer[GError]] $error
)
  returns GUPnPProtocolInfo
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_set_dlna_conversion (
  GUPnPProtocolInfo  $info,
  GUPnPDLNAConversion $conversion
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_set_dlna_flags (
  GUPnPProtocolInfo $info,
  GUPnPDLNAFlags    $flags
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_set_dlna_operation (
  GUPnPProtocolInfo  $info,
  GUPnPDLNAOperation $operation
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_set_dlna_profile (GUPnPProtocolInfo $info, Str $profile)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_set_mime_type (GUPnPProtocolInfo $info, Str $mime_type)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_set_network (GUPnPProtocolInfo $info, Str $network)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_set_play_speeds (
  GUPnPProtocolInfo $info,
  CArray[Str]       $speeds
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_set_protocol (GUPnPProtocolInfo $info, Str $protocol)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_protocol_info_to_string (GUPnPProtocolInfo $info)
  returns Str
  is native(gupnp-av)
  is export
{ * }
