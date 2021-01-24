use v6.c;

use NativeCall;

use LibXML::Raw;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Enums;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-didl-lite-object.h

sub gupnp_didl_lite_object_add_artist (GUPnPDIDLLiteObject $object)
  returns GUPnPDIDLLiteContributor
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_add_author (GUPnPDIDLLiteObject $object)
  returns GUPnPDIDLLiteContributor
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_add_creator (GUPnPDIDLLiteObject $object)
  returns GUPnPDIDLLiteContributor
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_add_descriptor (GUPnPDIDLLiteObject $object)
  returns GUPnPDIDLLiteDescriptor
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_add_resource (GUPnPDIDLLiteObject $object)
  returns GUPnPDIDLLiteResource
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_apply_fragments (
  GUPnPDIDLLiteObject $object,
  CArray[Str]         $current_fragments,
  gint                $current_size,
  CArray[Str]         $new_fragments,
  gint                $new_size
)
  returns GUPnPDIDLLiteFragmentResult
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_album (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_album_art (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_album_xml_string (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_artist (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_artists (GUPnPDIDLLiteObject $object)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_artists_xml_string (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_author (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_authors (GUPnPDIDLLiteObject $object)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_compat_resource (
  GUPnPDIDLLiteObject $object,
  Str                 $sink_protocol_info,
  gboolean            $lenient
)
  returns GUPnPDIDLLiteResource
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_creator (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_creators (GUPnPDIDLLiteObject $object)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_date (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_date_xml_string (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_dc_namespace (GUPnPDIDLLiteObject $object)
  returns Pointer # xmlNsPtr
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_description (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_descriptors (GUPnPDIDLLiteObject $object)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_dlna_managed (GUPnPDIDLLiteObject $object)
  returns GUPnPOCMFlags
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_dlna_namespace (GUPnPDIDLLiteObject $object)
  returns Pointer # xmlNsPtr
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_genre (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_id (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_parent_id (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_properties (
  GUPnPDIDLLiteObject $object,
  Str                 $name
)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_pv_namespace (GUPnPDIDLLiteObject $object)
  returns Pointer # xmlNsPtr
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_resources (GUPnPDIDLLiteObject $object)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_restricted (GUPnPDIDLLiteObject $object)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_title (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_title_xml_string (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_track_number (GUPnPDIDLLiteObject $object)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_track_number_xml_string (
  GUPnPDIDLLiteObject $object
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_update_id (GUPnPDIDLLiteObject $object)
  returns guint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_upnp_class (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_upnp_class_xml_string (
  GUPnPDIDLLiteObject $object
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_upnp_namespace (GUPnPDIDLLiteObject $object)
  returns Pointer # xmlNsPtr
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_write_status (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_xml_node (GUPnPDIDLLiteObject $object)
  returns xmlNode
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_get_xml_string (GUPnPDIDLLiteObject $object)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_is_restricted_set (GUPnPDIDLLiteObject $object)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_album (GUPnPDIDLLiteObject $object, Str $album)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_album_art (
  GUPnPDIDLLiteObject $object,
  Str                 $album_art
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_artist (GUPnPDIDLLiteObject $object, Str $artist)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_author (GUPnPDIDLLiteObject $object, Str $author)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_creator (
  GUPnPDIDLLiteObject $object,
  Str                 $creator
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_date (GUPnPDIDLLiteObject $object, Str $date)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_description (
  GUPnPDIDLLiteObject $object,
  Str                 $description
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_dlna_managed (
  GUPnPDIDLLiteObject $object,
  GUPnPOCMFlags       $dlna_managed
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_genre (GUPnPDIDLLiteObject $object, Str $genre)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_id (GUPnPDIDLLiteObject $object, Str $id)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_parent_id (
  GUPnPDIDLLiteObject $object,
  Str                 $parent_id
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_restricted (
  GUPnPDIDLLiteObject $object,
  gboolean            $restricted
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_title (GUPnPDIDLLiteObject $object, Str $title)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_track_number (
  GUPnPDIDLLiteObject $object,
  gint                $track_number
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_update_id (
  GUPnPDIDLLiteObject $object,
  guint               $update_id
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_upnp_class (
  GUPnPDIDLLiteObject $object,
  Str                 $upnp_class
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_set_write_status (
  GUPnPDIDLLiteObject $object,
  Str                 $write_status
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_unset_artists (GUPnPDIDLLiteObject $object)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_unset_update_id (GUPnPDIDLLiteObject $object)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_object_update_id_is_set (GUPnPDIDLLiteObject $object)
  returns uint32
  is native(gupnp-av)
  is export
{ * }
