use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::DlnaValueList;

use GLib::GList;
use GLib::Value;

# BOXED

class GUPnP::DlnaValueList {
  has GUPnPDLNAValueList $!vl;

  submethod BUILD (:$list) {
    $!vl = $list;
  }

  method new (GUPnPDLNAValueList $list, :$ref = True) {
    return Nil unless $list;

    my $o = self.bless( :$list );
    $o.ref if $ref;
    $o;
  }

  method GUPnP::Raw::Definitions::GUPnPDLNAValueList
    is also<GUPnPDLNAValueList>
  { $!vl }

  method copy (:$raw = False) {
    my $c = gupnp_dlna_value_list_copy($!vl);

    $c ??
      ( $raw ?? $c !! GUPnP::DlnaValueList.new($c, :!ref) )
      !!
      Nil;
  }

  method free {
    gupnp_dlna_value_list_free($!vl);
  }

  method get_g_values (:$glist = False, :$raw = False) is also<get-g-values> {

    returnGList(
      gupnp_dlna_value_list_get_g_values($!vl),
      $glist,
      $raw,
      GValue,
      GLib::Value
    );

  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_dlna_value_list_get_type,
      $n,
      $t
    );
  }

  method is_empty is also<is-empty> {
    so gupnp_dlna_value_list_is_empty($!vl);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gupnp_dlna_value_list_to_string($!vl);
  }

}
