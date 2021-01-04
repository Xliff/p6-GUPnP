#!/usr/bin/env raku
use v6;

use GLib::Raw::Types;

use GLib::MainLoop;
use GUPnP::Context;
use GUPnP::ControlPoint;
use GUPnP::DeviceProxy;
use GUPnP::ServiceProxy;

sub MAIN {
  my $context = GUPnP::Context.new(:init);
  die "Error creating the GUPnPcontext: { $ERROR.message }" if $ERROR;

  my $cp = GUPnP::ControlPoint.new($context, 'ssdp:all');

  sub print-device-info ($p, :$un = False) {
    my $pxy = GUPnP::DeviceProxy.new($p);
    say qq:to/OUT/
      Service { $un ?? 'un' !! '' }available:
        type:     { $pxy.get_device_type }
        location: { $pxy.get_location }
      OUT
  }

  sub print-service-info ($p, :$un = False) {
    my $pxy = GUPnP::ServiceProxy.new($p);
    say qq:to/OUT/
      Device { $un ?? 'un' !! '' }available:
        type:     { $pxy.get_service_type }
        location: { $pxy.get_location }
      OUT
  }

  $cp.device-proxy-available.tap(-> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }
    print-device-info( @a[1] );
  });
  $cp.device-proxy-unavailable.tap(-> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }
    print-device-info( @a[1], :un );
  });
  $cp.service-proxy-available.tap(-> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }
    print-service-info( @a[1] );
  });
  $cp.service-proxy-unavailable.tap(-> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }
    print-service-info( @a[1], :un );
  });

  $cp.active = True;
  given GLib::MainLoop.new {
    .run; .unref;
  }
  .unref for $cp, $context;
}
