use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::ServiceIntrospection;

use GLib::GList;

use GLib::Roles::ListData;
use GLib::Roles::Object;

our subset GUPnPServiceIntrospectionAncestry is export of Mu
  where GUPnPServiceIntrospection | GObject;

class GUPnP::ServiceIntrospection {
  also does GLib::Roles::Object;

  has GUPnPServiceIntrospection $!si;

  my %attributes = (
    scpd => G_TYPE_POINTER;
  );

  method attributes ($key) {
    %attributes{$key}:exists ?? %attributes{$key} !! nextsame;
  }

  submethod BUILD (:$introspection) {
    self.setGUPnPServiceIntrospection($introspection) if $introspection;
  }

  method setGUPnPServiceIntrospection (GUPnPServiceIntrospectionAncestry $_) {
    my $to-parent;
    $!si = do {
      when GUPnPServiceIntrospection {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPServiceIntrospection, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPServiceIntrospection
    is also<GUPnPServiceIntrospection>
  { $!si }

  method new (GUPnPServiceIntrospection $introspection, :$ref = True) {
    return Nil unless $introspection;

    my $o = self.bless( :$introspection );
    $o.ref if $ref;
    $o;
  }

  method get_action (Str() $action_name) is also<get-action> {
    gupnp_service_introspection_get_action($!si, $action_name);
  }

  method get_state_variable (Str() $variable_name)
    is also<get-state-variable>
  {
    gupnp_service_introspection_get_state_variable($!si, $variable_name);
  }

  method list_action_names (:$glist = False, :$raw = False)
    is also<list-action-names>
  {
    my $rl = gupnp_service_introspection_list_action_names($!si);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[Str];
    return $rl if $glist;

    $rl.Array;
  }

  method list_actions (:$glist = False, :$raw = False) is also<list-actions> {
    my $rl = gupnp_service_introspection_list_actions($!si);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl)
      but GLib::Roles::ListData[GUPnPServiceActionInfo];
    return $rl if $glist;

    $rl.Array;
  }

  method list_state_variable_names (:$glist = False, :$raw = False)
    is also<list-state-variable-names>
  {
    my $rl = gupnp_service_introspection_list_state_variable_names($!si);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl) but GLib::Roles::ListData[Str];
    return $rl if $glist;

    my $l = $rl.Array;
    say "L: { $l.^name }";
  }

  method list_state_variables (:$glist = False, :$raw = False)
    is also<list-state-variables>
  {
    my $rl = gupnp_service_introspection_list_state_variables($!si);

    return Nil unless $rl;
    return $rl if $glist && $raw;

    $rl = GLib::GList.new($rl)
      but GLib::Roles::ListData[GUPnPServiceStateVariableInfo];
    return $rl if $glist;

    $rl.Array;
  }

}
