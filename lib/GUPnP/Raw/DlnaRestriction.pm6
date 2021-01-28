use v6.c;

use MONKEY-TYPING;

use NativeCall;
use Method::Also;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::Restriction;

# BOXED
augment class GUPnPDLNARestriction {

  method copy {
    gupnp_dlna_restriction_copy(self);
  }

  method free {
    gupnp_dlna_restriction_free(self);
  }

  # May need a role for proper handling. GHashTable is not yet reliable.
  method get_entries (:$raw = False) is also<get-entries> {
    my $e = gupnp_dlna_restriction_get_entries(self);

    # Transfer none = :ref
    $e ??
      ( $raw ?? $e !! GLib::HashTable.new($e) )
      !!
      Nil
  }

  method get_mime is also<get-mime> {
    gupnp_dlna_restriction_get_mime(self);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_dlna_restriction_get_type,
      $n,
      $t
    );
  }

  method is_empty is also<is-empty> {
    so gupnp_dlna_restriction_is_empty(self);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gupnp_dlna_restriction_to_string(self);
  }

}

### /usr/include/gupnp-dlna-2.0/libgupnp-dlna/gupnp-dlna-restriction.h

sub gupnp_dlna_restriction_copy (GUPnPDLNARestriction $restriction)
  returns GUPnPDLNARestriction
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_restriction_free (GUPnPDLNARestriction $restriction)
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_restriction_get_entries (GUPnPDLNARestriction $restriction)
  returns GHashTable
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_restriction_get_mime (GUPnPDLNARestriction $restriction)
  returns Str
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_restriction_get_type ()
  returns GType
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_restriction_is_empty (GUPnPDLNARestriction $restriction)
  returns uint32
  is native(gupnp-dlna)
  is export
{ * }

sub gupnp_dlna_restriction_to_string (GUPnPDLNARestriction $restriction)
  returns Str
  is native(gupnp-dlna)
  is export
{ * }
