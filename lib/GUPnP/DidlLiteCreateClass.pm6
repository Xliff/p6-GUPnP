use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::DidlLiteCreateClass;

use GLib::Roles::Object;

our subset GUPnPDIDLLiteCreateClassAncestry is export of Mu
  where GUPnPDIDLLiteCreateClass | GObject;

class GUPnP::DidlLiteCreateClass {
  also does GLib::Roles::Object;

  has GUPnPDIDLLiteCreateClass $!dlcc;

  submethod BUILD ( :$create-class ) {
    self.setGUPnPDIDLLiteCreateClass($create-class) if $create-class;
  }

  method setGUPnPDIDLLiteCreateClass (GUPnPDIDLLiteCreateClassAncestry $_) {
    my $to-parent;

    $!dlcc = do {
      when GUPnPDIDLLiteCreateClass {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDIDLLiteCreateClass, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDIDLLiteCreateClass
    is also<GUPnPDIDLLiteCreateClass>
  { $!dlcc }

  method new (GUPnPDIDLLiteCreateClassAncestry $create-class, :$ref = True) {
    return Nil unless $create-class;

    my $o = self.bless( :$create-class );
    $o.ref if $ref;
    $o;
  }

  method get_content is also<get-content> {
    gupnp_didl_lite_create_class_get_content($!dlcc);
  }

  method get_friendly_name is also<get-friendly-name> {
    gupnp_didl_lite_create_class_get_friendly_name($!dlcc);
  }

  method get_include_derived is also<get-include-derived> {
    so gupnp_didl_lite_create_class_get_include_derived($!dlcc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_didl_lite_create_class_get_type,
      $n,
      $t
    );
  }

  method get_xml_node is also<get-xml-node> {
    gupnp_didl_lite_create_class_get_xml_node($!dlcc);
  }

  method set_content (Str() $content) is also<set-content> {
    gupnp_didl_lite_create_class_set_content($!dlcc, $content);
  }

  method set_friendly_name (Str() $friendly_name) is also<set-friendly-name> {
    gupnp_didl_lite_create_class_set_friendly_name($!dlcc, $friendly_name);
  }

  method set_include_derived (Int() $include_derived)
    is also<set-include-derived>
  {
    my gboolean $i = $include_derived.so.Int;
    gupnp_didl_lite_create_class_set_include_derived($!dlcc, $i);
  }

}
