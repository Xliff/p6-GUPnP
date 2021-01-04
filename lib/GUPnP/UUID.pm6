use v6.c;

use NativeCall;

use GLib::Roles::StaticClass;

use GUPnP::Raw::Definitions;

class GUPnP::UUID {
  also does GLib::Roles::StaticClass;

  method get {
    gupnp_get_uuid();
  }
}

sub gupnp_get_uuid ()
  returns Str
  is export
  is native(gupnp)
{ * }
