use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;

use GLib::Roles::Object;

our subset GUPnPLastChangeParserAncestry is export of Mu
  where GUPnPLastChangeParser | GObject;

class GUPnP::LastChangeParser {
  also does GLib::Roles::Object;

  has GUPnPLastChangeParser $!lcp;

  method setGUPnPLastChangeParser (GUPnPLastChangeParserAncestry $_) {
    my $to-parent;

    $!lcp = do {
      when GUPnPLastChangeParser {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPLastChangeParser, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPLastChangeParser
    is also<GUPnPLastChangeParser>
  { $!lcp }

  multi method new (GUPnPLastChangeParserAncestry $parser, :$ref = True) {
    return Nil unless $parser;

    my $o = self.bless( :$parser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $parser = gupnp_last_change_parser_new();

    $parser ?? self.bless( :$parser ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_last_change_parser_get_type,
      $n,
      $t
    );
  }

  proto method parse_last_change (|)
      is also<parse-last-change>
  { * }

  multi method parse_last_change (
    Int()                   $instance_id,
    Str()                   $last_change_xml,
                            @names,
                            @types,
                            :$error          = gerror
  ) {
    die '@names and @types have different sizes!' unless +@names == +@types;
    my $vp = GLib::Roles::TypedBuffer[GValue].new-typedbuffer-obj(
      :sized,
      @names.elems
    );

    samewith(
      $instance_id,
      $last_change_xml,
      ArrayToCArray(Str, @names),
      ArrayToCArray(GType, @types, :double),
      $vp.p,
      @names.elems,
      $error
    );
  }
  multi method parse_last_change (
    Int()                   $instance_id,
    Str()                   $last_change_xml,
    CArray[Str]             $names,
    CArray[GType]           $types,
    CArray[GValue]          $values,
    Int()                   $num_items,
    CArray[Pointer[GError]] $error            = gerror,
                            :$all             = False
  ) {
    my guint ($iid, $ni) = ($instance_id, $num_items);

    clear_error;
    my $rv = so helper_gupnp_last_change_parser_parse_last_change (
    	self,
    	$iid,
    	$last_change_xml,
    	$error,
      $names,
      $types,
    	$values,
    	$ni
    );
    set_error($error);

    my %h = (do gather for $names.kv -> $k, $v {
      Pair.new( $v, $values[$k] );
    }).Hash;
    $all.not ?? $rv !! ($rv, %h);
  }

}

sub gupnp_last_change_parser_new ()
  returns GUPnPLastChangeParser
  is export
  is native(gupnp-av)
{ * }

sub gupnp_last_change_parser_get_type ()
  returns GType
  is export
  is native(gupnp-av)
{ * }

sub helper_gupnp_last_change_parser_parse_last_change ()
  returns gboolean
  is export
  is native(gupnp-helper)
{ * }
