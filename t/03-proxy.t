use v6.c;

use GUPnP::Raw::Types;
use GUPnP::Raw::ServiceProxyAction;

use GLib::MainLoop;
use GLib::Value;

use SOUP::URI;
use GUPnP::Context;
use GUPnP::ControlPoint;
use GUPnP::ServiceInfo;
use GUPnP::ServiceProxy;

sub on-service-proxy-available ($p) {
  CONTROL { when CX::Warn  { say .message; .backtrace.concise.say; .resume } }
  my $proxy    = GUPnP::ServiceProxy.new($p);
  my $location = $proxy.location;

  say qq:to/OUT/;
    ContentDirectory available:
    \tlocation: { $location }
    OUT

  $proxy.add-notify(
    'SystemUpdateID',
    G_TYPE_INT,
    -> *@a {
      CATCH { default { .message.say; .backtrace.concise.say } }
      say qq:to/OUT/;
        Received a notification for variable { @a[1] }",
          \tvalue: { GLib::Value.new( @a[2] ).value }
          \tuser data: Test
        OUT
    }
  );

  $proxy.subscription-lost.tap(-> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }
    say "Lost subscription { @a[1].message }";
  });

  my $action = GUPnPServiceProxyAction.new(
    'Browse', [
      ObjectID       => gv_str('0'),
      BrowseFlag     => gv_str('BrowseDirectChildren'),
      Filter         => gv_str('*'),
      StartingIndex  => gv_uint(0),
      RequestedCount => gv_uint(0),
      SortCriteria   => gv_str('')
    ]
  );

  $proxy.call-action($action);
  if $ERROR {
    say "Action Error: { $ERROR.message }";
    $action.unref;
    return;
  }

  my $oa = $action.get-result([
    Result         => G_TYPE_STRING,
    NumberReturned => G_TYPE_UINT,
    TotalMatches   => G_TYPE_UINT
  ]);
  if $ERROR {
    say "Result Error: { $ERROR.message }";
    $action.unref;
    return;
  }

  say qq:to/OUT/;
    Browse returned:
    \tResult: { $oa<Result> ?? $oa<Result>.value !! 'NO RESULT' }
    \tNumberReturned: { $oa<NumberReturned> ?? $oa<NumberReturned>.value
                                            !! 'NO RESULT' }
    \tTotalMatches: { $oa<TotalMatches> ?? $oa<TotalMatches>.value
                                        !! 'NO RESULT' }
    OUT

  $action.unref;
}

sub MAIN {
  my $context = GUPnP::Context.new(:init);
  die "Error creating the GUPnP context: { $ERROR.message }" if $ERROR;

  my $cp = GUPnP::ControlPoint.new(
    $context,
    'urn:schemas-upnp-org:service:ContentDirectory:1'
  );
  $cp.service-proxy-available.tap(-> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }
    on-service-proxy-available( @a[1] )
  });
  $cp.service-proxy-unavailable.tap(-> *@a {
    CATCH { default { .message.say; .backtrace.concise.say } }
    say qq:to/OUT/
      ContentDirectory unavailable:
      \tlocation: { GUPnP::ServiceProxy.new( @a[1] ).location }
      OUT
  });
  $cp.active = True;

  (my $loop = GLib::MainLoop.new).run;
  .unref for $cp, $loop;
}
