use v6.c;

use NativeCall;
use Method::Also;

use LibXML::Raw;
use GUPnP::Raw::Types;
use GUPnP::Raw::DidlLiteObject;

use GUPnP::DidlLiteContributor;
use GUPnP::DidlLiteDescriptor;
use GUPnP::DidlLiteResource;

use GLib::Roles::Object;

subset GUPnPDIDLLiteObjectAncestry is export of Mu
  where GUPnPDIDLLiteObject | GObject;

class GUPnP::DidlLiteObject {
  also does GLib::Roles::Object;

  has GUPnPDIDLLiteObject $dlo is implementor;

  submethod BUILD (:$object) {
    self.setGUPnPDIDLLiteObject($object) if $object;
  }

  method setGUPnPDIDLLiteObject (GUPnPDIDLLiteObjectAncestry $_) {
    my $to-parent;

    $!dlo = do {
      when GUPnPDIDLLiteObject {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDIDLLiteObject, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDIDLLiteObject
    is also<GUPnPDIDLLiteObject>
  { $!dlo }

  method new (GUPnPDIDLLiteObjectAncestry $object, :$ref = True) {
    return Nil unless $object;

    my $o = self.bless( :$object );
    $o.ref if $ref;
    $o;
  }

  # Type: gchar
  method album is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('album', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('album', $gv);
      }
    );
  }

  # Type: gchar
  method album-art is rw  is also<album_art> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('album-art', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('album-art', $gv);
      }
    );
  }

  # Type: gchar
  method artist
    is rw
    is DEPRECATED(
      "gupnp_didl_lite_object_get_artists and gupnp_didl_lite_object_add_artist"
    )
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('artist', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('artist', $gv);
      }
    );
  }

  # Type: gchar
  method author
    is rw
    is DEPRECATED(
      "gupnp_didl_lite_object_get_authors and gupnp_didl_lite_object_add_author"
    )
  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('author', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('author', $gv);
      }
    );
  }

  # Type: gchar
  method creator is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('creator', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('creator', $gv);
      }
    );
  }

  # Type: gchar
  method date is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('date', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('date', $gv);
      }
    );
  }

  # Type: gpointer
  method dc-namespace is rw  is also<dc_namespace> {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('dc-namespace', $gv)
        );

        my $p = $gv.pointer;
        return Nil unless $p;
        $p;
      },
      STORE => -> $,  $val is copy {
        warn 'dc-namespace is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method description is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('description', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('description', $gv);
      }
    );
  }

  # Type: GUPnPOCMFlags
  method dlna-managed is rw  is also<dlna_managed> {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromEnum(GUPnPOCMFlags) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('dlna-managed', $gv)
        );
        GUPnPOCMFlagsEnum( $gv.valueFromEnum(GUPnPOCMFlags) );
      },
      STORE => -> $,  $val is copy {
        $gv.valueFromEnum(GUPnPOCMFlags) = $val;
        self.prop_set('dlna-managed', $gv);
      }
    );
  }

  # Type: gpointer
  method dlna-namespace is rw  is also<dlna_namespace> {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('dlna-namespace', $gv)
        );

        my $p = $gv.pointer;
        return Nil unless $p;
        $p;
      },
      STORE => -> $,  $val is copy {
        warn 'dlna-namespace is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method genre is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('genre', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('genre', $gv);
      }
    );
  }

  # Type: gchar
  method id is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('id', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('id', $gv);
      }
    );
  }

  # Type: gchar
  method parent-id is rw  is also<parent_id> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('parent-id', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('parent-id', $gv);
      }
    );
  }

  # Type: gboolean
  method restricted is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('restricted', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('restricted', $gv);
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
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: gint
  method track-number is rw  is also<track_number> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('track-number', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('track-number', $gv);
      }
    );
  }

  # Type: guint
  method update-id is rw  is also<update_id> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('update-id', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('update-id', $gv);
      }
    );
  }

  # Type: gchar
  method upnp-class is rw  is also<upnp_class> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('upnp-class', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('upnp-class', $gv);
      }
    );
  }

  # Type: gpointer
  method upnp-namespace is rw  is also<upnp_namespace> {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('upnp-namespace', $gv)
        );

        my $p = $gv.pointer;
        return Nil unless $p;
        $p;
      },
      STORE => -> $,  $val is copy {
        warn 'upnp-namespace is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method write-status is rw  is also<write_status> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('write-status', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('write-status', $gv);
      }
    );
  }

  # Type: gpointer
  method xml-node is rw  is also<xml_node> {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('xml-node', $gv)
        );

        my $p = $gv.pointer;
        return Nil unless $p;
        cast(xmlNode, $p);
      },
      STORE => -> $,  $val is copy {
        warn 'xml-node is a construct-only attribute'
      }
    );
  }

  method add_artist (:$raw = False) is also<add-artist> {
    my $c = gupnp_didl_lite_object_add_artist($!dlo);

    $c ??
      ( $raw ?? $c !! GUPnP::DidlLiteContributor.new($c, :!ref) )
      !!
      Nil;
  }

  method add_author (:$raw = False) is also<add-author> {
    my $c = gupnp_didl_lite_object_add_author($!dlo);

    $c ??
      ( $raw ?? $c !! GUPnP::DidlLiteContributor.new($c, :!ref) )
      !!
      Nil;
  }

  method add_creator (:$raw = False) is also<add-creator> {
    my $c = gupnp_didl_lite_object_add_creator($!dlo);

    $c ??
      ( $raw ?? $c !! GUPnP::DidlLiteContributor.new($c, :!ref) )
      !!
      Nil;
  }

  method add_descriptor (:$raw = False) is also<add-descriptor> {
    my $d = gupnp_didl_lite_object_add_descriptor($!dlo);

    $d ??
      ( $raw ?? $d !! GUPnP::DidlLiteDescriptor.new($d, :!ref) )
      !!
      Nil;
  }

  method add_resource (:$raw = False) is also<add-resource> {
    my $r = gupnp_didl_lite_object_add_resource($!dlo);

    $r ??
      ( $raw ?? $r !! GUPnP::DidlLiteResource.new($r, :!ref) )
      !!
      Nil;
  }

  proto method apply_fragments (|)
   is also<apply-fragments>
  { * }

  multi method apply_fragments (
    Int() $current_size,
    Int() $new_size
  ) {
    samewith($, $current_size, $, $new_size);
  }
  multi method apply_fragments (
          $current_fragments is rw,
    Int() $current_size,
          $new_fragments     is rw,
    Int() $new_size
  ) {
    my gint ($cs, $ns) = ($current_size, $new_size);
    my ($cf, $nf)      = CArray[Str].new xx 2;
    ($cf[0], $nf[0])   = Str xx 2;

    my $r = GUPnPDIDLLiteFragmentResultEnum(
      gupnp_didl_lite_object_apply_fragments(
        $!dlo,
        $cf,
        $current_size,
        $nf,
        $new_size
      )
    );

    ($current_fragments, $new_fragments) = ( ppr($cf), ppr($nf) );
    ($r, $current_fragments, $new_fragments);
  }

  method get_album is also<get-album> {
    gupnp_didl_lite_object_get_album($!dlo);
  }

  method get_album_art is also<get-album-art> {
    gupnp_didl_lite_object_get_album_art($!dlo);
  }

  method get_album_xml_string is also<get-album-xml-string> {
    gupnp_didl_lite_object_get_album_xml_string($!dlo);
  }

  method get_artist is also<get-artist> {
    gupnp_didl_lite_object_get_artist($!dlo);
  }

  method get_artists is also<get-artists> {
    gupnp_didl_lite_object_get_artists($!dlo);
  }

  method get_artists_xml_string is also<get-artists-xml-string> {
    gupnp_didl_lite_object_get_artists_xml_string($!dlo);
  }

  method get_author is also<get-author> {
    gupnp_didl_lite_object_get_author($!dlo);
  }

  method get_authors (:$glist = False, :$raw = False) is also<get-authors> {
    my $cl = gupnp_didl_lite_object_get_authors($!dlo);

    return Nil unless $cl;
    return $cl if     $glist && $raw;

    $cl = GLib::GList.new($cl)
      but GLib::Roles::ListData[GUPnPDIDLLiteContributor];
    return $cl if     $glist;

    $raw ?? $cl.Array
         !! $cl.Array.map({ GUPnP::DidlLiteContributor.new($_, :!ref) });
  }

  method get_compat_resource (
    Str() $sink_protocol_info,
    Int() $lenient,
          :$raw = False
  )
    is also<get-compat-resource>
  {
    my gboolean $l = $lenient.so.Int;

    my $r = gupnp_didl_lite_object_get_compat_resource(
      $!dlo,
      $sink_protocol_info,
      $l
    );

    $r ??
      ( $raw ?? $r !! GUPnP::DidlLiteResource.new($r, :!ref) )
      !!
      Nil;
  }

  method get_creator is also<get-creator> {
    gupnp_didl_lite_object_get_creator($!dlo);
  }

  method get_creators (:$glist = False, :$raw = False) is also<get-creators> {
    my $cl = gupnp_didl_lite_object_get_creators($!dlo);

    return Nil unless $cl;
    return $cl if     $glist && $raw;

    $cl = GLib::GList.new($cl)
      but GLib::Roles::ListData[GUPnPDIDLLiteContributor];
    return $cl if     $glist;

    $raw ?? $cl.Array
         !! $cl.Array.map({ GUPnP::DidlLiteContributor.new($_, :!ref) });
  }

  method get_date is also<get-date> {
    gupnp_didl_lite_object_get_date($!dlo);
  }

  method get_date_xml_string is also<get-date-xml-string> {
    gupnp_didl_lite_object_get_date_xml_string($!dlo);
  }

  method get_dc_namespace is also<get-dc-namespace> {
    gupnp_didl_lite_object_get_dc_namespace($!dlo);
  }

  method get_description is also<get-description> {
    gupnp_didl_lite_object_get_description($!dlo);
  }

  method get_descriptors (:$glist = False, :$raw = False)
    is also<get-descriptors>
  {
    my $dl = gupnp_didl_lite_object_get_descriptors($!dlo);

    return Nil unless $dl;
    return $dl if     $glist && $raw;

    $dl = GLib::GList.new($dl)
      but GLib::Roles::ListData[GUPnPDIDLLiteDescriptor];
    return $dl if     $glist;

    $raw ?? $dl.Array
         !! $dl.Array.map({ GUPnP::DidlLiteDescriptor.new($_, :!ref) });
  }

  method get_dlna_managed is also<get-dlna-managed> {
    gupnp_didl_lite_object_get_dlna_managed($!dlo);
  }

  method get_dlna_namespace is also<get-dlna-namespace> {
    gupnp_didl_lite_object_get_dlna_namespace($!dlo);
  }

  method get_genre is also<get-genre> {
    gupnp_didl_lite_object_get_genre($!dlo);
  }

  method get_id is also<get-id> {
    gupnp_didl_lite_object_get_id($!dlo);
  }

  method get_parent_id is also<get-parent-id> {
    gupnp_didl_lite_object_get_parent_id($!dlo);
  }

  method get_properties (Str() $name, :$glist = False, :$raw = False)
    is also<get-properties>
  {
    my $pl = gupnp_didl_lite_object_get_properties($!dlo, $name);

    return Nil unless $pl;
    return $pl if     $glist && $raw;

    $pl = GLib::GList.new($pl) but GLib::Roles::ListData[xmlNode];
    return $pl if     $glist;

    $pl.Array;
  }

  method get_pv_namespace is also<get-pv-namespace> {
    gupnp_didl_lite_object_get_pv_namespace($!dlo);
  }

  method get_resources (:$glist = False, :$raw = False) is also<get-resources> {
    my $rl = gupnp_didl_lite_object_get_resources($!dlo);

    return Nil unless $rl;
    return $rl if     $glist && $raw;

    $rl = GLib::GList.new($rl)
      but GLib::Roles::ListData[GUPnPDIDLLiteResource];
    return $rl if     $glist;

    $raw ?? $rl.Array
         !! $rl.Array.map({ GUPnP::DidlLiteResource.new($_, :!ref) });
  }

  method get_restricted is also<get-restricted> {
    so gupnp_didl_lite_object_get_restricted($!dlo);
  }

  method get_title is also<get-title> {
    gupnp_didl_lite_object_get_title($!dlo);
  }

  method get_title_xml_string is also<get-title-xml-string> {
    gupnp_didl_lite_object_get_title_xml_string($!dlo);
  }

  method get_track_number is also<get-track-number> {
    gupnp_didl_lite_object_get_track_number($!dlo);
  }

  method get_track_number_xml_string is also<get-track-number-xml-string> {
    gupnp_didl_lite_object_get_track_number_xml_string($!dlo);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gupnp_didl_lite_object_get_type, $n, $t );
  }

  method get_update_id is also<get-update-id> {
    gupnp_didl_lite_object_get_update_id($!dlo);
  }

  method get_upnp_class is also<get-upnp-class> {
    gupnp_didl_lite_object_get_upnp_class($!dlo);
  }

  method get_upnp_class_xml_string is also<get-upnp-class-xml-string> {
    gupnp_didl_lite_object_get_upnp_class_xml_string($!dlo);
  }

  method get_upnp_namespace is also<get-upnp-namespace> {
    gupnp_didl_lite_object_get_upnp_namespace($!dlo);
  }

  method get_write_status is also<get-write-status> {
    gupnp_didl_lite_object_get_write_status($!dlo);
  }

  method get_xml_node is also<get-xml-node> {
    gupnp_didl_lite_object_get_xml_node($!dlo);
  }

  method get_xml_string is also<get-xml-string> {
    gupnp_didl_lite_object_get_xml_string($!dlo);
  }

  method is_restricted_set is also<is-restricted-set> {
    so gupnp_didl_lite_object_is_restricted_set($!dlo);
  }

  method set_album (Str() $album) is also<set-album> {
    gupnp_didl_lite_object_set_album($!dlo, $album);
  }

  method set_album_art (Str() $album_art) is also<set-album-art> {
    gupnp_didl_lite_object_set_album_art($!dlo, $album_art);
  }

  method set_artist (Str() $artist) is also<set-artist> {
    gupnp_didl_lite_object_set_artist($!dlo, $artist);
  }

  method set_author (Str() $author) is also<set-author> {
    gupnp_didl_lite_object_set_author($!dlo, $author);
  }

  method set_creator (Str() $creator) is also<set-creator> {
    gupnp_didl_lite_object_set_creator($!dlo, $creator);
  }

  method set_date (Str() $date) is also<set-date> {
    gupnp_didl_lite_object_set_date($!dlo, $date);
  }

  method set_description (Str() $description) is also<set-description> {
    gupnp_didl_lite_object_set_description($!dlo, $description);
  }

  method set_dlna_managed (Int() $dlna_managed)
    is also<set-dlna-managed>
  {
    my GUPnPOCMFlags $d = $dlna_managed;
    gupnp_didl_lite_object_set_dlna_managed($!dlo, $dlna_managed);
  }

  method set_genre (Str() $genre) is also<set-genre> {
    gupnp_didl_lite_object_set_genre($!dlo, $genre);
  }

  method set_id (Str() $id) is also<set-id> {
    gupnp_didl_lite_object_set_id($!dlo, $id);
  }

  method set_parent_id (Str() $parent_id) is also<set-parent-id> {
    gupnp_didl_lite_object_set_parent_id($!dlo, $parent_id);
  }

  method set_restricted (Int() $restricted) is also<set-restricted> {
    my gboolean $r = $restricted.so.Int;
    gupnp_didl_lite_object_set_restricted($!dlo, $r);
  }

  method set_title (Str() $title) is also<set-title> {
    gupnp_didl_lite_object_set_title($!dlo, $title);
  }

  method set_track_number (Int() $track_number) is also<set-track-number> {
    my gint $t = $track_number;
    gupnp_didl_lite_object_set_track_number($!dlo, $t);
  }

  method set_update_id (Int() $update_id) is also<set-update-id> {
    my guint $u = $update_id;
    gupnp_didl_lite_object_set_update_id($!dlo, $u);
  }

  method set_upnp_class (Str() $upnp_class) is also<set-upnp-class> {
    gupnp_didl_lite_object_set_upnp_class($!dlo, $upnp_class);
  }

  method set_write_status (Str() $write_status) is also<set-write-status> {
    gupnp_didl_lite_object_set_write_status($!dlo, $write_status);
  }

  method unset_artists is also<unset-artists> {
    gupnp_didl_lite_object_unset_artists($!dlo);
  }

  method unset_update_id is also<unset-update-id> {
    gupnp_didl_lite_object_unset_update_id($!dlo);
  }

  method update_id_is_set is also<update-id-is-set> {
    so gupnp_didl_lite_object_update_id_is_set($!dlo);
  }

}
