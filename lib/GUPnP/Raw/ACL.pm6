use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::ACL;

### /usr/include/gupnp-1.2/libgupnp/gupnp-acl.h

sub gupnp_acl_can_sync (GUPnPAcl $self)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_acl_is_allowed (
  GUPnPAcl     $self,
  GUPnPDevice  $device,
  GUPnPService $service,
  Str          $path,
  Str          $address,
  Str          $agent
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_acl_is_allowed_async (
  GUPnPAcl     $self,
  GUPnPDevice  $device,
  GUPnPService $service,
  Str          $path,
  Str          $address,
  Str          $agent,
  GCancellable $cancellable,
               &callback (GUPnPAcl, GAsyncResult, gpointer),
  gpointer     $user_data
)
  is native(gupnp)
  is export
{ * }

sub gupnp_acl_is_allowed_finish (
  GUPnPAcl                $self,
  GAsyncResult            $res,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_acl_get_type ()
  returns GType
  is native (gupnp)
  is export
{ * }
