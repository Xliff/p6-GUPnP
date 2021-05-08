use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use SOUP::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::Context;

### /usr/include/gupnp-1.2/libgupnp/gupnp-context.h

sub gupnp_context_add_server_handler (
  GUPnPContext $context,
  gboolean     $use_acl,
  Str          $path,
               &callback (
                 SoupServer,
                 SoupMessage,
                 Str,
                 GHashTable,
                 SoupClientContext,
                 gpointer
               ),
  gpointer     $user_data,
               &destroy (gpointer)
)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_get_acl (GUPnPContext $context)
  returns GUPnPAcl
  is native(gupnp)
  is export
{ * }

sub gupnp_context_get_default_language (GUPnPContext $context)
  returns Str
  is native(gupnp)
  is export
{ * }

# DEPRECATED - this definition will be removed in a future commit.
# sub gupnp_context_get_port (GUPnPContext $context)
#   returns guint
#   is native(gupnp)
#   is export
# { * }

sub gupnp_context_get_server (GUPnPContext $context)
  returns SoupServer
  is native(gupnp)
  is export
{ * }

sub gupnp_context_get_session (GUPnPContext $context)
  returns SoupSession
  is native(gupnp)
  is export
{ * }

sub gupnp_context_get_subscription_timeout (GUPnPContext $context)
  returns guint
  is native(gupnp)
  is export
{ * }

sub gupnp_context_host_path (
  GUPnPContext $context,
  Str          $local_path,
  Str          $server_path
)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_host_path_for_agent (
  GUPnPContext $context,
  Str          $local_path,
  Str          $server_path,
  GRegex       $user_agent
)
  returns uint32
  is native(gupnp)
  is export
{ * }

sub gupnp_context_new (Str $iface, guint $port, CArray[Pointer[GError]] $error)
  returns GUPnPContext
  is native(gupnp)
  is export
{ * }

sub gupnp_context_remove_server_handler (GUPnPContext $context, Str $path)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_rewrite_uri (GUPnPContext $context, Str $uri)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_context_set_acl (GUPnPContext $context, GUPnPAcl $acl)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_set_default_language (GUPnPContext $context, Str $language)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_set_subscription_timeout (
  GUPnPContext $context,
  guint        $timeout
)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_unhost_path (GUPnPContext $context, Str $server_path)
  is native(gupnp)
  is export
{ * }

sub gupnp_context_get_type ()
  returns GType
  is native(gupnp-helper)
  is symbol('helper_gupnp_context_get_type')
  is export
{ * }
