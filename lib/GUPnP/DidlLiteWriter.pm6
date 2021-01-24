use v6.c;

use Method::Also;

use LibXML::Raw;
use GUPnP::Raw::Types;
use GUPnP::Raw::DidlLiteWriter;

use GUPnP::DidlLiteContainer;
use GUPnP::DidlLiteDescriptor;
use GUPnP::DidlLiteItem;

use GLib::Roles::Object;

our subset GUPnPDIDLLiteWriterAncestry is export of Mu
  where GUPnPDIDLLiteWriter | GObject;

class GUPnP::Raw::Writer {
  also does GLib::Roles::Object;

  has GUPnPDIDLLiteWriter $!dlw;

  submethod BUILD (:$writer) {
    self.setGUPnPDIDLLiteWriter($writer) if $writer;
  }

  method setGUPnPDIDLLiteWriter (GUPnPDIDLLiteWriterAncestry $_) {
    my $to-parent;

    $!dlw = do {
      when GUPnPDIDLLiteWriter {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDIDLLiteWriter, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDIDLLiteWriter
    is also<GUPnPDIDLLiteWriter>
  { $!dlw }

  multi method new (GUPnPDIDLLiteWriterAncestry $writer, :$ref = True) {
    return Nil unless $writer;

    my $o = self.bless( :$writer );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $language) {
    my $writer = gupnp_didl_lite_writer_new($language);

    $writer ?? self.bless( :$writer ) !! Nil;
  }

  # Type: gchar
  method language is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('language', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'language is a construct-only attribute'
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
        warn 'xml-node does not allow writing'
      }
    );
  }

  method add_container (:$raw = False) is also<add-container> {
    my $c = gupnp_didl_lite_writer_add_container($!dlw);

    $c ??
      ( $raw ?? $c !! GUPnP::DidlLiteContainer.new($c, :!ref) )
      !!
      Nil;
  }

  method add_descriptor (:$raw = False) is also<add-descriptor> {
    my $d = gupnp_didl_lite_writer_add_descriptor($!dlw);

    $d ??
      ( $raw ?? $d !! GUPnP::DidlLiteDescriptor.new($d, :!ref) )
      !!
      Nil;
  }

  method add_item (:$raw = False) is also<add-item> {
    my $w = gupnp_didl_lite_writer_add_item($!dlw);

    $w ??
      ( $raw ?? $w !! GUPnP::DidLiteWriter.new($w, :!ref) )
      !!
      Nil;
  }

  method filter (Str() $filter) {
    gupnp_didl_lite_writer_filter($!dlw, $filter);
  }

  method get_language is also<get-language> {
    gupnp_didl_lite_writer_get_language($!dlw);
  }

  method get_string is also<get-string> {
    gupnp_didl_lite_writer_get_string($!dlw);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &gupnp_didl_lite_writer_get_type, $n, $t );
  }

  method get_xml_node is also<get-xml-node> {
    gupnp_didl_lite_writer_get_xml_node($!dlw);
  }

}
