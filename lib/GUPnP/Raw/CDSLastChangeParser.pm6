use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Enums;
use GUPnP::Raw::Structs;

unit package GUPnP::Raw::CDSLastChangeParser;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-cds-last-change-parser.h

sub gupnp_cds_last_change_entry_get_class (GUPnPCDSLastChangeEntry $entry)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_entry_get_event (GUPnPCDSLastChangeEntry $entry)
  returns GUPnPCDSLastChangeEvent
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_entry_get_object_id (GUPnPCDSLastChangeEntry $entry)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_entry_get_parent_id (GUPnPCDSLastChangeEntry $entry)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_entry_get_update_id (GUPnPCDSLastChangeEntry $entry)
  returns guint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_parser_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_parser_new ()
  returns GUPnPCDSLastChangeParser  
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_parser_parse (
  GUPnPCDSLastChangeParser $parser,
  Str                      $last_change,
  CArray[Pointer[GError]]  $error
)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_entry_is_subtree_update (
  GUPnPCDSLastChangeEntry $entry
)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_entry_ref (GUPnPCDSLastChangeEntry $entry)
  returns GUPnPCDSLastChangeEntry
  is native(gupnp-av)
  is export
{ * }

sub gupnp_cds_last_change_entry_unref (GUPnPCDSLastChangeEntry $entry)
  is native(gupnp-av)
  is export
{ * }
