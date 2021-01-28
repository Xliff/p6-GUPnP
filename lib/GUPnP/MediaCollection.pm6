use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::MediaCollection;

use GLib::GList;

use GLib::Roles::Object;

our subset GUPnPMediaCollectionAncestry is export of Mu
  where GUPnPMediaCollection | GObject;

class GUPnP::MediaCollection {
  also does GLib::Roles::Object;

  has GUPnPMediaCollection $!mc;

  submethod BUILD ( :$collection ) {
    self.setGUPnPMediaCollection($collection) if $collection;
  }

  method setGUPnPMediaCollection (GUPnPMediaCollectionAncestry $_) {
    my $to-parent;

    $!mc = do {
      when GUPnPMediaCollection {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPMediaCollection, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPMediaCollection
    is also<GUPnPMediaCollection>
  { $!mc }

  multi method new (GUPnPMediaCollectionAncestry $parser, :$ref = True) {
    return Nil unless $parser;

    my $o = self.bless( :$parser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $collection = gupnp_media_collection_new();

    $collection ?? self.bless( :$collection ) !! Nil;
  }

  method new_from_string (Str $data) is also<new-from-string> {
    my $collection = gupnp_media_collection_new_from_string($data);

    $collection ?? self.bless( :$collection ) !! Nil;
  }

  # Type: gchar
  method author is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('author', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'author is a construct-only attribute'
      }
    );
  }

  # Type: gboolean
  method mutable is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('mutable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'mutable does not allow writing'
      }
    );
  }

  # Type: gchar
  method title is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('title', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'title is a construct-only attribute'
      }
    );
  }

  method add_item is also<add-item> {
    gupnp_media_collection_add_item($!mc);
  }

  method get_author is also<get-author> {
    gupnp_media_collection_get_author($!mc);
  }

  method get_items (:$glist = False, :$raw = False)
    is also<
      get-items
      items
    >
  {
    my $il = gupnp_media_collection_get_items($!mc);

    returnGList(
      $il,
      $glist,
      $raw,
      GUPnPDIDLLiteItem,
      GUPnP::DidlLiteItem
    );
  }

  method get_mutable is also<get-mutable> {
    gupnp_media_collection_get_mutable($!mc);
  }

  method get_string
    is also<
      get-string
      string
    >
  {
    gupnp_media_collection_get_string($!mc);
  }

  method get_title is also<get-title> {
    gupnp_media_collection_get_title($!mc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gupnp_media_collection_get_type, $n, $t );
  }

  method set_author (Str() $author) is also<set-author> {
    gupnp_media_collection_set_author($!mc, $author);
  }

  method set_title (Str() $title) is also<set-title> {
    gupnp_media_collection_set_title($!mc, $title);
  }
}
