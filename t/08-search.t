#!/usr/bin/env raku
use v6.c;

use Test;

use GUPnP::Raw::Types;
use GUPnP::SearchCriteriaParser;

my @searches = «
  'dc:title contains "foo"'
  "dc:title contains 'foo'"
  'upnp:class = "object.container.person.musicArtist"'
  'upnp:class = "object.container.person.musicArtist" and @refID exists false'
»;

my $p = GUPnP::SearchCriteriaParser.new;
for @searches {
  #ok  $p.parse-text($_), 'Parser operation returns true';
  $p.parse-text($_);
  nok $ERROR,            "Can parse expression '$_'";
}
