use v6.c;

use Method::Also;

use MONKEY-TYPING;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::ServiceProxy;
use GUPnP::Raw::Subs;

use GLib::GList;
use GLib::Value;

augment class GUPnPServiceProxyAction {

  proto method new (|)
  { * }

  multi method new (Str() $action, @params) {
    my (@names, @values);
    for @params {
      @names.push( .key );
      @values.push( .value );
    }
    self.new_from_list($action, @names, @values);
  }

  proto method new_from_list (|)
    is also<new-from-list>
  { * }

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

  method get_type is also<get-type> {
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

  multi method get_result (
    @v where @v.all ~~ Pair,
    :$raw,
    :$glist;
  )
    is also<get-result>
  {
    my (@on, @ot);
    for @v {
      @on.push: .key;
      @ot.push: .value.Int;
    };
    samewith(@on, @ot, :$raw, :$glist );
  }
  multi method get_result (
    @on where @on.all !~~ Pair,
    @ot,
    :$raw,
    :$glist
  ) {
    CONTROL { when CX::Warn  { say .message; .backtrace.concise.say; .resume } }
    my $l = self.get_result_list(
      @on,
      @ot.map(*.Int).Array,
      :$glist,
      :$raw
    );
    return $l if $glist || $raw;

    (gather for ^$l[0].elems {
      $l[2][$_].type = $l[1][$_];
      take Pair.new( $l[0][$_], $l[2][$_] )
    }).Hash
  }

  proto method get_result_ghash (|)
    is also<get-result-hash>
  { * }

  multi method get_result_ghash (
    CArray[Pointer[GError]] $error = gerror,
                            :$raw  = False
  ) {
    my $rv = callwith($, $error, :all, :$raw;);

    $rv ?? $rv[1] !! Nil;
  }
  multi method get_result_ghash (
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

  proto method get_result_list (|)
    is also<get-result-list>
  { * }

  # cw: Need "out_names" and "out_types" as INPUT PARAMETERS!!
  multi method get_result_list (
    @v where @v.all ~~ Pair,
    :$glist,
    :$raw
  ) {
    my (@on, @ov);
    for @v {
      @on.push: .key;
      @ov.push: .value.Int;
    }
    samewith(@on, @ov, :$glist, :$raw);
  }
  multi method get_result_list (
    @on where @on.all !~~ Pair,
    @ot is copy,
    :$glist,
    :$raw
  ) {
    my ($on, $ot) = ( GLib::GList.new(@on), GLib::GList.new(@ot, :direct) );
    (my $ov       = CArray[Pointer[GList]].new)[0] = Pointer[GList];
    my $rv        = samewith($on, $ot, $ov, :$glist, :$raw);

    $rv ?? $rv.skip(1) !! Nil;
  }
  multi method get_result_list (
    GList()                 $out_names,
    GList()                 $out_types,
    CArray[Pointer[GList]]  $out_values,
    CArray[Pointer[GError]] $error       = gerror,
                            :$glist      = False,
                            :$raw        = False
  ) {
    clear_error;

    my $rv = so gupnp_service_proxy_action_get_result_list(
      self,
      $out_names,
      $out_types,
      $out_values,
      $error
    );
    set_error($error);

    handle-out-ntv($rv, $out_names, $out_types, $out_values, $glist, $raw);
  }


}
