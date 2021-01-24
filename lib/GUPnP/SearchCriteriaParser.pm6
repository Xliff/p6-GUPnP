use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;

use GLib::Roles::Object;
use GUPnP::Roles::Signals::SearchCriteriaParser;

our subset GUPnPSearchCriteriaParserAncestry is export of Mu
  where GUPnPSearchCriteriaParser | GObject;

class GUPnP::SearchCriteriaParser {
  also does GLib::Roles::Object;
  also does GUPnP::Roles::Signals::SearchCriteriaParser;

  has GUPnPSearchCriteriaParser $!p;

  submethod BUILD (:$parser) {
    self.setGUPnPSearchCriteriaParser($parser) if $parser;
  }

  method setGUPnPSearchCriteriaParser (GUPnPSearchCriteriaParserAncestry $_) {
    my $to-parent;

    $!p = do {
      when GUPnPSearchCriteriaParser {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPSearchCriteriaParser, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPSearchCriteriaParser
    is also<GUPnPSearchCriteriaParser>
  { $!p }

  proto method new (|)
  { * }

  multi method new (GUPnPSearchCriteriaParserAncestry $parser, :$ref = True) {
    return Nil unless $parser;

    my $o = self.bless( :$parser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $parser = gupnp_search_criteria_parser_new();

    $parser ?? self.bless( :$parser ) !! Nil;
  }

  method error_quark (GUPnP::SearchCriteriaParser:U: ) is also<error-quark> {
    gupnp_search_criteria_parser_error_quark();
  }

  # Is originally:
  # GUPnPSearchCriteriaParser, gpointer --> void
  method begin-parens {
    self.connect($!p, 'begin-parens');
  }

  # Is originally:
  # GUPnPSearchCriteriaParser, gpointer --> void
  method conjunction {
    self.connect($!p, 'conjunction');
  }

  # Is originally:
  # GUPnPSearchCriteriaParser, gpointer --> void
  method disjunction {
    self.connect($!p, 'disjunction');
  }

  # Is originally:
  # GUPnPSearchCriteriaParser, gpointer --> void
  method end-parens {
    self.connect($!p, 'end-parens');
  }

  # Is originally:
  # GUPnPSearchCriteriaParser, gchar, GUPnPSearchCriteriaOp, gchar, gpointer, gpointer --> gboolean
  method expression {
    self.connect-expression($!p);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_search_criteria_parser_get_type,
      $n,
      $t
    );
  }

  method parse_text (Str() $text, CArray[Pointer[GError]] $error = gerror) is also<parse-text> {
    clear_error;
    my $rv = so gupnp_search_criteria_parser_parse_text($!p, $text, $error);
    set_error($error);
    $rv;
  }

}


### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-search-criteria-parser.h

sub gupnp_search_criteria_parser_error_quark ()
  returns GQuark
  is native(gupnp-av)
  is export
{ * }

sub gupnp_search_criteria_parser_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_search_criteria_parser_new ()
  returns GUPnPSearchCriteriaParser
  is native(gupnp-av)
  is export
{ * }

sub gupnp_search_criteria_parser_parse_text (
  GUPnPSearchCriteriaParser $parser,
  Str                       $text,
  CArray[Pointer[GError]]   $error
)
  returns uint32
  is native(gupnp-av)
  is export
{ * }
