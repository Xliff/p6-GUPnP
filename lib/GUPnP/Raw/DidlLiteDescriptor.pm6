use v6.c;

use NativeCall;

use LibXML::Raw;
use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-didl-lite-descriptor.h

sub gupnp_didl_lite_descriptor_get_content (
  GUPnPDIDLLiteDescriptor $descriptor
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_get_id (GUPnPDIDLLiteDescriptor $descriptor)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_get_metadata_type (
  GUPnPDIDLLiteDescriptor $descriptor
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_get_name_space (
  GUPnPDIDLLiteDescriptor $descriptor
)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_get_xml_node (
  GUPnPDIDLLiteDescriptor $descriptor
)
  returns xmlNode
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_new ()
  returns GUPnPDIDLLiteDescriptor
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_set_content (
  GUPnPDIDLLiteDescriptor $descriptor,
  Str                     $content
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_set_id (
  GUPnPDIDLLiteDescriptor $descriptor,
  Str                     $id
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_set_metadata_type (
  GUPnPDIDLLiteDescriptor $descriptor,
  Str                     $type
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_descriptor_set_name_space (
  GUPnPDIDLLiteDescriptor $descriptor,
  Str                     $name_space
)
  is native(gupnp-av)
  is export
{ * }
