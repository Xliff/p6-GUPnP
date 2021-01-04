use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::ServiceIntrospection;

### /usr/include/gupnp-1.2/libgupnp/gupnp-service-introspection.h

sub gupnp_service_introspection_get_action (
  GUPnPServiceIntrospection $introspection,
  Str                       $action_name
)
  returns GUPnPServiceActionInfo
  is native(gupnp)
  is export
{ * }

sub gupnp_service_introspection_get_state_variable (
  GUPnPServiceIntrospection $introspection,
  Str                       $variable_name
)
  returns GUPnPServiceStateVariableInfo
  is native(gupnp)
  is export
{ * }

sub gupnp_service_introspection_list_action_names (
  GUPnPServiceIntrospection $introspection
)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_service_introspection_list_actions (
  GUPnPServiceIntrospection $introspection
)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_service_introspection_list_state_variable_names (
  GUPnPServiceIntrospection $introspection
)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_service_introspection_list_state_variables (
  GUPnPServiceIntrospection $introspection
)
  returns GList
  is native(gupnp)
  is export
{ * }
