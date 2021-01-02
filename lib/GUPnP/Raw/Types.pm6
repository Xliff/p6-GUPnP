use v6.c;

use GLib::Raw::Exports;
use GIO::Raw::Exports;
use GSSDP::Raw::Exports;
use GUPnP::Raw::Exports;

unit package GSSDP::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Struct_Subs;
need GLib::Raw::Subs;
need GIO::Raw::Definitions;
need GIO::Raw::Enums;
need GIO::Raw::Exports;
need GIO::Raw::Structs;
need GIO::Raw::Subs;
need GIO::Raw::Quarks;
need GIO::DBus::Raw::Types;
need GSSDP::Raw::Definitions;
need GUPnP::Raw::Definitions;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@gio-exports,
                         |@gssdb-exports,
                         |@gupnp-exports;
}
