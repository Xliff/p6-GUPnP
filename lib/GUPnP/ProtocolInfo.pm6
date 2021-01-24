use v6.c;

use NativeCall;
use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::ProtocolInfo;

use GLib::Roles::Object;

our subset GUPnPProtocolInfoAncestry is export of Mu
  where GUPnPProtocolInfo | GObject;

class GUPnP::ProtocolInfo {
  also does GLib::Roles::Object;

  has GUPnPProtocolInfo $!pi is implementor;

  submethod BUILD (:$protocol) {
    self.setGUPnPProtocolInfo($protocol) if $protocol;
  }

  method setGUPnPProtocolInfo (GUPnPProtocolInfoAncestry $_) {
    my $to-parent;

    $!pi = do {
      when GUPnPProtocolInfo {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPProtocolInfo, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPProtocolInfo
    is also<GUPnPProtocolInfo>
  { $!pi }

  proto method new (|)
  { * }

  multi method new (GUPnPProtocolInfoAncestry $protocol, :$ref = True) {
    return Nil unless $protocol;

    my $o = self.bless( :$protocol );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $protocol = gupnp_protocol_info_new();

    $protocol ?? self.bless( :$protocol ) !! Nil;
  }

  method new_from_string (
    Str()                   $protocol_info,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<new-from-string>
  {
    clear_error;
    my $protocol = gupnp_protocol_info_new_from_string(
      $protocol_info,
      $error
    );
    set_error($ERROR);

    $protocol ?? self.bless( :$protocol ) !! Nil;
  }

  # Type: GUPnPDLNAConversion
  method dlna-conversion is rw is also<dlna_conversion> {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromEnum(GUPnPDLNAConversion) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('dlna-conversion', $gv)
        );
        GUPnPDLNAConversionEnum( $gv.valueFromEnum(GUPnPDLNAConversion) );
      },
      STORE => -> $, Int() $val is copy {
        $gv.vaueFromEnum(GUPnPDLNAConversion) = $val;
        self.prop_set('dlna-conversion', $gv);
      }
    );
  }

  # Type: GUPnPDLNAFlags
  method dlna-flags is rw is also<dlna_flags> {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromEnum(GUPnPDLNAFlags) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('dlna-flags', $gv)
        );
        $gv.valueFromEnum(GUPnPDLNAFlags);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GUPnPDLNAFlags) = $val;
        self.prop_set('dlna-flags', $gv);
      }
    );
  }

  # Type: GUPnPDLNAOperation
  method dlna-operation is rw is also<dlna_operation> {
    my $gv = GLib::Value.new( GLib::Value.gtypeFromEnum(GUPnPDLNAOperation) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('dlna-operation', $gv)
        );
        GUPnPDLNAOperationEnum( $gv.valueFromEnum(GUPnPDLNAOperation) )
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GUPnPDLNAOperation) = $val;
        self.prop_set('dlna-operation', $gv);
      }
    );
  }

  # Type: gchar
  method dlna-profile is rw is also<dlna_profile> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('dlna-profile', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('dlna-profile', $gv);
      }
    );
  }

  # Type: gchar
  method mime-type is rw is also<mime_type> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('mime-type', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('mime-type', $gv);
      }
    );
  }

  # Type: gchar
  method network is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('network', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('network', $gv);
      }
    );
  }

  # Type: GStrv
  method play-speeds (:$raw = False) is rw is also<play_speeds> {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('play-speeds', $gv)
        );

        my $gsv = $gv.pointer;
        return Nil  unless $gsv;
        return $gsv if     $raw;

        $gsv = cast(CArray[Str], $gsv);
        CStringArrayToArray($gsv);
      },
      STORE => -> $, @vals is copy {
        @vals .= map(-> $s is rw {
          unless $s ~~ Str {
            if $s.^can('Str') -> $m {
              $s = $m($s);
            } else {
              die 'Value passed to @vals must be Str-compatible';
            }
          }
          $s;
        });
        $gv.pointer = cast( Pointer, resolve-gstrv(@vals) );
        self.prop_set('play-speeds', $gv);
      }
    );
  }

  # Type: gchar
  method protocol is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('protocol', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('protocol', $gv);
      }
    );
  }

  method get_dlna_conversion is also<get-dlna-conversion> {
    GUPnPDLNAConversionEnum( gupnp_protocol_info_get_dlna_conversion($!pi) )
  }

  method get_dlna_flags is also<get-dlna-flags> {
    gupnp_protocol_info_get_dlna_flags($!pi);
  }

  method get_dlna_operation is also<get-dlna-operation> {
    GUPnPDLNAOperationEnum( gupnp_protocol_info_get_dlna_operation($!pi) );
  }

  method get_dlna_profile is also<get-dlna-profile> {
    gupnp_protocol_info_get_dlna_profile($!pi);
  }

  method get_mime_type is also<get-mime-type> {
    gupnp_protocol_info_get_mime_type($!pi);
  }

  method get_network is also<get-network> {
    gupnp_protocol_info_get_network($!pi);
  }

  method get_play_speeds is also<get-play-speeds> {
    CStringArrayToArray( gupnp_protocol_info_get_play_speeds($!pi) );
  }

  method get_protocol is also<get-protocol> {
    gupnp_protocol_info_get_protocol($!pi);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gupnp_protocol_info_get_type, $n, $t );
  }

  method is_compatible (GUPnPProtocolInfo() $info2) is also<is-compatible> {
    so gupnp_protocol_info_is_compatible($!pi, $info2);
  }

  method set_dlna_conversion (Int() $conversion)
    is also<set-dlna-conversion>
  {
    my GUPnPDLNAConversion $c = $conversion;
    gupnp_protocol_info_set_dlna_conversion($!pi, $c);
  }

  method set_dlna_flags (Int() $flags) is also<set-dlna-flags> {
    my GUPnPDLNAFlags $f = $flags;
    gupnp_protocol_info_set_dlna_flags($!pi, $f);
  }

  method set_dlna_operation (Int() $operation)
    is also<set-dlna-operation>
  {
    my GUPnPDLNAOperation $o = $operation;
    gupnp_protocol_info_set_dlna_operation($!pi, $o);
  }

  method set_dlna_profile (Str() $profile) is also<set-dlna-profile> {
    gupnp_protocol_info_set_dlna_profile($!pi, $profile);
  }

  method set_mime_type (Str() $mime_type) is also<set-mime-type> {
    gupnp_protocol_info_set_mime_type($!pi, $mime_type);
  }

  method set_network (Str() $network) is also<set-network> {
    gupnp_protocol_info_set_network($!pi, $network);
  }

  proto method set_play_speeds (|)
    is also<set-play-speeds>
  { * }

  multi method set_play_speeds (@speeds) {
    samewith( ArrayToCArray(Str, @speeds) );
  }
  multi method set_play_speeds (CArray[Str] $speeds)  {
    gupnp_protocol_info_set_play_speeds($!pi, $speeds);
  }

  method set_protocol (Str() $protocol) is also<set-protocol> {
    gupnp_protocol_info_set_protocol($!pi, $protocol);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gupnp_protocol_info_to_string($!pi);
  }

}
