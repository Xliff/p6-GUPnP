use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::DlnaProfile;

use GLib::GList;

use GLib::Roles::Object;

our subset GUPnPDLNAProfileAncestry is export of Mu
  where GUPnPDLNAProfile | GObject;

class GUPnP::DlnaProfile {
  also does GLib::Roles::Object;

  has GUPnPDLNAProfile $!p;

  submethod BUILD (:$profile) {
    self.setGUPnPDLNAProfile($profile) if $profile;
  }

  method setGUPnPDLNAProfile (GUPnPDLNAProfileAncestry $_) {
    my $to-parent;

    $!p = do {
      when GUPnPDLNAProfile {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDLNAProfile, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDLNAProfile
    is also<GUPnPDLNAProfile>
  { $!p }

  method new (GUPnPDLNAProfileAncestry $profile, :$ref = True) {
    return Nil unless $profile;

    my $o = self.bless( :$profile );
    $o.ref if $ref;
    $o;
  }

  method get_audio_restrictions (:$glist = False, :$raw = False)
    is also<get-audio-restrictions>
  {
    returnGList(
      gupnp_dlna_profile_get_audio_restrictions($!p),
      $glist,
      $raw,
      GUPnPDLNARestriction
    );
  }

  method get_container_restrictions (:$glist = False, :$raw = False)
    is also<get-container-restrictions>
  {
    returnGList(
      gupnp_dlna_profile_get_container_restrictions($!p),
      $glist,
      $raw,
      GUPnPDLNARestriction
    );
  }

  method get_extended is also<get-extended> {
    so gupnp_dlna_profile_get_extended($!p);
  }

  method get_image_restrictions (:$glist = False, :$raw = False)
    is also<get-image-restrictions>
  {
    returnGList(
      gupnp_dlna_profile_get_image_restrictions($!p),
      $glist,
      $raw,
      GUPnPDLNARestriction
    );
  }

  method get_mime is also<get-mime> {
    gupnp_dlna_profile_get_mime($!p);
  }

  method get_name is also<get-name> {
    gupnp_dlna_profile_get_name($!p);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_dlna_profile_get_type,
      $n,
      $t
    );
  }

  method get_video_restrictions (:$glist = False, :$raw = False)
    is also<get-video-restrictions>
  {
    returnGList(
      gupnp_dlna_profile_get_video_restrictions($!p),
      $glist,
      $raw,
      GUPnPDLNARestriction
    );
  }

}
