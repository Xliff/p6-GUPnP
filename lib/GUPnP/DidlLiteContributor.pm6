use v6.c;

use Method::Also;

use LibXML::Raw;
use GUPnP::Raw::Types;
use GUPnP::Raw::DidlLiteContributor;

use GLib::Roles::Object;

our subset GUPnPDIDLLiteContributorAncestry is export of Mu
  where GUPnPDIDLLiteContributor | GObject;

class GUPnP::DidlLiteContributor {
  also does GLib::Roles::Object;

  has GUPnPDIDLLiteContributor $!dlc;

  submethod BUILD (:$contributor) {
    self.setGUPnPDIDLLiteContributor($contributor) if $contributor;
  }

  method setGUPnPDIDLLiteContributor (GUPnPDIDLLiteContributorAncestry $_) {
    my $to-parent;

    $!dlc = do {
      when GUPnPDIDLLiteContributor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDIDLLiteContributor, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDIDLLiteContributor
    is also<GUPnPDIDLLiteContributor>
  { $!dlc }

  method new (GUPnPDIDLLiteContributorAncestry $contributor, :$ref = True) {
    return Nil unless $contributor;

    my $o = self.bless( :$contributor );
    $o.ref if $ref;
    $o;
  }

  # Type: gchar
  method name is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: gchar
  method role is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('role', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('role', $gv);
      }
    );
  }

  # Type: gpointer (xmlNode)
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

  method get_name is also<get-name> {
    gupnp_didl_lite_contributor_get_name($!dlc);
  }

  method get_role is also<get-role> {
    gupnp_didl_lite_contributor_get_role($!dlc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_didl_lite_contributor_get_type,
      $n,
      $t
    );
  }

  method get_xml_node is also<get-xml-node> {
    gupnp_didl_lite_contributor_get_xml_node($!dlc);
  }

  method set_name (Str() $name) is also<set-name> {
    gupnp_didl_lite_contributor_set_name($!dlc, $name);
  }

  method set_role (Str() $role) is also<set-role> {
    gupnp_didl_lite_contributor_set_role($!dlc, $role);
  }

}
