use v6.c;

use Method::Also;
use NativeCall;

use GUPnP::Raw::Types;
use GUPnP::Raw::DlnaProfileGuesser;

use GLib::GList;

use GLib::Roles::Object;

our subset GUPnPDLNAProfileGuesserAncestry is export of Mu
  where GUPnPDLNAProfileGuesser | GObject;

class GUPnP::DlnaProfileGuesser {
  also does GLib::Roles::Object;

  has GUPnPDLNAProfileGuesser $!pg;

  submethod BUILD (:$guesser) {
    self.setGUPnPDLNAProfileGuesser($guesser) if $guesser;
  }

  method setGUPnPDLNAProfileGuesser (GUPnPDLNAProfileGuesserAncestry $_) {
    my $to-parent;

    $!pg = do {
      when GUPnPDLNAProfileGuesser {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDLNAProfileGuesser, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDLNAProfileGuesser
    is also<GUPnPDLNAProfileGuesser>
  { $!pg }

  multi method new (GUPnPDLNAProfileGuesserAncestry $guesser, :$ref = True) {
    return Nil unless $guesser;

    my $o = self.bless( :$guesser );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $relaxed_mode, Int() $extended_mode) {
    my gboolean ($r, $e) = ($relaxed_mode, $extended_mode).map( *.so.Int );
    my $guesser          = gupnp_dlna_profile_guesser_new($r, $e);

    $guesser ?? self.bless( :$guesser ) !! Nil;
  }

  method cleanup (GUPnP::DlnaProfileGuesser:U: ) {
    gupnp_dlna_profile_guesser_cleanup();
  }

  method get_extended_mode is also<get-extended-mode> {
    so gupnp_dlna_profile_guesser_get_extended_mode($!pg);
  }

  method get_profile (Str() $name, :$raw = False) is also<get-profile> {
    my $p = gupnp_dlna_profile_guesser_get_profile($!pg, $name);

    # Transfer none
    $p ??
      ( $raw ?? $p !! GUPnP::DlnaProfile.new($p) )
      !!
      Nil;
  }

  method get_relaxed_mode is also<get-relaxed-mode> {
    so gupnp_dlna_profile_guesser_get_relaxed_mode($!pg);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_dlna_profile_guesser_get_type,
      $n,
      $t
    );
  }

  method guess_profile_async (
    Str()                   $uri,
    Int()                   $timeout_in_ms,
    CArray[Pointer[GError]] $error          = gerror
  )
    is also<guess-profile-async>
  {
    clear_error;
    my $rv = so gupnp_dlna_profile_guesser_guess_profile_async(
      $!pg,
      $uri,
      $timeout_in_ms,
      $error
    );
    set_error($error);
    $rv;
  }

  method guess_profile_from_info (GUPnPDLNAInformation() $info, :$raw = False)
    is also<guess-profile-from-info>
  {
    my $p = gupnp_dlna_profile_guesser_guess_profile_from_info($!pg, $info);

    # Transfer none
    $p ??
      ( $raw ?? $p !! GUPnP::DlnaProfile.new($p) )
      !!
      Nil;
  }

  proto method guess_profile_sync (|)
    is also<guess-profile-sync>
  { * }

  multi method guess_profile_sync (
    Str()                        $uri,
    Int()                        $timeout_in_ms,
    CArray[Pointer[GError]]      $error          = gerror,
                                 :$raw           = False
  ) {
    my $info = CArray[GUPnPDLNAInformation]
  }
  multi method guess_profile_sync (
    Str()                        $uri,
    Int()                        $timeout_in_ms,
    CArray[GUPnPDLNAInformation] $dlna_info,
    CArray[Pointer[GError]]      $error          = gerror,
                                 :$raw           = False
  )

  {
    my guint $t = $timeout_in_ms;
    my       $p = gupnp_dlna_profile_guesser_guess_profile_sync(
      $!pg,
      $uri,
      $timeout_in_ms,
      $dlna_info,
      $error
    );

    # Transfer none
    $p ??
      ( $raw ?? $p !! GUPnP::DlnaProfile.new($p) )
      !!
      Nil;
  }

  method list_profiles (:$glist = False, :$raw = False)
    is also<list-profiles>
  {
    returnGList(
      gupnp_dlna_profile_guesser_list_profiles($!pg),
      $glist,
      $raw,
      GUPnPDLNAProfile,
      GUPnP::DlnaProfile
    );
  }

}
