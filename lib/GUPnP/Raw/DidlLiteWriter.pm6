use v6.c;

use NativeCall;

use LibXML::Raw;
use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::DidlLiteWriter;


### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-didl-lite-writer.h

sub gupnp_didl_lite_writer_add_container (GUPnPDIDLLiteWriter $writer)
  returns GUPnPDIDLLiteContainer
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_writer_add_descriptor (GUPnPDIDLLiteWriter $writer)
  returns GUPnPDIDLLiteDescriptor
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_writer_add_item (GUPnPDIDLLiteWriter $writer)
  returns GUPnPDIDLLiteItem
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_writer_filter (GUPnPDIDLLiteWriter $writer, Str $filter)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_writer_get_language (GUPnPDIDLLiteWriter $writer)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_writer_get_string (GUPnPDIDLLiteWriter $writer)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_writer_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_writer_get_xml_node (GUPnPDIDLLiteWriter $writer)
  returns xmlNode
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_writer_new (Str $language)
  returns GUPnPDIDLLiteWriter
  is native(gupnp-av)
  is export
{ * }
