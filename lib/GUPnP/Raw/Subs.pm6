use v6.c;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;

use GLib::GList;
use GLib::Value;

use GLib::Roles::ListData;

unit package GUPnP::Raw::Subs;

sub handle-out-ntv ($rv, $on is copy, $ot is copy, $ov is copy, $glist, $raw)
  is export
{
  return Nil unless $rv;
  $ov = ppr($ov);
  return ($rv, $on, $ot, $ov) if $glist && $raw;

  $on = GLib::GList.new($on) but GLib::Roles::ListData[Str];
  $ot = GLib::GList.new($ot) but GLib::Roles::ListData[GType, :direct];
  $ov = GLib::GList.new($ov) but GLib::Roles::ListData[GValue];
  return ($rv, $on, $ot, $ov) if $glist;

  (
    $rv,
    $on.Array,
    $ot.Array,
    $raw ?? $ov.Array !! $ov.Array.map({ GLib::Value.new($_) })
  );
}
