use v6.c;

use NativeCall;

use LibXML::Raw;
use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::DidlLiteContributor;

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-didl-lite-contributor.h

sub gupnp_didl_lite_contributor_get_name (GUPnPDIDLLiteContributor $contributor)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_contributor_get_role (GUPnPDIDLLiteContributor $contributor)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_contributor_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_contributor_get_xml_node (
  GUPnPDIDLLiteContributor $contributor
)
  returns xmlNode
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_contributor_set_name (
  GUPnPDIDLLiteContributor $contributor,
  Str $name
)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_contributor_set_role (
  GUPnPDIDLLiteContributor $contributor,
  Str $role
)
  is native(gupnp-av)
  is export
{ * }
