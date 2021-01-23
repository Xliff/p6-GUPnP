use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;
use GUPnP::Raw::WhiteList;

use GLib::Roles::Object;

our subset GUPnPWhiteListAncestry is export of Mu
  where GUPnPWhiteList | GObject;

class GUPnP::WhiteList {
  also does GLib::Roles::Object;

  has GUPnPWhiteList $!wl;

  submethod BUILD (:$whitelist) {
    self.setGUPnPWhiteList($whitelist) if $whitelist;
  }

  method setGUPnPWhiteList (GUPnPWhiteListAncestry $_) {
    my $to-parent;

    $!wl = do {
      when GUPnPWhiteList {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPWhiteList, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GUPnPWhiteListAncestry $whitelist, :$ref = True) {
    return Nil unless $whitelist;

    my $o = self.bless( :$whitelist );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $whitelist = gupnp_white_list_new();

    $whitelist ?? self.bless( :$whitelist ) !! Nil;
  }

  method enabled is rw {
    Proxy.new:
      FETCH => -> $           { self.get_enabled    },
      STORE => -> $, Int() \e { self.set_enabled(e) };
  }

  method add_entry (Str() $entry) is also<add-entry> {
    gupnp_white_list_add_entry($!wl, $entry);
  }

  method add_entries (@entries) is also<add-entries> {
    samewith( resolve-gstrv(@entries) );
  }

  method add_entryv (CArray[Str] $entries) is also<add-entryv> {
    gupnp_white_list_add_entryv($!wl, $entries);
  }

  method check_context (GUPnPContext() $context) is also<check-context> {
    so gupnp_white_list_check_context($!wl, $context);
  }

  method clear {
    gupnp_white_list_clear($!wl);
  }

  method get_enabled is also<get-enabled> {
    so gupnp_white_list_get_enabled($!wl);
  }

  method get_entries (:$glist = False, :$raw = False)
    is also<
      get-entries
      entries
    >
  {
    my $el = gupnp_white_list_get_entries($!wl);

    return Nil unless $el;
    return $el if $glist && $raw;

    $el = GLib::GList.new($el) but GLib::Roles::ListData[Str];

    $el.Array;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gupnp_white_list_get_type, $n, $t );
  }

  method is_empty is also<is-empty> {
    so gupnp_white_list_is_empty($!wl);
  }

  method remove_entry (Str() $entry) is also<remove-entry> {
    gupnp_white_list_remove_entry($!wl, $entry);
  }

  method set_enabled (Int() $enable) is also<set-enabled> {
    my gboolean $e = $enable.so.Int;

    gupnp_white_list_set_enabled($!wl, $enable);
  }

}
