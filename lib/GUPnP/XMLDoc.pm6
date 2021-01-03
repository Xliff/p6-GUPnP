use v6.c;

use GUPnP::Raw::Types;
use GUPnP::Raw::XMLDoc;

use LibXML::Document;

use GLib::Roles::Object;

our subset GUPnPXMLDocAncestry is export of Mu
  where GUPnPXMLDoc | GObject;

our subset XMLDocish is export of Mu
  where xmlDoc | LibXML::Document;

class GUPnP::XMLDoc {
  also does GLib::Roles::Object;

  has GUPnPXMLDoc $!xd;

  submethod BUILD (:$xml-doc) {
    self.setGUPnPXMLDoc($xml-doc) if $xml-doc;
  }

  method setGUPnPXMLDoc (GUPnPXMLDocAncestry $_) {
    my $to-parent;

    $!xd = do {
      where GUPnpXMLDoc {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPXMLDoc, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::XMLDoc
  { $!xd }
  
  multi method new (GUPnPXMLDocAncestry $xml-doc, :$ref = True) {
    return Nil unless $xml-doc;

    my $o = self.bless( :$xml-doc );
    $o.ref if $ref;
    $o;
  }
  multi method new (XMLDocish $xmlDoc is copy) {
    $xmlDoc .= raw if $xmlDoc ~~ LibXML::Document;

    my $xml-doc = gupnp_xml_doc_new($xmlDoc);

    $xml-doc ?? self.bless( :$xml-doc ) !! Nil;
  }

  method new_from_path (
    Str()                   $path,
    CArray[Pointer[GError]] $error = gerror
  ) {
    gupnp_xml_doc_new_from_path($path, $error);

    $xml-doc ?? self.bless( :$xml-doc ) !! Nil;
  }

  method get_doc (:$raw = False) {
    my $xd = gupnp_xml_doc_get_doc($!xd);

    $xd ??
      ( $raw ?? $xd !! LibXML::Document.new(raw => $xd) )
      !!
      Nil;
  }

}
