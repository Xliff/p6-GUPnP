#!/usr/bin/env raku
use v6.c;

use NativeCall;
use NativeHelpers::Blob;

use GUPnP::Raw::Types;

use LibXML::Raw;
use GLib::Env;
use GUPnP::DidlLiteContributor;
use GUPnP::DidlLiteResource;
use GUPnP::DidlLiteItem;
use GUPnP::DidlLiteObject;
use GUPnP::DidlLiteWriter;
use GUPnP::ProtocolInfo;

sub get-item ($w, $id, $pid) {
  do given my $item = $w.add-item {
    (.id, .parent-id, .restricted) = ($id, $pid, False);
    .title = 'Try a little tenderness';
    .upnp-class = 'object.item.audioItem.musicTrack';
    given .add-artist {
      .name = 'Unknown';
      .unref;
    }
    given .add-resource {
      ( .protocol, .network, .mime-type ) = ('http-get', '*', 'audio/mpeg')
        given my $i = GUPnP::ProtocolInfo.new;
      .protocol-info = $i;
      $i.unref;
      ( .size, .uri ) = (3558000, 'http://168.192.1.1/audio197.mp3');
      .unref;
    }
    $_;
  }
}

my @current-fragments = «
  '<upnp:class>object.item.audioItem.musicTrack</upnp:class>'
  ''
  '<upnp:artist>Unknown</upnp:artist>'
  '<dc:title>Try a little tenderness</dc:title>'
»;

my @new-fragments = «
  '<upnp:class>object.item.audioItem.musicTrack</upnp:class><upnp:genre>Obscure</upnp:genre>'
  '<upnp:genre>Even more obscure</upnp:genre>'
  ''
  '<dc:title>Cthulhu fhtagn</dc:title>'
»;

sub debug-dump ($o) {
  my $n = $o.get-xml-node;
  my $d = CArray[Str].new; $d[0] = Str;
  say "Obj dump:\n{ $n.doc.DumpMemory($d, Pointer[int32]) // ''}";
  # xmlFree( pointer-to($d) );
}

sub MAIN {
  my $dataDir = 'data';
  $dataDir = 't'.IO.add($dataDir).absolute unless $dataDir.IO.d;
  die 'Cannot locate data/ directory!' unless $dataDir.IO.d;

  GLib::Env.setenv(GUPNP_AV_DATADIR => $dataDir.IO.absolute);

  my $writer = GUPnP::DidlLiteWriter.new;
  my $temp-o = $writer.&get-item(3, 2);
  my $object = $writer.&get-item(18, 13);
  debug-dump($object);
  my $r = $object.apply-fragments(@current-fragments, @new-fragments);
  debug-dump($object);
  if $r[0] != GUPNP_DIDL_LITE_FRAGMENT_RESULT_OK {
    say 'Applying fragments failed!';
  } else {
    my $value = $object.get-title;
    if $value ne 'Cthulhu fhtagn' {
      say "Incorrect title '{ $value }'. Should be 'Cthulhu fhtagn'!";
    } else {
      my $artists = $object.get-artists;
      if $artists {
        say 'Should be no artists!';
      } else {
        if $temp-o.get-title ne 'Try a little tenderness' {
          say "Incorrect title '{ $value }'. Should be 'Try a little tenderness'!";
        } else {
          $artists = $temp-o.get-artists;
          if $artists.not {
            say 'Should be one artist, there are none!';
          } else {
            if $artists.elems > 1 {
              say 'Shouold be one artist, but there are more!';
            } else {
              if (my $v = $artists.head.get-name) ne 'Unknown' {
                say "Artist is '{ $v }' but should be 'Unknown'";
              }
            }
          }
        }
      }
    }

    .unref for $object, $temp-o, $writer;
  }
}
