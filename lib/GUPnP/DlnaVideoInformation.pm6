use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::DlnaVideoInformation;

use GLib::Roles::Object;

our subset GUPnPDLNAVideoInformationAncestry is export of Mu
  where GUPnPDLNAVideoInformation | GObject;

class GUPnP::DlnaVideoInformation {
  also does GLib::Roles::Object;

  has GUPnPDLNAVideoInformation $!vi;

  submethod BUILD (:$information) {
    self.setGUPnPDLNAVideoInformation($information) if $information;
  }

  method setGUPnPDLNAVideoInformation (GUPnPDLNAVideoInformationAncestry $_) {
    my $to-parent;

    $!vi = do {
      when GUPnPDLNAVideoInformation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDLNAVideoInformation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDLNAVideoInformation
    is also<GUPnPDLNAVideoInformation>
  { $!vi }

  method new (GUPnPDLNAVideoInformationAncestry $information, :$ref = True) {
    return Nil unless $information;

    my $o = self.bless( :$information );
    $o.ref if $ref;
    $o;
  }

  method get_bitrate is also<get-bitrate> {
    gupnp_dlna_video_information_get_bitrate($!vi);
  }

  method get_framerate is also<get-framerate> {
    gupnp_dlna_video_information_get_framerate($!vi);
  }

  method get_height is also<get-height> {
    gupnp_dlna_video_information_get_height($!vi);
  }

  method get_level is also<get-level> {
    gupnp_dlna_video_information_get_level($!vi);
  }

  method get_mime is also<get-mime> {
    gupnp_dlna_video_information_get_mime($!vi);
  }

  method get_mpeg_version is also<get-mpeg-version> {
    gupnp_dlna_video_information_get_mpeg_version($!vi);
  }

  method get_pixel_aspect_ratio is also<get-pixel-aspect-ratio> {
    gupnp_dlna_video_information_get_pixel_aspect_ratio($!vi);
  }

  method get_profile is also<get-profile> {
    gupnp_dlna_video_information_get_profile($!vi);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_dlna_video_information_get_type,
      $n,
      $t
    );
  }

  method get_width is also<get-width> {
    gupnp_dlna_video_information_get_width($!vi);
  }

  method is_interlaced is also<is-interlaced> {
    so gupnp_dlna_video_information_is_interlaced($!vi);
  }

  method is_system_stream is also<is-system-stream> {
    so gupnp_dlna_video_information_is_system_stream($!vi);
  }

}
