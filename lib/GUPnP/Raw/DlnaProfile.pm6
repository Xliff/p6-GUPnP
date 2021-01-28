use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::DlnaProfile;

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-profile.h

sub gupnp_dlna_profile_get_audio_restrictions (GUPnPDLNAProfile $profile)
  returns GList
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_get_container_restrictions (GUPnPDLNAProfile $profile)
  returns GList
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_get_extended (GUPnPDLNAProfile $profile)
  returns uint32
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_get_image_restrictions (GUPnPDLNAProfile $profile)
  returns GList
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_get_mime (GUPnPDLNAProfile $profile)
  returns Str
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_get_name (GUPnPDLNAProfile $profile)
  returns Str
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_get_type ()
  returns GType
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_get_video_restrictions (GUPnPDLNAProfile $profile)
  returns GList
  is native(gupnp-dlna)
  is export
{ * }
