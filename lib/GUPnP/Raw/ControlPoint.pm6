use v6.c;

use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::ControlPoint;

### /usr/include/gupnp-1.2/libgupnp/gupnp-control-point.h

sub gupnp_control_point_get_context (GUPnPControlPoint $control_point)
  returns GUPnPContext
  is native(gupnp)
  is export
{ * }

sub gupnp_control_point_get_resource_factory (GUPnPControlPoint $control_point)
  returns GUPnPResourceFactory
  is native(gupnp)
  is export
{ * }

sub gupnp_control_point_list_device_proxies (GUPnPControlPoint $control_point)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_control_point_list_service_proxies (GUPnPControlPoint $control_point)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_control_point_new (GUPnPContext $context, Str $target)
  returns GUPnPControlPoint
  is native(gupnp)
  is export
{ * }

sub gupnp_control_point_new_full (
  GUPnPContext         $context, 
  GUPnPResourceFactory $factory,
  Str                  $target
)
  returns GUPnPControlPoint
  is native(gupnp)
  is export
{ * }
