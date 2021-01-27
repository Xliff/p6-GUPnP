use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;

use GLib::Roles::Object;

subset GUPnPFeatureAncestry is export of Mu
  where GUPnPFeature | GObject;

class GUPnP::Feature {
  also does GLib::Roles::Object;

  has GUPnPFeature $!f;

  submethod BUILD (:$parser) {
    self.setGUPnPFeature($parser) if $parser;
  }

  method setGUPnPFeature (GUPnPFeatureAncestry $_) {
    my $to-parent;

    $!f = do {
      when GUPnPFeature {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPFeature, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPFeature
    is also<GUPnPFeature>
  { $!f }

  multi method new (GUPnPFeatureAncestry $parser, :$ref = True) {
    return Nil unless $parser;

    my $o = self.bless( :$parser );
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
        warn 'name is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method object-ids is rw  is also<object_ids> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('object-ids', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'object-ids is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method version is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('version', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'version is a construct-only attribute'
      }
    );
  }

  method get_name is also<get-name> {
    gupnp_feature_get_name($!f);
  }

  method get_object_ids is also<get-object-ids> {
    gupnp_feature_get_object_ids($!f);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_feature_get_type,
      $n,
      $t
    );
  }

  method get_version is also<get-version> {
    gupnp_feature_get_version($!f);
  }

}

### /usr/include/gupnp-av-1.0/libgupnp-av/gupnp-feature.h

sub gupnp_feature_get_name (GUPnPFeature $feature)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_feature_get_object_ids (GUPnPFeature $feature)
  returns Str
  is native(gupnp-av)
  is export
{ * }

sub gupnp_feature_get_type ()
  returns GType
  is native(gupnp-av)
  is export
{ * }

sub gupnp_feature_get_version (GUPnPFeature $feature)
  returns Str
  is native(gupnp-av)
  is export
{ * }
