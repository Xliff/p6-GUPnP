use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;

use GUPnP::DidlLiteObject;

our subset GUPnPDIDLLiteItemAncestry is export of Mu
  where GUPnPDIDLLiteItem | GUPnPDIDLLiteObjectAncestry;

class GUPnP::DidlLiteItem is GUPnP::DidlLiteObject {
  has GUPnPDIDLLiteItem $!dli;

  submethod BUILD (:$item) {
    self.setGUPnPDIDLLiteItem($item) if $item;
  }

  method setGUPnPDIDLLiteItem (GUPnPDIDLLiteItemAncestry $_) {
    my $to-parent;

    $!dli = do {
      when GUPnPDIDLLiteItem {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDIDLLiteItem, $_);
      }
    }
    self.setGUPnPDIDLLiteObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDIDLLiteItem
    is also<GUPnPDIDLLiteItem>
  { $!dli }

  method new (GUPnPDIDLLiteItemAncestry $item, :$ref = True) {
    return Nil unless $item;

    my $o = self.bless( :$item );
    $o.ref if $ref;
    $o;
  }

  # Type: glong
  method lifetime is rw  {
    my $gv = GLib::Value.new( G_TYPE_LONG );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('lifetime', $gv)
        );
        $gv.long;
      },
      STORE => -> $, Int() $val is copy {
        $gv.long = $val;
        self.prop_set('lifetime', $gv);
      }
    );
  }

  # Type: gchar
  method ref-id is rw  is also<ref_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('ref-id', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('ref-id', $gv);
      }
    );
  }

  method get_lifetime is also<get-lifetime> {
    gupnp_didl_lite_item_get_lifetime($!dli);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gupnp_didl_lite_item_get_type, $n, $t );
  }

  method set_lifetime (Int() $lifetime) is also<set-lifetime> {
    my glong $l = $lifetime;
    gupnp_didl_lite_item_set_lifetime($!dli, $l);
  }

  method set_ref_id (Str() $ref_id) is also<set-ref-id> {
    gupnp_didl_lite_item_set_ref_id($!dli, $ref_id);
  }

}

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-didl-lite-item.h

sub gupnp_didl_lite_item_get_lifetime (GUPnPDIDLLiteItem $item)
  returns glong
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_item_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_item_set_lifetime (GUPnPDIDLLiteItem $item, glong $lifetime)
  is native(gupnp-av)
  is export
{ * }

sub gupnp_didl_lite_item_set_ref_id (GUPnPDIDLLiteItem $item, Str $ref_id)
  is native(gupnp-av)
  is export
{ * }
