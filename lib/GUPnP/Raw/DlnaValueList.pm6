use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::DlnaValueList;

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-value-list.h

sub gupnp_dlna_value_list_copy (GUPnPDLNAValueList $list)
  returns GUPnPDLNAValueList
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_value_list_free (GUPnPDLNAValueList $list)
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_value_list_get_g_values (GUPnPDLNAValueList $list)
  returns GList
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_value_list_get_type ()
  returns GType
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_value_list_is_empty (GUPnPDLNAValueList $list)
  returns uint32
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_value_list_to_string (GUPnPDLNAValueList $list)
  returns Str
  is native(gupnp-dlna)
  is export
{ * }
