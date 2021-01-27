#!/usr/bin/env raku
use v6.c;

use GUPnP::Raw::Types;

use GUPnP::Feature;
use GUPnP::FeatureListParser;

my @names = <BOOKMARK EPG>;
my @versions = ^2;
my @ids = (
  |<bookmark1 bookmark2 bookmark3>,
  |<epg1 epg2>
);

# my $text = q:to/TEXT/;
#   <?xml version="1.0" encoding="UTF-8"?>
#   <Features xmlns="urn:schemas-upnp-org:av:avs" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:schemas-upnp-org:av:avs http://www.upnp.org/schemas/av/avs-v1-20060531.xsd">
#         <Feature name="BOOKMARK" version="1">
#               <objectIDs>bookmark1</objectIDs>
#               <objectIDs>bookmark2,bookmark3</objectIDs>
#         </Feature>
#         <Feature name="EPG" version="2">
#               <objectIDs>epg1,epg2</objectIDs>
#         </Feature>
#   </Features>
#   TEXT

my $text =
  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" ~
  "<Features " ~
          "xmlns=\"urn:schemas-upnp-org:av:avs\" " ~
          "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" " ~
          "xsi:schemaLocation=\"" ~
          "urn:schemas-upnp-org:av:avs " ~
          "http://www.upnp.org/schemas/av/avs-v1-20060531.xsd\">" ~
          "<Feature name=\"BOOKMARK\" version=\"1\">" ~
                  "<objectIDs>bookmark1</objectIDs>" ~
                  "<objectIDs>bookmark2,bookmark3</objectIDs>" ~
          "</Feature>" ~
          "<Feature name=\"EPG\" version=\"2\">" ~
                  "<objectIDs>epg1,epg2</objectIDs>" ~
          "</Feature>" ~
  "</Features>";

sub check-feature ($f) {
  state $index = 0;

  return False if @names[$index]    ne $f.name;
  return False if @versions[$index] ne $f.version;
  return False if @ids[$index++]    ne $f.object-ids;
  True;
}

sub MAIN {
  my $parser   = GUPnP::FeatureListParser.new;
  my $features = $parser.parse-text($text);
  unless $features {
    die "Parse error: { $ERROR ?? $ERROR.message !! 'UNKNOWN' }";
  }

  check-feature($_) for $features[];
  $parser.unref;
}
