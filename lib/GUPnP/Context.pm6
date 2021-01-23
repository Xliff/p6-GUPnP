use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;
use GUPnP::Raw::Context;
use SOUP::Raw::Definitions;

use SOUP::Server;
use SOUP::Session;
use GSSDP::Client;

use GUPnP::Roles::ACL;

our subset GUPnPContextAncestry is export of Mu
  where GUPnPContext | GSSDPClientAncestry;

class GUPnP::Context is GSSDP::Client {
  has GUPnPContext $!pc is implementor;

  # cw: ALL Initables require :$object!
  submethod BUILD (:$context is copy, :$initable-object) {
    $context //= $initable-object if $initable-object;

    say "GUPnP::Context - CONTEXT = { $context // '<<NIL>>' } / OBJECT = { $initable-object // '<<NIL>>' }"
      if $DEBUG;

    self.setGUPnPContext($context) if $context;
  }

  method setGUPnPContext(GUPnPContextAncestry $_) {
    my $to-parent;

    return if $!pc;

    $!pc = do {
      when GUPnPContext {
        $to-parent = cast(GSSDPClient, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPContext, $_);
      }
    }
    self.setGSSDPClient($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPContext
      is also<GUPnPContext>
  { $!pc }

  my %attributes = (
    acl                  => [ 'object', GUPnPAcl,    GUPnP::ACL.get-type ],
    default-language     => G_TYPE_STRING,
    port                 => G_TYPE_UINT,
    server               => [ 'object', SoupServer,  SOUP::Server.get-type ],
    session              => [ 'object', SoupSession, SOUP::Session.get-type ],
    subscription-timeout => G_TYPE_UINT
  );

  method attributes ($key) {
    nextsame unless %attributes{$key}:exists;
    %attributes{$key};
  }

  proto method new (|)
  { * }

  multi method new (GUPnPContextAncestry $context, :$ref = True) {
    return Nil unless $context;

    my $o = self.bless( :$context );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    CArray[Pointer[GError]] $error = gerror,
    Str()                   :$iface = Str,
    Int()                   :$port,
  ) {
    samewith($iface, $port, $error);
  }
  multi method new (
    Str                     $iface = Str,
    Int                     $port  = 0,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint $p       = $port;
    my       $context = gupnp_context_new($iface, $p, $error);

    $context ?? self.bless( :$context ) !! Nil;
  }
  multi method new (
    GCancellable()          $cancellable      =  GCancellable,
    CArray[Pointer[GError]] $error            =  gerror,
                            :init(:$initable) is required
  ) {
    self.construct('context', $cancellable, $error);
  }

  # Override
  multi method new_object_with_properties (
    *@args,
    :$RAW = False,
    :$TYPE,
    :pairs(:$p) is required
  ) {
    nextwith(@args, :$RAW, TYPE => self.get-type, :pairs);
  }
  # Override
  multi method new_object_with_properties (:$RAW = False, :$TYPE, *%props) {
    nextwith(|%props, :$RAW, TYPE => self.get-type);
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
  method default-language is rw  is also<default_language> {
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
  method server (:$raw = False) is rw  {
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
  method subscription-timeout is rw  is also<subscription_timeout> {
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
  )
    is also<add-server-handler>
  {
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

  method get_acl (:$raw = False) is also<get-acl> {
    my $a = gupnp_context_get_acl($!pc);

    $a ??
      ( $raw ?? $a !! GUPnP::ACL.new($a) )
      !!
      Nil;
  }

  method get_default_language is also<get-default-language> {
    gupnp_context_get_default_language($!pc);
  }

  method get_server (:$raw = False) is also<get-server> {
    my $s = gupnp_context_get_server($!pc);

    $s ??
      ( $raw ?? $s !! SOUP::Server.new($s) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gupnp_context_get_type, $n, $t );
  }

  method get_session (:$raw = False) is also<get-session> {
    my $sess = gupnp_context_get_session($!pc);

    $sess ??
      ( $raw ?? $sess !! SOUP::Session.new($sess) )
      !!
      Nil;
  }

  method get_subscription_timeout is also<get-subscription-timeout> {
    gupnp_context_get_subscription_timeout($!pc);
  }

  method host_path (Str() $local_path, Str() $server_path) is also<host-path> {
    gupnp_context_host_path($!pc, $local_path, $server_path);
  }

  method host_path_for_agent (
    Str()    $local_path,
    Str()    $server_path,
    GRegex() $user_agent
  )
    is also<host-path-for-agent>
  {
    so gupnp_context_host_path_for_agent(
      $!pc,
      $local_path,
      $server_path,
      $user_agent
    );
  }

  method remove_server_handler (Str() $path) is also<remove-server-handler> {
    gupnp_context_remove_server_handler($!pc, $path);
  }

  method rewrite_uri (Str() $uri) is also<rewrite-uri> {
    gupnp_context_rewrite_uri($!pc, $uri);
  }

  method set_acl (GUPnPAcl() $acl) is also<set-acl> {
    gupnp_context_set_acl($!pc, $acl);
  }

  method set_default_language (Str() $language) is also<set-default-language> {
    gupnp_context_set_default_language($!pc, $language);
  }

  method set_subscription_timeout (Int() $timeout)
    is also<set-subscription-timeout>
  {
    my guint $t = $timeout;

    gupnp_context_set_subscription_timeout($!pc, $t);
  }

  method unhost_path (Str() $server_path) is also<unhost-path> {
    gupnp_context_unhost_path($!pc, $server_path);
  }
}
