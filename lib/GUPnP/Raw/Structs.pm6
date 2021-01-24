use v6.c;

use Method::Also;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GUPnP::Raw::Definitions;
use GUPnP::Raw::Enums;

use GLib::Roles::Pointers;

unit package GUPnP::Raw::Structs;

class GUPnPServiceActionArgInfo     is repr<CStruct> is export does GLib::Roles::Pointers {
  has Str                            $.name                  ;
  has GUPnPServiceActionArgDirection $.direction             ;
  has Str                            $.related_state_variable;
  has gboolean                       $.retval                ;

  method related-state-variable { $!related_state_variable }

  method direction-str {
    GUPnPServiceActionArgDirectionEnum($!direction) ==
      GUPNP_SERVICE_ACTION_ARG_DIRECTION_IN ?? 'in' !! 'out'
  }

}

class GUPnPServiceActionInfo        is repr<CStruct> is export does GLib::Roles::Pointers {
  has Str   $.name     ;
  has GList $.arguments; #= list of #GUPnPServiceActionArgInfo

  # method arguments is rw {
  #   Proxy.new:
  #     FETCH => -> $             { $!arguments      },
  #     STORE => -> $, GList() \l { $!arguments := l };
  # }
  method arg-list (:$glist = False) is also<arg_list> {
    return Nil unless $.arguments;

    my $al = GLib::GList.new($.arguments)
      but GLib::Roles::ListData[GUPnPServiceActionArgInfo];
    return $al if $glist;

    $al.Array;
  }
}

class GUPnPServiceStateVariableInfo is repr<CStruct> is export does GLib::Roles::Pointers {
  has Str      $.name          ;
  has gboolean $.send_events   ;
  has gboolean $.is_numeric    ;
  has GType    $.type          ;
  HAS GValue   $!default_value ;
  HAS GValue   $!minimum       ;
  HAS GValue   $!maximum       ;
  HAS GValue   $!step          ;
  has GList    $!allowed_values;

  method send-events      { $!send_events }
  method is-numeric      { $!is_numeric }

  method default_value (:$raw = False) is also<default-value> {
    $!default_value ??
      ( $raw ?? $!default_value !! GLib::Value.new($!default_value) )
      !!
      Nil
  }

  method minimum (:$raw = False) {
    $!minimum ??
      ( $raw ?? $!minimum !! GLib::Value.new($!minimum) )
      !!
      Nil
  }

  method maximum (:$raw = False) {
    $!maximum ??
      ( $raw ?? $!maximum !! GLib::Value.new($!maximum) )
      !!
      Nil
  }

  method step (:$raw = False) {
    $!step ??
      ( $raw ?? $!step !! GLib::Value.new($!step) )
      !!
      Nil
  }

  method allowed_values (:$glist = False, :$raw = False)
    is also<allowed-values>
  {
    return Nil unless $!allowed_values;
    return $!allowed_values if $glist && $raw;

    my $avl = GLib::GList.new($!allowed_values)
      but GLib::Roles::ListData[Str];
    return $avl if $glist;
    $avl.Array;
  }

}

class GUPnPDIDLLiteCreateClass is repr<CStruct> is export does GLib::Roles::Pointers {
  HAS GObject  $.parent;
  has gpointer $!priv;
}
