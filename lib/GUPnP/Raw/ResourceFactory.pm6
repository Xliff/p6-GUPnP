use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::ResourceFactory;

### /usr/include/gupnp-1.2/libgupnp/gupnp-resource-factory.h

sub gupnp_resource_factory_get_default ()
  returns GUPnPResourceFactory
  is native(gupnp)
  is export
{ * }

sub gupnp_resource_factory_new ()
  returns GUPnPResourceFactory
  is native(gupnp)
  is export
{ * }

sub gupnp_resource_factory_register_resource_proxy_type (
  GUPnPResourceFactory $factory,
  Str                  $upnp_type, 
  GType                $type
)
  is native(gupnp)
  is export
{ * }

sub gupnp_resource_factory_register_resource_type (
  GUPnPResourceFactory $factory,
  Str                  $upnp_type,
  GType                $type
)
  is native(gupnp)
  is export
{ * }

sub gupnp_resource_factory_unregister_resource_proxy_type (
  GUPnPResourceFactory $factory,
  Str                  $upnp_type
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_resource_factory_unregister_resource_type (
  GUPnPResourceFactory $factory,
  Str                  $upnp_type
)
  returns uint32
  is native(gupnp)
  is export
{ * }
