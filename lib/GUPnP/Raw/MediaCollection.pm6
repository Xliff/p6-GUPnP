use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::MediaCollection;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-media-collection.h

sub gupnp_media_collection_add_item (GUPnPMediaCollection $collection)
  returns GUPnPDIDLLiteItem
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_get_author (GUPnPMediaCollection $collection)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_get_items (GUPnPMediaCollection $collection)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_get_mutable (GUPnPMediaCollection $collection)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_get_string (GUPnPMediaCollection $collection)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_get_title (GUPnPMediaCollection $collection)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_new ()
  returns GUPnPMediaCollection
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_new_from_string (Str $data)
  returns GUPnPMediaCollection
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_set_author (
  GUPnPMediaCollection $collection,
  Str $author
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_media_collection_set_title (
  GUPnPMediaCollection $collection,
  Str $title
)
  is native(gupnp-av)
  is export
{ * }
