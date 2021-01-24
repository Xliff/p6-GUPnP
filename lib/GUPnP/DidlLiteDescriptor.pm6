use v6.c;

use Method::Also;

use LibXML::Raw;
use GUPnP::Raw::Types;
use GUPnP::Raw::DidlLiteDescriptor;

use GLib::Roles::Object;

our subset GUPnPDIDLLiteDescriptorAncestry is export of Mu
  where GUPnPDIDLLiteDescriptor | GObject;

class GUPnP::DidlLiteDescriptor {
  also does GLib::Roles::Object;

  has GUPnPDIDLLiteDescriptor $!dld;

  submethod BUILD (:$descriptor) {
    self.setGUPnPDIDLLiteDescriptor($descriptor) if $descriptor;
  }

  method setGUPnPDIDLLiteDescriptor (GUPnPDIDLLiteDescriptorAncestry $_) {
    my $to-parent;

    $!dld = do {
      when GUPnPDIDLLiteDescriptor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDIDLLiteDescriptor, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDIDLLiteDescriptor
    is also<GUPnPDIDLLiteDescriptor>
  { $!dld }

  multi method new (GUPnPDIDLLiteDescriptorAncestry $descriptor, :$ref = True) {
    return Nil unless $descriptor;

    my $o = self.bless( :$descriptor );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $descriptor = gupnp_didl_lite_descriptor_new();

    $descriptor ?? self.bless( :$descriptor ) !! Nil;
  }

  # Type: gchar
  method content is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('content', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('content', $gv);
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
  method metadata-type is rw  is also<metadata_type> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('metadata-type', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('metadata-type', $gv);
      }
    );
  }

  # Type: gchar
  method name-space is rw  is also<name_space> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('name-space', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name-space', $gv);
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

  method get_content is also<get-content> {
    gupnp_didl_lite_descriptor_get_content($!dld);
  }

  method get_id is also<get-id> {
    gupnp_didl_lite_descriptor_get_id($!dld);
  }

  method get_metadata_type is also<get-metadata-type> {
    gupnp_didl_lite_descriptor_get_metadata_type($!dld);
  }

  method get_name_space is also<get-name-space> {
    gupnp_didl_lite_descriptor_get_name_space($!dld);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_didl_lite_descriptor_get_type,
      $n,
      $t
    );
  }

  method get_xml_node is also<get-xml-node> {
    gupnp_didl_lite_descriptor_get_xml_node($!dld);
  }

  method set_content (Str() $content) is also<set-content> {
    gupnp_didl_lite_descriptor_set_content($!dld, $content);
  }

  method set_id (Str() $id) is also<set-id> {
    gupnp_didl_lite_descriptor_set_id($!dld, $id);
  }

  method set_metadata_type (Str() $type) is also<set-metadata-type> {
    gupnp_didl_lite_descriptor_set_metadata_type($!dld, $type);
  }

  method set_name_space (Str() $name_space) is also<set-name-space> {
    gupnp_didl_lite_descriptor_set_name_space($!dld, $name_space);
  }

}
