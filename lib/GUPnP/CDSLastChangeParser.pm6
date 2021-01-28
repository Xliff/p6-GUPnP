use v6.c;

use NativeCall;
use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::CDSLastChangeParser;

use GLib::GList;
use GLib::Value;

use GLib::Roles::Object;

class GUPnP::LastChangeEntry { ... }

our subset GUPnPCDSLastChangeParserAncestry is export of Mu
  where GUPnPCDSLastChangeParser | GObject;

class GUPnP::CDSLastChangeParser {
  also does GLib::Roles::Object;

  has GUPnPCDSLastChangeParser $!lcp;

  submethod BUILD (:$parser) {
    self.setGUPnPCDSLastChangeParser($parser) if $parser;
  }

  method setGUPnPCDSLastChangeParser (GUPnPCDSLastChangeParserAncestry $_) {
    my $to-parent;

    $!lcp = do {
      when GUPnPCDSLastChangeParser {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPCDSLastChangeParser, $_);
      }
    }
    self.setGUPnPDIDLLiteObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPCDSLastChangeParser
    is also<GUPnPCDSLastChangeParser>
  { $!lcp }

  multi method new (GUPnPCDSLastChangeParserAncestry $parser, :$ref = True) {
    return Nil unless $parser;

    my $o = self.bless( :$parser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $parser = gupnp_cds_last_change_parser_new();

    $parser ?? self.bless( :$parser ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_cds_last_change_parser_get_type,
      $n,
      $t
    );
  }

  method parse (
    Str                     $last_change,
    CArray[Pointer[GError]] $error       = gerror,
                            :$glist      = False,
                            :$raw        = False
  ) {
    clear_error;
    my $pl = gupnp_cds_last_change_parser_parse($!lcp, $last_change, $error);
    set_error($error);

    returnGList(
      $pl,
      $glist,
      $raw,
      GUPnPCDSLastChangeEntry,
      GUPnP::CDSLastChangeEntry
     )
  }

}

our subset GUPnPCDSLastChangeEntryAncestry is export of Mu
  where GUPnPCDSLastChangeEntry | GObject;

class GUPnP::LastChangeEntry {
  has GUPnPCDSLastChangeEntry $!lce;

  submethod BUILD (:$entry) {
    self.setGUPnPCDSLastChangeEntry($entry) if $entry;
  }

  method setGUPnPCDSLastChangeEntry (GUPnPCDSLastChangeEntryAncestry $_) {
    my $to-parent;

    $!lce = do {
      when GUPnPCDSLastChangeEntry {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPCDSLastChangeEntry, $_);
      }
    }
    self.setGUPnPDIDLLiteObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPCDSLastChangeEntry
    is also<GUPnPCDSLastChangeEntry>
  { $!lce }

  method new (GUPnPCDSLastChangeEntryAncestry $entry, :$ref = True) {
    return Nil unless $entry;

    my $o = self.bless( :$entry );
    $o.ref if $ref;
    $o;
  }

  method get_class
    is also<
      get-class
      class
    >
  {
    gupnp_cds_last_change_entry_get_class($!lce);
  }

  method get_event
    is also<
      get-event
      event
    >
  {
    GUPnPCDSLastChangeEventEnum(
      gupnp_cds_last_change_entry_get_event($!lce)
    );
  }

  method get_object_id
    is also<
      get-object-id
      object_id
      object-id
    >
  {
    gupnp_cds_last_change_entry_get_object_id($!lce);
  }

  method get_parent_id
    is also<
      get-parent-id
      parent_id
      parent-id
    >

  {
    gupnp_cds_last_change_entry_get_parent_id($!lce);
  }

  method get_update_id
    is also<
      get-update-id
      update_id
      update-id
    >
  {
    gupnp_cds_last_change_entry_get_update_id($!lce);
  }

  method is_subtree_update is also<is-subtree-update> {
    so gupnp_cds_last_change_entry_is_subtree_update($!lce);
  }

  method ref {
    gupnp_cds_last_change_entry_ref($!lce);
    self;
  }

  method unref {
    gupnp_cds_last_change_entry_unref($!lce);
  }
}
