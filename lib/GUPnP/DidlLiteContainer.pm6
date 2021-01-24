use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::DidlLiteContainer;

use GLib::GList;
use GLib::Value;
use GUPnP::DidlLiteCreateClass;
use GUPnP::DidlLiteObject;

our subset GUPnPDIDLLiteContainerAncestry is export of Mu
  where GUPnPDIDLLiteContainer | GUPnPDIDLLiteObjectAncestry;

class GUPnP::DidlLiteContainer is GUPnP::DidlLiteObject {
  has GUPnPDIDLLiteContainer $!dlc;

  submethod BUILD (:$container) {
    self.setGUPnPDIDLLiteContainer($container) if $container;
  }

  method setGUPnPDIDLLiteContainer (GUPnPDIDLLiteContainerAncestry $_) {
    my $to-parent;

    $!dlc = do {
      when GUPnPDIDLLiteContainer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDIDLLiteContainer, $_);
      }
    }
    self.setGUPnPDIDLLiteObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDIDLLiteContainer
    is also<GUPnPDIDLLiteContainer>
  { $!dlc }

  method new (GUPnPDIDLLiteContainerAncestry $container, :$ref = True) {
    return Nil unless $container;

    my $o = self.bless( :$container );
    $o.ref if $ref;
    $o;
  }

  # Type: gint
  method child-count is rw  is also<child_count> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('child-count', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('child-count', $gv);
      }
    );
  }

  # Type: guint
  method container-update-id is rw  is also<container_update_id> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('container-update-id', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('container-update-id', $gv);
      }
    );
  }

  # Type: gboolean
  method searchable is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('searchable', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val.so.Int;
        self.prop_set('searchable', $gv);
      }
    );
  }

  # Type: gint64
  method storage-used is rw  is also<storage_used> {
    my $gv = GLib::Value.new( G_TYPE_INT64 );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('storage-used', $gv)
        );
        $gv.int64;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int64 = $val;
        self.prop_set('storage-used', $gv);
      }
    );
  }

  # Type: guint
  method total-deleted-child-count is rw  is also<total_deleted_child_count> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('total-deleted-child-count', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('total-deleted-child-count', $gv);
      }
    );
  }

  method add_create_class (Str() $create_class) is also<add-create-class> {
    gupnp_didl_lite_container_add_create_class($!dlc, $create_class);
  }

  method add_create_class_full (Str() $create_class, Int() $include_derived)
    is also<add-create-class-full>
  {
    my gboolean $i = $include_derived.so.Int;
    gupnp_didl_lite_container_add_create_class_full(
      $!dlc,
      $create_class,
      $i
    );
  }

  method add_search_class (Str() $search_class) is also<add-search-class> {
    gupnp_didl_lite_container_add_search_class($!dlc, $search_class);
  }

  method add_search_class_full (Str() $search_class, Int() $include_derived)
    is also<add-search-class-full>
  {
    my gboolean $i = $include_derived.so.Int;
    gupnp_didl_lite_container_add_search_class_full(
      $!dlc,
      $search_class,
      $i
    );
  }

  method container_update_id_is_set is also<container-update-id-is-set> {
    so gupnp_didl_lite_container_container_update_id_is_set($!dlc);
  }

  method get_child_count is also<get-child-count> {
    gupnp_didl_lite_container_get_child_count($!dlc);
  }

  method get_container_update_id is also<get-container-update-id> {
    gupnp_didl_lite_container_get_container_update_id($!dlc);
  }

  method get_create_classes (:$glist = False, :$raw = False)
    is also<get-create-classes>
  {
    my $sl = gupnp_didl_lite_container_get_create_classes($!dlc);

    return Nil unless $sl;
    return $sl if     $glist && $raw;

    $sl = GLib::GList.new($sl) but GLib::Roles::ListData[Str];
    return $sl if $glist;

    $sl.Array;
  }

  method get_create_classes_full (:$glist = False, :$raw = False)
    is also<get-create-classes-full>
  {
    my $sl = gupnp_didl_lite_container_get_create_classes_full($!dlc);

    return Nil unless $sl;
    return $sl if     $glist && $raw;

    $sl = GLib::GList.new($sl)
      but GLib::Roles::ListData[GUPnPDIDLLiteCreateClass];
    return $sl if $glist;

    $raw ?? $sl.Array
         !! $sl.Array.map({ GUPnP::DidlLiteCreateClass.new($_, :!ref) });
  }

  method get_search_classes (:$glist = False, :$raw = False)
    is also<get-search-classes>
  {
    my $sl = gupnp_didl_lite_container_get_search_classes($!dlc);

    return Nil unless $sl;
    return $sl if     $glist && $raw;

    $sl = GLib::GList.new($sl) but GLib::Roles::ListData[Str];
    return $sl if $glist;

    $sl.Array;
  }

  method get_storage_used is also<get-storage-used> {
    gupnp_didl_lite_container_get_storage_used($!dlc);
  }

  method get_total_deleted_child_count is also<get-total-deleted-child-count> {
    gupnp_didl_lite_container_get_total_deleted_child_count($!dlc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_didl_lite_container_get_type,
      $n,
      $t
    );
  }

  method set_child_count (Int() $child_count) is also<set-child-count> {
    my gint $c = $child_count;
    gupnp_didl_lite_container_set_child_count($!dlc, $c);
  }

  method set_container_update_id (Int() $update_id)
    is also<set-container-update-id>
  {
    my guint $u = $update_id;
    gupnp_didl_lite_container_set_container_update_id($!dlc, $u);
  }

  method set_searchable (Int() $searchable) is also<set-searchable> {
    my gboolean $s = $searchable.so.Int;
    gupnp_didl_lite_container_set_searchable($!dlc, $s);
  }

  method set_storage_used (Int() $storage_used) is also<set-storage-used> {
    my gint64 $s = $storage_used;
    gupnp_didl_lite_container_set_storage_used($!dlc, $s);
  }

  method set_total_deleted_child_count (Int() $count)
    is also<set-total-deleted-child-count>
  {
    my guint $c = $count;
    gupnp_didl_lite_container_set_total_deleted_child_count($!dlc, $c);
  }

  method total_deleted_child_count_is_set
    is also<total-deleted-child-count-is-set>
  {
    so gupnp_didl_lite_container_total_deleted_child_count_is_set($!dlc);
  }

  method unset_container_update_id is also<unset-container-update-id> {
    gupnp_didl_lite_container_unset_container_update_id($!dlc);
  }

  method unset_total_deleted_child_count
    is also<unset-total-deleted-child-count>
  {
    gupnp_didl_lite_container_unset_total_deleted_child_count($!dlc);
  }

}
