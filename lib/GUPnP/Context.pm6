use v6.c;

use GUPnP::Raw::Types;
use GUPnP::Raw::Context;

use GSSDP::Client;

our subset GUPnPContextAncestry is export of Mu
  where GUPnPContext | GSSDPClientAncestry;

class GUPnP::Context is GSSDP::Client {
  has GUPnPContext $!pc;

  submethod BUILD (:$context) {
    self.setGUPnPContext($context) if $context;
  }

  method setGUPnpContext(GUPnPContextAncestry $_) {
    my $to-parent;
    $!pc = do {
      when GUPnPContext {
        $to-parent = cast(GSSDPClient, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnpContext, $_);
      }
    }
    self.setGSSDPClient($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPContext
  { $!pc }

  multi method new (GUPnPContextAncestry $context, :$ref = True) {
    return Nil unless $context;

    my $o = self.bless( :$context );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Int()                   $port,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint $p       = $port;
    my       $context = gupnp_context_new(Str, $p, $error);

    $context ?? self.bless( :$context ) !! Nil;
  }
  multi method new (
    Str()                   $iface = Str,
    Int()                   $port  = 0,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint $p       = $port;
    my       $context = gupnp_context_new($iface, $p, $error);

    $context ?? self.bless( :$context ) !! Nil;
  }


  # Type: GUPnPAcl
  method acl (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GUPnP::ACL.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('acl', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(SoupServer, $o);
        return $o if $raw;

        GUPnP::ACL.new($o, :!ref);
      },
      STORE => -> $, $val is copy {
        warn 'acl is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method default-language is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('default-language', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        warn 'default-language is a construct-only attribute'
      }
    );
  }

  # Type: guint
  method port is rw  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('port', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, $val is copy {
        warn 'port is a construct-only attribute'
      }
    );
  }

  # Type: SoupServer
  method server is rw  {
    my $gv = GLib::Value.new( SOUP::Server.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('server', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(SoupServer, $o);
        return $o if $raw;

        SOUP::Server.new($o, :!ref);
      },
      STORE => -> $, $val is copy {
        warn 'server does not allow writing'
      }
    );
  }

  # Type: SoupSession
  method session (:$raw = False) is rw  {
    my $gv = GLib::Value.new( SOUP::Session.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('session', $gv)
        );

        my $o = $gv.object;
        return Nil unless $o;

        $o = cast(SoupSession, $o);
        return $o if $raw;

        SOUP::Session.new($o, :!ref);
      },
      STORE => -> $, $val is copy {
        warn 'session does not allow writing'
      }
    );
  }

  # Type: guint
  method subscription-timeout is rw  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('subscription-timeout', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, $val is copy {
        warn 'subscription-timeout is a construct-only attribute'
      }
    );
  }

  method add_server_handler (
    Int()    $use_acl,
    Str      $path,
             &callback,
    gpointer $user_data,
             &destroy    = Callable
  ) {
    my gboolean $u = $use_acl.so.Int;

    gupnp_context_add_server_handler(
      $!pc,
      $u,
      $path,
      &callback,
      $user_data,
      &destroy
    );
  }

  method get_acl (:$raw = False) {
    my $a = gupnp_context_get_acl($!pc);

    $a ??
      ( $raw ?? $a !! GUPnP::ACL.new($a) )
      !!
      Nil;
  }

  method get_default_language {
    gupnp_context_get_default_language($!pc);
  }

  method get_port {
    gupnp_context_get_port($!pc);
  }

  method get_server (:$raw = False) {
    my $s = gupnp_context_get_server($!pc);

    $s ??
      ( $raw ?? $s !! SOUP::Server.new($s) )
      !!
      Nil;
  }

  method get_session (:$raw = False) {
    my $sess = gupnp_context_get_session($!pc);

    $sess ??
      ( $raw ?? $sess !! SOUP::Session.new($sess) )
      !!
      Nil;
  }

  method get_subscription_timeout {
    gupnp_context_get_subscription_timeout($!pc);
  }

  method host_path (Str() $local_path, Str() $server_path) {
    gupnp_context_host_path($!pc, $local_path, $server_path);
  }

  method host_path_for_agent (
    Str()    $local_path,
    Str()    $server_path,
    GRegex() $user_agent
  ) {
    so gupnp_context_host_path_for_agent(
      $!pc,
      $local_path,
      $server_path,
      $user_agent
    );
  }

  method remove_server_handler (Str() $path) {
    gupnp_context_remove_server_handler($!pc, $path);
  }

  method rewrite_uri (Str() $uri) {
    gupnp_context_rewrite_uri($!pc, $uri);
  }

  method set_acl (GUPnPAcl() $acl) {
    gupnp_context_set_acl($!pc, $acl);
  }

  method set_default_language (Str() $language) {
    gupnp_context_set_default_language($!pc, $language);
  }

  method set_subscription_timeout (Int() $timeout) {
    my guint $t = $timeout;

    gupnp_context_set_subscription_timeout($!pc, $t);
  }

  method unhost_path (Str() $server_path) {
    gupnp_context_unhost_path($!pc, $server_path);
  }
}
