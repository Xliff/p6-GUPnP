use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::ServiceProxy;

### /usr/include/gupnp-1.2/libgupnp/gupnp-service-proxy.h

# sub gupnp_service_proxy_action_get_result (
#   GUPnPServiceProxyAction $action,
#   CArray[Pointer[GError]] $error,
#   ...
# )
#   returns uint32
#   is native(gupnp)
#   is export
# { * }

sub gupnp_service_proxy_action_get_result_hash (
  GUPnPServiceProxyAction $action,
  GHashTable              $out_hash,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_action_get_result_list (
  GUPnPServiceProxyAction $action,
  GList                   $out_names,
  GList                   $out_types,
  CArray[Pointer[GList]]  $out_values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_action_get_type ()
  returns GType
  is native(gupnp)
  is export
{ * }

# sub gupnp_service_proxy_action_new (Str $action, ...)
#   returns GUPnPServiceProxyAction
#   is native(gupnp)
#   is export
# { * }

sub gupnp_service_proxy_action_new_from_list (
  Str   $action,
  GList $in_names,
  GList $in_values
)
  returns GUPnPServiceProxyAction
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_action_ref (GUPnPServiceProxyAction $action)
  returns GUPnPServiceProxyAction
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_action_unref (GUPnPServiceProxyAction $action)
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_add_notify (
  GUPnPServiceProxy $proxy,
  Str               $variable,
  GType             $type,
  &callback (GUPnpServiceProxy, GUPnpServiceProxyAction, gpointer),
  gpointer $user_data
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_add_notify_full (
  GUPnPServiceProxy $proxy,
  Str                $variable,
  GType              $type,
                     &callback (
                       GUPnpServiceProxy,
                       GUPnpServiceProxyAction,
                       gpointer
                     ),
  gpointer           $user_data,
  GDestroyNotify     $notify
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_add_raw_notify (
  GUPnPServiceProxy $proxy,
                    &callback (
                      GUPnpServiceProxy,
                      GUPnpServiceProxyAction,
                      gpointer
                    ),
  gpointer          $user_data,
  GDestroyNotify    $notify
)
  returns uint32
  is native(gupnp)
  is export
{ * }

# sub gupnp_service_proxy_begin_action (
#   GUPnPServiceProxy $proxy,
#   Str $action,
#   &callback (GUPnpServiceProxy, Str, GValue, gpointer),
#   gpointer $user_data,
#   ...
# )
#   returns GUPnPServiceProxyAction
#   is native(gupnp)
#   is export
# { * }

sub gupnp_service_proxy_begin_action_list (
  GUPnPServiceProxy $proxy,
  Str               $action,
  GList             $in_names,
  GList             $in_values,
                    &callback (GUPnpServiceProxy, Str, GValue, gpointer),
  gpointer          $user_data
)
  returns GUPnPServiceProxyAction
  is native(gupnp)
  is export
{ * }

# sub gupnp_service_proxy_begin_action_valist (
#   GUPnPServiceProxy $proxy,
#   Str $action,
#   &callback (GUPnpServiceProxy, Str, GValue, gpointer),
#   gpointer $user_data,
#   va_list $var_args
# )
#   returns GUPnPServiceProxyAction
#   is native(gupnp)
#   is export
# { * }

sub gupnp_service_proxy_call_action (
  GUPnPServiceProxy       $proxy,
  GUPnPServiceProxyAction $action,
  GCancellable            $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GUPnPServiceProxyAction
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_call_action_async (
  GUPnPServiceProxy       $proxy,
  GUPnPServiceProxyAction $action,
  GCancellable            $cancellable,
  GAsyncReadyCallback     $callback,
  gpointer                $user_data
)
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_call_action_finish (
  GUPnPServiceProxy       $proxy,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GUPnPServiceProxyAction
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_cancel_action (
  GUPnPServiceProxy       $proxy,
  GUPnPServiceProxyAction $action
)
  is native(gupnp)
  is export
{ * }

# sub gupnp_service_proxy_end_action (
#   GUPnPServiceProxy $proxy,
#   GUPnPServiceProxyAction $action,
#   CArray[Pointer[GError]] $error,
#   ...
# )
#   returns uint32
#   is native(gupnp)
#   is export
# { * }

sub gupnp_service_proxy_end_action_hash (
  GUPnPServiceProxy       $proxy,
  GUPnPServiceProxyAction $action,
  GHashTable              $hash,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_end_action_list (
  GUPnPServiceProxy       $proxy,
  GUPnPServiceProxyAction $action,
  GList                   $out_names,
  GList                   $out_types,
  CArray[Pointer[GList]]  $out_values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gupnp)
  is export
{ * }

# sub gupnp_service_proxy_end_action_valist (
#   GUPnPServiceProxy $proxy,
#   GUPnPServiceProxyAction $action,
#   CArray[Pointer[GError]] $error,
#   va_list $var_args
# )
#   returns uint32
#   is native(gupnp)
#   is export
# { * }

sub gupnp_service_proxy_get_subscribed (GUPnPServiceProxy $proxy)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_remove_notify (
  GUPnPServiceProxy $proxy,
  Str               $variable,
                    &callback (
                      GUPnpServiceProxy,
                      GUPnpServiceProxyAction,
                      gpointer
                    ),
  gpointer          $user_data
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_service_proxy_remove_raw_notify (
  GUPnPServiceProxy $proxy,
                    &callback (
                      GUPnpServiceProxy,
                      GUPnpServiceProxyAction,
                      gpointer
                    ),
  gpointer          $user_data
)
  returns uint32
  is native(gupnp)
  is export
{ * }

# sub gupnp_service_proxy_send_action (
#   GUPnPServiceProxy $proxy,
#   Str $action,
#   CArray[Pointer[GError]] $error,
#   ...
# )
#   returns uint32
#   is native(gupnp)
#   is export
# { * }

sub gupnp_service_proxy_send_action_list (
  GUPnPServiceProxy       $proxy,
  Str                     $action,
  GList                   $in_names,
  GList                   $in_values,
  GList                   $out_names,
  GList                   $out_types,
  CArray[Pointer[GList]]  $out_values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gupnp)
  is export
{ * }

# sub gupnp_service_proxy_send_action_valist (
#   GUPnPServiceProxy $proxy,
#   Str $action,
#   CArray[Pointer[GError]] $error,
#   va_list $var_args
# )
#   returns uint32
#   is native(gupnp)
#   is export
# { * }

sub gupnp_service_proxy_set_subscribed (
  GUPnPServiceProxy $proxy,
  gboolean $subscribed
)
  is native(gupnp)
  is export
{ * }
