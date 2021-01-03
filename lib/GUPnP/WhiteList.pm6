use v6.c;

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

  method setGUPnPWhiteList (GUPnPWhitelistAncestry $_) {
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

  method new {
    my $whitelist = gupnp_white_list_new();

    $whitelist ?? self.bless( :$whitelist ) !! Nil;
  }

  method add_entry (Str() $entry) {
    gupnp_white_list_add_entry($!wl, $entry);
  }

  method add_entries (@entries) {
    samewith( resolve-gstrv(@entries) );
  }

  method add_entryv (CArray[Str] $entries) {
    gupnp_white_list_add_entryv($!wl, $entries);
  }

  method check_context (GUPnPContext() $context) {
    so gupnp_white_list_check_context($!wl, $context);
  }

  method clear {
    gupnp_white_list_clear($!wl);
  }

  method get_enabled {
    so gupnp_white_list_get_enabled($!wl);
  }

  method get_entries (:$glist = False, :$raw = False) {
    my $el = gupnp_white_list_get_entries($!wl);

    return Nil unless $el;
    return $el if $glist && $raw;

    $el = GLib::GList.new($el) but GLib::Roles::ListData[Str];

    $el.Array;
  }

  method is_empty {
    so gupnp_white_list_is_empty($!wl);
  }

  method remove_entry (Str() $entry) {
    gupnp_white_list_remove_entry($!wl, $entry);
  }

  method set_enabled (Int() $enable) {
    my gboolean $e = $enable.so.Int;

    gupnp_white_list_set_enabled($!wl, $enable);
  }

}
