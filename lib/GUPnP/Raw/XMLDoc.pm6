use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;
use LibXML::Raw;

unit package GUPnP::Raw::XMLDoc;

### /usr/include/gupnp-1.2/libgupnp/gupnp-xml-doc.h

sub gupnp_xml_doc_get_doc (GUPnPXMLDoc $xml_doc)
  returns xmlDoc
  is native(gupnp)
  is export
{ * }

sub gupnp_xml_doc_new (xmlDoc $xml_doc)
  returns GUPnPXMLDoc
  is native(gupnp)
  is export
{ * }

sub gupnp_xml_doc_new_from_path (Str $path, CArray[Pointer[GError]] $error)
  returns GUPnPXMLDoc
  is native(gupnp)
  is export
{ * }
