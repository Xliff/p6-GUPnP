#!/usr/bin/env raku

use GLib::Raw::Types;

use GLib::MainLoop;
use GLib::Object::Type;
use GIO::Cancellable;
use GUPnP::Context;
use GUPnP::ControlPoint;
use GUPnP::ServiceIntrospection;
use GUPnP::ServiceProxy;

sub print-action-arguments ($args) {
  return unless $args;
  for $args[] {
    say qq:to/OUT/;
      \t\tname:{ .name }
      \t\tdirection: { .direction-str }
      \t\trelated state variable: { .related-state-variable }
      OUT
  }
}

sub print-actions ($i) {
  if $i.list-actions[] -> $al {
    for $al[] {
      say "\tname: { .name }";
      print-action-arguments( .arg-list )
    }
    &say('');
  }
}

# If no solution to the "No exception handler located for warn" issue
# is discovered, this may have to be moved into its own file to do the
# following:
#   - Grab state variable from the signal handler and store for later
#   - $loop.quit after X messages have been retrieved
#   - Print stored state variables as normal.
sub print-state-variables ($i) {
  CATCH { when CX::Warn { .message.say; .resume } }
  if $i.list-state-variables -> $v {
    say 'state variables:';
    for $v[] {

      say qq:to/OUT/;
        \tname: { .name }
        \ttype: { GLib::Object::Type.new( .type ).name }
        \tsend events: { .send-events ?? 'yes' !! 'no' }
        OUT

      if .default-value -> $dv {
        say "\tdefault value: { $dv.value }" if $dv.value;
      }
      if .is-numeric {
        say qq:to/OUT/;
          \tminimum: { .minimum.value }
          \tmaximum: { .maximum.value }
          \tstep: { .step.value }
          OUT
      }
      if .allowed-values -> $av {
        say qq:to/OUT/
          \tallowed values:
          { $av.map({ "\t\t{ $_ }" }).join("\n") }
          OUT
      }
    }
    &say('');
  }
}

#my @sv;
sub got-introspection ($i is copy, $in is copy, $e) {
  $i  = GUPnP::ServiceInfo.new($i);
  $in = GUPnP::ServiceIntrospection.new($in);
  if $e {
    say "Failed to create introspection for '{ $i.udn }': { $e.message }";
    return;
  }

  say qq:to/OUT/;
    service:  { $i.udn }
    location: { $i.location }
    OUT

  print-actions($in);
  print-state-variables($in);
  #@sv.push: $in;
  $i.unref;
}

sub MAIN {
  my $context = GUPnP::Context.new(:init);
  die "Error creating the GUPnP context: { $ERROR.message }" if $ERROR;

  my $cancellable = GIO::Cancellable.new;
  my $cp          = GUPnP::ControlPoint.new($context, 'ssdp:all');

  my $loop;
  $cp.service-proxy-available.tap(-> *@a {
    #state $b = 0;
    CATCH { default { .message.say; .backtrace.concise.say } }
    GUPnP::ServiceProxy.new( @a[1] ).get-introspection-async-full(
      -> *@a {
        CATCH { default { .message.say; .backtrace.concise.say } }
        got-introspection( |@a.head(3) );
        #$loop.quit if $b++ > 8;
      },
      :$cancellable
    );
  });
  $cp.service-proxy-unavailable.tap(-> *@a {
     CATCH { default { .message.say; .backtrace.concise.say } }
     my $pxy = GUPnP::ServiceProxy.new( @a[1] );
     say qq:to/OUT/;
       Service unavailable:
       \ttype: { $pxy.service-type }
       \tloccation: { $pxy.location }
       OUT
  });
  $cp.active = True;

  ($loop = GLib::MainLoop.new).run;
  #print-state-variables($_) for @sv;

  .unref for $loop, $cp, $context;
}
