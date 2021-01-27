use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;
use GLib::Raw::Object;

use GLib::GList;
use GUPnP::Feature;

subset GUPnPFeatureListParserAncestry is export of Mu
  where GUPnPFeatureListParser | GObject;

class GUPnP::FeatureListParser {
  also does GLib::Roles::Object;

  has GUPnPFeatureListParser $!flp;

  submethod BUILD (:$parser) {
    self.setGUPnPFeatureListParser($parser) if $parser;
  }

  method setGUPnPFeatureListParser (GUPnPFeatureListParserAncestry $_) {
    my $to-parent;

    $!flp = do {
      when GUPnPFeatureListParser {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPFeatureListParser, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPFeatureListParser
    is also<GUPnPFeatureListParser>
  { $!flp }

  multi method new (GUPnPFeatureListParserAncestry $parser, :$ref = True) {
    return Nil unless $parser;

    my $o = self.bless( :$parser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $parser = gupnp_feature_list_parser_new();

    $parser ?? self.bless( :$parser ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_feature_list_parser_get_type,
      $n,
      $t
    );
  }

  method parse_text (
    Str()                   $text,
    CArray[Pointer[GError]] $error  = gerror,
                            :$glist = False,
                            :$raw   = False
  )
    is also<parse-text>
  {
    my $fl = gupnp_feature_list_parser_parse_text($!flp, $text, $error);

    returnGList(
      $fl,
      $glist,
      $raw,
      GUPnPFeature,
      GUPnp::Feature
    );
  }

}


### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-feature-list-parser.h

sub gupnp_feature_list_parser_get_type ()
  returns GType
  is native(gupnp)
  is export
{ * }

sub gupnp_feature_list_parser_new ()
  returns GUPnPFeatureListParser
  is native(gupnp)
  is export
{ * }

sub gupnp_feature_list_parser_parse_text (
  GUPnPFeatureListParser  $parser,
  Str                     $text,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gupnp)
  is export
{ * }
