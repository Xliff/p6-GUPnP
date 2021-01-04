use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GIO::Raw::Enums;
use GSSDP::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::ContextManager;

### /usr/include/gupnp-1.2/libgupnp/gupnp-context-manager.h

sub gupnp_context_manager_create (guint $port)
  returns GUPnPContextManager
  is native(gupnp)
  is export
{ * }

sub gupnp_context_manager_create_full (
  GSSDPUDAVersion $uda_version,
  GSocketFamily   $family,
  guint           $port
)
  returns GUPnPContextManager
  is native(gupnp)
  is export
{ * }

sub gupnp_context_manager_get_port (GUPnPContextManager $manager)
  returns guint
  is native(gupnp)
  is export
{ * }

sub gupnp_context_manager_get_socket_family (GUPnPContextManager $manager)
  returns GSocketFamily
  is native(gupnp)
  is export
{ * }

sub gupnp_context_manager_get_uda_version (GUPnPContextManager $manager)
  returns GSSDPUDAVersion
  is native(gupnp)
  is export
{ * }

sub gupnp_context_manager_get_white_list (GUPnPContextManager $manager)
  returns GUPnPWhiteList
  is native(gupnp)
  is export
{ * }

sub gupnp_context_manager_manage_control_point (
  GUPnPContextManager $manager,
  GUPnPControlPoint   $control_point
)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_manager_manage_root_device (
  GUPnPContextManager $manager,
  GUPnPRootDevice     $root_device
)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_manager_rescan_control_points (GUPnPContextManager $manager)
  is native(gupnp)
  is export
{ * }
