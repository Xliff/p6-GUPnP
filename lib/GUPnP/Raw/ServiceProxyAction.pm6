use v6.c;

use MONKEY-TYPING;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::ServiceProxy;

use GLib::GList;

use GLib::Roles::Pointers;

my $serviceProxyReturnHash = True;
augment class GUPnPServiceProxyAction {

  method hashByDefault (GUPnPServiceProxyAction:U: $b) is rw {
    $serviceProxyReturnHash
  }

  multi method new_from_list (Str() $action, @names, @values) {
    my ($n, $v) = ( GLib::GList.new(@names), GLib::GList.new(@values) );
    samewith($action, $n, $v);
  }
  multi method new_from_list (
    Str()   $action,
    GList() $in_names,
    GList() $in_values
  ) {
    gupnp_service_proxy_action_new_from_list($action, $in_names, $in_values);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_service_proxy_action_get_type,
      $n,
      $t
    );
  }

  method ref {
    gupnp_service_proxy_action_ref(self);
    self;
  }

  method unref {
    gupnp_service_proxy_action_unref(self);
  }

  method get_result (:$list is copy, :$hash is copy) {
    die 'Cannot use both :list and :hash with .get_result!'
      unless $hash && $list ^^ $hash;
    $hash //= $serviceProxyReturnHash unless $list;

    return self.get_result_hash if $hash;
    self.get_result_list;
  }

  multi method get_result_hash (
    CArray[Pointer[GError]] $error = gerror,
                            :$raw  = False
  ) {
    my $rv = callwith($, $error, :all, :$raw;);

    $rv ?? $rv[1] !! Nil;
  }
  multi method get_result_hash (
                            $out_hash is rw,
    CArray[Pointer[GError]] $error    =  gerror,
                            :$all     =  False,
                            :$raw     =  False
  ) {
    $out_hash = GHashTable.new;
    my $rv = so gupnp_service_proxy_action_get_result_hash(
      self,
      $out_hash,
      $error
    );

    $out_hash = GLib::HashTable.new($out_hash, :!ref)
      unless !$out_hash || $raw;

    $all.not ?? $rv !! ($rv, $out_hash);
  }

}
