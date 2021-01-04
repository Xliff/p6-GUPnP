use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GSSDP::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::RootDevice;

### /usr/include/gupnp-1.2/libgupnp/gupnp-root-device.h

sub gupnp_root_device_get_available (GUPnPRootDevice $root_device)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_root_device_get_description_dir (GUPnPRootDevice $root_device)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_root_device_get_description_path (GUPnPRootDevice $root_device)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_root_device_get_relative_location (GUPnPRootDevice $root_device)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_root_device_get_ssdp_resource_group (GUPnPRootDevice $root_device)
  returns GSSDPResourceGroup
  is native(gupnp)
  is export
{ * }

sub gupnp_root_device_new (
  GUPnPContext            $context,
  Str                     $description_path,
  Str                     $description_dir,
  CArray[Pointer[GError]] $error
)
  returns GUPnPRootDevice
  is native(gupnp)
  is export
{ * }

sub gupnp_root_device_new_full (
  GUPnPContext            $context,
  GUPnPResourceFactory    $factory,
  GUPnPXMLDoc             $description_doc,
  Str                     $description_path,
  Str                     $description_dir,
  CArray[Pointer[GError]] $error
)
  returns GUPnPRootDevice
  is native(gupnp)
  is export
{ * }

sub gupnp_root_device_set_available (
  GUPnPRootDevice $root_device,
  gboolean        $available
)
  is native(gupnp)
  is export
{ * }
