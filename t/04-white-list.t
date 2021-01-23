#!/usr/bin/env raku
use v6.c;

use GUPnP::Raw::Types;

use GLib::MainLoop;
use GLib::Timeout;
use GSSDP::Client;
use GUPnP::ContextManager;
use GUPnP::ControlPoint;
use GUPnP::DeviceProxy;
use GUPnP::ServiceProxy;
use GUPnP::WhiteList;

sub show-ds ($ds, :$service = False, :$available = True) {
  CATCH { default { .message.say; .backtrace.concise.say } }
  my \t := $service ?? GUPnP::ServiceProxy !! GUPnP::DeviceProxy;
  my $i = t.new($ds);

  say qq:to/OUT/;
    { $service ?? 'Service' !! 'Device' } { $available ?? '' !! 'un'}available:
    \ttype    : { $service ?? $i.service-type !! $i.device-type }
    \tlocation: { $i.location }
    OUT
}

sub show-c ($c, :$available = True) {
  say qq:to/OUT/;
    Context { $available ?? 'A' !! 'Una' }vailable:
    \tServer ID:     { $c.server-id }
    \tInterface:     { $c.interface }
    \tHost IP  :     { $c.host-ip }
    \tNetwork  :     { $c.network }
    \tActive   :     { $c.active ?? 'TRUE' !! 'FALSE' }
    OUT
}

sub on-context-available ($cm, $c) {
  CATCH { default { .message.say; .backtrace.concise.say } }
  my $client = GSSDP::Client.new( cast(GSSDPClient, $c) );

  show-c($client);
  my $cp = GUPnP::ControlPoint.new($c, 'ssdp:all');
  $cp.device-proxy-available.tap(-> *@a {
    show-ds( @a[1] )
  });
  $cp.device-proxy-unavailable.tap(-> *@a {
    show-ds( :!available, @a[1] )
  });
  $cp.service-proxy-available.tap(-> *@a {
    show-ds( :service, @a[1] );
  });
  $cp.service-proxy-unavailable.tap(-> *@a {
    show-ds( :service, :!available, @a[1] )
  });
  $cp.active = True;
  $cm.manage-control-point($cp);
}

sub print-white-list-entries ($wl) {
  CONTROL { when CX::Warn  { say .message; .backtrace.concise.say; .resume } }
  say qq:to/OUT/;
    \t\tWhite List Entries:
    { $wl.entries.map({ "\t\t\tEntry { $_ }" }).join("\n") }
    OUT
}

sub change-white-list ($cm) {
  CATCH { default { .message.say; .backtrace.concise.say } }
  state $tomato = 0;

  say qq:to/OUT/;

    Change White List:
    \t Action number { $tomato }
    OUT

  my $wl = $cm.white-list;
  given $tomato {
    when 0 {
      say "\t Add Entry eth0\n\n";
      $wl.add-entry('eth0');
    }

    when 1 {
      say "\t Enable WL\n\n";
      $wl.enabled = True;
    }

    when 2 {
      say "\t Add Entry 127.0.0.1\n\n";
      $wl.add-entry('127.0.0.1');
      print-white-list-entries($wl);
    }

    when 3 {
      say "\t Add Entry eth5\n\n";
      $wl.add-entry('eth5');
      print-white-list-entries($wl);
    }

    when 4 {
      say "\t Remove Entry eth5\n\n";
      $wl.remove-entry('eth5');
      print-white-list-entries($wl);
    }

    when 5 {
      say "\t Clear all entries\n\n";
      $wl.clear;
      print-white-list-entries($wl);
    }

    when 6 {
      say "\t Add entry wlan2\n\n";
      $wl.add-entry('wlan2');
      print-white-list-entries($wl);
    }

    when 7 {
      say "\t Disable WL\n\n";
      $wl.enabled = False;
    }

    when 8 {
      say "\t Enable WL\n\n";
      $wl.enabled = True;
    }

    when 9 {
      say "\t Connect to wlan0\n\n";
      GLib::Timeout.add-seconds(35, -> *@a { change-white-list($cm) });
    }

    when 10 {
      say "\t Add entry wlan0\n\n";
      $wl.add-entry('wlan0');
    }

  }
  $tomato++;
  $tomato < 11 && $tomato != 10;
}

sub MAIN {
  my $cm = GUPnP::ContextManager.create;
  $cm.context-available.tap(  -> *@a { on-context-available( |@a[^2] ) });

  $cm.context-unavailable.tap( -> *@a {
    show-c( GSSDP::Client.new( @a[1] ), :!available );
  });

  my $loop = GLib::MainLoop.new;
  my $id   = GLib::Timeout.add-seconds(5, -> *@a { change-white-list($cm) });
  $loop.run;
  $loop.unref;
  GLib::Source.remove($id);
  $cm.unref;
}
