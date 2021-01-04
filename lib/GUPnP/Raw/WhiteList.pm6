use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::WhiteList;

### /usr/include/gupnp-1.2/libgupnp/gupnp-white-list.h

sub gupnp_white_list_add_entry (GUPnPWhiteList $white_list, Str $entry)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_add_entryv (
  GUPnPWhiteList $white_list,
  CArray[Str]    $entries
)
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_check_context (
  GUPnPWhiteList $white_list,
  GUPnPContext   $context
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_clear (GUPnPWhiteList $white_list)
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_get_enabled (GUPnPWhiteList $white_list)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_get_entries (GUPnPWhiteList $white_list)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_is_empty (GUPnPWhiteList $white_list)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_new ()
  returns GUPnPWhiteList
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_remove_entry (GUPnPWhiteList $white_list, Str $entry)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_white_list_set_enabled (GUPnPWhiteList $white_list, gboolean $enable)
  is native(gupnp)
  is export
{ * }
