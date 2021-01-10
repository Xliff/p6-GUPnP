use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;

use GLib::GList;
use GLib::Value;

use GLib::Roles::ListData;
use GLib::Roles::Pointers;

unit package GUPnP::Raw::Definitions;

# Forced compilation counter;
constant forced = 1;

class GUPnPAcl                  is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPContext              is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPContextManager       is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPControlPoint         is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDevice               is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDeviceProxy          is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDeviceInfo           is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPResourceFactory      is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPRootDevice           is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPService              is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPServiceInfo          is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPServiceIntrospection is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPServiceProxy         is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPServiceProxyAction   is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPXMLDoc               is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPWhiteList            is repr<CPointer> is export does GLib::Roles::Pointers { }

constant gupnp        is export = 'gupnp-1.2',v0;

our enum GUPnPControlErrorEnum is export (
  GUPNP_CONTROL_ERROR_INVALID_ACTION => 401,
  GUPNP_CONTROL_ERROR_INVALID_ARGS   => 402,
  GUPNP_CONTROL_ERROR_OUT_OF_SYNC    => 403,
  GUPNP_CONTROL_ERROR_ACTION_FAILED  => 501,
);

constant GUPnPEventingError is export := guint32;
our enum GUPnPEventingErrorEnum is export <
  GUPNP_EVENTING_ERROR_SUBSCRIPTION_FAILED
  GUPNP_EVENTING_ERROR_SUBSCRIPTION_LOST
  GUPNP_EVENTING_ERROR_NOTIFY_FAILED
>;

constant GUPnPRootdeviceError is export := guint32;
our enum GUPnPRootdeviceErrorEnum is export <
  GUPNP_ROOT_DEVICE_ERROR_NO_CONTEXT
  GUPNP_ROOT_DEVICE_ERROR_NO_DESCRIPTION_PATH
  GUPNP_ROOT_DEVICE_ERROR_NO_DESCRIPTION_FOLDER
  GUPNP_ROOT_DEVICE_ERROR_NO_NETWORK
  GUPNP_ROOT_DEVICE_ERROR_FAIL
>;

constant GUPnPServerError is export := guint32;
our enum GUPnPServerErrorEnum is export <
  GUPNP_SERVER_ERROR_INTERNAL_SERVER_ERROR
  GUPNP_SERVER_ERROR_NOT_FOUND
  GUPNP_SERVER_ERROR_NOT_IMPLEMENTED
  GUPNP_SERVER_ERROR_INVALID_RESPONSE
  GUPNP_SERVER_ERROR_INVALID_URL
  GUPNP_SERVER_ERROR_OTHER
>;

constant GUPnPServiceActionArgDirection is export := guint32;
our enum GUPnPServiceActionArgDirectionEnum is export <
  GUPNP_SERVICE_ACTION_ARG_DIRECTION_IN
  GUPNP_SERVICE_ACTION_ARG_DIRECTION_OUT
>;

constant GUPnPXMLError is export := guint32;
our enum GUPnPXMLErrorEnum is export <
  GUPNP_XML_ERROR_PARSE
  GUPNP_XML_ERROR_NO_NODE
  GUPNP_XML_ERROR_EMPTY_NODE
  GUPNP_XML_ERROR_INVALID_ATTRIBUTE
  GUPNP_XML_ERROR_OTHER
>;

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

BEGIN {
  constant gupnp-helper is export = do {
    %?RESOURCES<lib/libgupnp-helper.so> ??
      %?RESOURCES<lib/libgupnp-helper.so>.absolute !!
      'lib/libgnup-helper.so';
  }
}
