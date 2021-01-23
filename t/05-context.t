#!/usr/bin/env raku
use v6.c;

use Test;

use GUPnP::Raw::Types;

use GLib::MainLoop;
use GLib::MappedFile;
use GUPnP::Context;
use SOUP::Message;
use SOUP::Session;

sub create-context ($p = 0) {
  GUPnP::Context.new_initable(
    host-ip      => '127.0.0.1',
    msearch-port => $p
  )
}

sub compare-carray ($ca1, $ca2, $l, :$start1 = 0, :$start2 = 0) {
  return False unless $ca1[$start1 + $_] == $ca2[$start2 + $_] for ^$l;
  True;
}

sub request-range-and-compare (
  $f,
  $s,
  $l,
  $u,
  $ws is copy = 0,
  $we is copy = 0
) {
  my $full-length = $f.length;
  my $want-length = $we == -1 ?? ($ws < 0 ?? -$ws !! $full-length - $ws)
                              !! $we - $ws + 1;
  my $message     = SOUP::Message.new('GET', $u).ref;
  $message.request-headers.set-range($ws, $we);

  ($want-length, $ws, $we) = do if $we == -1 {
    $ws < 0 ?? (-$ws,               $full-length + $ws, $ws + $want-length - 1)
            !! ($full-length - $ws, $ws,                $full-length - 1);
  } else {
    ($we - $ws + 1, $ws, $we);
  }

  $s.queue-message($message, -> *@a { $l.quit });
  $l.run;

  is $message.status-code,          SOUP_STATUS_PARTIAL_CONTENT,              'Message status-code is SOUP_STATUS_PARTIAL_CONTENT';
  is $message.response-body.length, $want-length,                             'Message response body is the proper size';

  my $rh = $message.response-headers;
  my $gl = $rh.content-length;
  is $gl,                           $want-length,                             'Size of message response headers is correct';

  my ($gs, $ge, $gl2) = $rh.content-range;
  is $gs,                           $ws,                                      'Start value of message headers is correct';
  is $ge,                           $we,                                      'End value of message headers is correct';

  ok compare-carray($f.get-contents, $rh.data, $want-length, start1 => $ws),  'Data comparison is successful';\
  $message.unref;
  $message = SOUP::Message.new('GET', $u).ref;
}

sub test-context-http-ranged-requests {
  my $tf = 'random4k.bin';
  $tf = do {
    my $i = $tf.IO;
    unless $i.e {
      $i = $*CWD.add('t').add($tf);
      die 'Cannot find mapped file!' unless $i.e;
    }
    $i.absolute;
  }

  my ($loop, $file) = ( GLib::MainLoop.new, GLib::MappedFile.new($tf, False) );
  ok  $file,    'Mapped file exists and object created';
  nok $ERROR,   'No errors occurred during object creation';

  my ($length, $context) = ($file.length, create-context);
  ok  $context, 'Context object created';
  nok $ERROR,   'No errors occurred during object creation';
  my $port = $context.port;
  $context.host-path($tf, '/random4k.bin');

  my $session = SOUP::Session.new;
  my $uri     = "http://127.0.0.1:{ $port }/random4k.bin";
  diag $uri;
  request-range-and-compare($file, $session, $loop, $uri, .[0], .[1]) for (
    [0,             0          ],  # Corner cases: First byte
    [$length - 1,   $length - 1],  # Corner cases: Last byte
    [0,             499        ],  # Request first 500 bytes
    [500,           999        ],  # Request second 500 bytes
    [500,           $length - 1],  # Request everything but the first 500 bytes
    [$length - 500, $length - 1],  # Request the last 500 bytes
    [-500,          -1         ],  # Request the last 500 bytes by using negative requests
    [3072,          -1         ]   # Request the last 1k bytes by using negative requests
  );

  my $message = SOUP::Message.new('GET', $uri).ref;
  $message.request-headers.set-range($length, $length);
  $session.queue-message($message, -> *@a { $loop.quit });
  $loop.run;
  is $message.status-code, SOUP_STATUS_REQUESTED_RANGE_NOT_SATISFIABLE, 'Final message status indicated a non-satisfiable range';

  .unref for $message, $context, $loop, $file;
}

subtest 'HTTP Ranged Requests', { test-context-http-ranged-requests };
