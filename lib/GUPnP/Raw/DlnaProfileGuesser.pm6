use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-profile-guesser.h

sub gupnp_dlna_profile_guesser_cleanup ()
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_get_extended_mode (
  GUPnPDLNAProfileGuesser $guesser
)
  returns uint32
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_get_profile (
  GUPnPDLNAProfileGuesser $guesser,
  Str                     $name
)
  returns GUPnPDLNAProfile
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_get_relaxed_mode (
  GUPnPDLNAProfileGuesser $guesser
)
  returns uint32
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_get_type ()
  returns GType
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_guess_profile_async (
  GUPnPDLNAProfileGuesser $guesser,
  Str                     $uri,
  guint                   $timeout_in_ms,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_guess_profile_from_info (
  GUPnPDLNAProfileGuesser $guesser,
  GUPnPDLNAInformation    $info
)
  returns GUPnPDLNAProfile
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_guess_profile_sync (
  GUPnPDLNAProfileGuesser $guesser,
  Str                     $uri,
  guint                   $timeout_in_ms,
  GUPnPDLNAInformation    $dlna_info,
  CArray[Pointer[GError]] $error
)
  returns GUPnPDLNAProfile
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_list_profiles (GUPnPDLNAProfileGuesser $guesser)
  returns GList
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_profile_guesser_new (
  gboolean $relaxed_mode,
  gboolean $extended_mode
)
  returns GUPnPDLNAProfileGuesser
  is native(gupnp-dlna)
  is export
{ * }
