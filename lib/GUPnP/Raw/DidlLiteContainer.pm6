use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::DidlLiteContainer;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-didl-lite-container.h

sub gupnp_didl_lite_container_add_create_class (
  GUPnPDIDLLiteContainer $container,
  Str                    $create_class
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_add_create_class_full (
  GUPnPDIDLLiteContainer $container,
  Str                    $create_class,
  gboolean               $include_derived
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_add_search_class (
  GUPnPDIDLLiteContainer $container,
  Str                    $search_class
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_add_search_class_full (
  GUPnPDIDLLiteContainer $container,
  Str                    $search_class,
  gboolean               $include_derived
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_container_update_id_is_set (
  GUPnPDIDLLiteContainer $container
)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_get_child_count (
  GUPnPDIDLLiteContainer $container
)
  returns gint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_get_container_update_id (
  GUPnPDIDLLiteContainer $container
)
  returns guint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_get_create_classes (
  GUPnPDIDLLiteContainer $container
)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_get_create_classes_full (
  GUPnPDIDLLiteContainer $container
)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_get_search_classes (
  GUPnPDIDLLiteContainer $container
)
  returns GList
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_get_storage_used (
  GUPnPDIDLLiteContainer $container
)
  returns gint64
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_get_total_deleted_child_count (
  GUPnPDIDLLiteContainer $container
)
  returns guint
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_set_child_count (
  GUPnPDIDLLiteContainer $container,
  gint $child_count
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_set_container_update_id (
  GUPnPDIDLLiteContainer $container,
  guint $update_id
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_set_searchable (
  GUPnPDIDLLiteContainer $container,
  gboolean $searchable
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_set_storage_used (
  GUPnPDIDLLiteContainer $container,
  gint64 $storage_used
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_set_total_deleted_child_count (
  GUPnPDIDLLiteContainer $container,
  guint $count
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_total_deleted_child_count_is_set (
  GUPnPDIDLLiteContainer $container
)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_unset_container_update_id (
  GUPnPDIDLLiteContainer $container
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_container_unset_total_deleted_child_count (
  GUPnPDIDLLiteContainer $container
)
  is native(gupnp-av)
  is export
{ * }
