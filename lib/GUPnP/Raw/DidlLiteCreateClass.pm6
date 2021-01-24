use v6.c;

use NativeCall;

use LibXML::Raw;
use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Structs;

unit package GUPnP::Raw::DidlLiteCreateClass;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-didl-lite-createclass.h

sub gupnp_didl_lite_create_class_get_content (
  GUPnPDIDLLiteCreateClass $create_class
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_create_class_get_friendly_name (
  GUPnPDIDLLiteCreateClass $create_class
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_create_class_get_include_derived (
  GUPnPDIDLLiteCreateClass $create_class
)
  returns uint32
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_create_class_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_create_class_get_xml_node (
  GUPnPDIDLLiteCreateClass $create_class
)
  returns xmlNode
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_create_class_set_content (
  GUPnPDIDLLiteCreateClass $create_class,
  Str                      $content
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_create_class_set_friendly_name (
  GUPnPDIDLLiteCreateClass $create_class,
  Str                      $friendly_name
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_create_class_set_include_derived (
  GUPnPDIDLLiteCreateClass $create_class,
  gboolean                 $include_derived
)
  is native(gupnp-av)
  is export
{ * }
