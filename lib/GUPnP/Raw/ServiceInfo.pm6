use v6.c;

use NatoveCall;

use GLib::Raw::Definitions;
use SOUP::Raw::Structs;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::ServiceInfo;

### /usr/include/gupnp-1.2/libgupnp/gupnp-service-info.h

sub gupnp_service_info_get_context (GUPnPServiceInfo $info)
  returns GUPnPContext
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_control_url (GUPnPServiceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_event_subscription_url (GUPnPServiceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_id (GUPnPServiceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_introspection_async (
  GUPnPServiceInfo $info,
                   &callback (
                     GUPnPServiceInfo,
                     GUPnPServiceIntrospection,
                     GError,
                     gpointer
                   ),
  gpointer         $user_data
)
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_introspection_async_full (
  GUPnPServiceInfo $info,
                   &callback (
                     GUPnPServiceInfo,
                     GUPnPServiceIntrospection,
                     GError,
                     gpointer
                   ),
  GCancellable     $cancellable,
  gpointer         $user_data
)
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_location (GUPnPServiceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_scpd_url (GUPnPServiceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_service_type (GUPnPServiceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_udn (GUPnPServiceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_get_url_base (GUPnPServiceInfo $info)
  returns SoupURI
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_introspect_async (
  GUPnPServiceInfo $info,
  GCancellable     $cancellable,
                   &callback (GuPnPServiceInfo, GAsyncResult, gpointer),
  gpointer         $user_data
)
  is native(gupnp)
  is export
{ * }

sub gupnp_service_info_introspect_finish (
  GUPnPServiceInfo        $info,
  GAsyncResult            $res,
  CArray[Pointer[GError]] $error
)
  returns GUPnPServiceIntrospection
  is native(gupnp)
  is export
{ * }
