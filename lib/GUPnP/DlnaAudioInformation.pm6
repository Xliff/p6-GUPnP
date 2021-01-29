use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::DlnaAudioInformation;

use GLib::Roles::Object;

our subset GUPnPDLNAAudioInformationAncestry is export of Mu
  where GUPnPDLNAAudioInformation | GObject;

class GUPnP::DlnaAudioInformation {
  also does GLib::Roles::Object;

  has GUPnPDLNAAudioInformation $!ai;

  submethod BUILD (:$information) {
    self.setGUPnPDLNAAudioInformation($information) if $information;
  }

  method setGUPnPDLNAAudioInformation (GUPnPDLNAAudioInformationAncestry $_) {
    my $to-parent;

    $!ai = do {
      when GUPnPDLNAAudioInformation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDLNAAudioInformation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDLNAAudioInformation
    is also<GUPnPDLNAAudioInformation>
  { $!ai }

  method new (GUPnPDLNAAudioInformationAncestry $information, :$ref = True) {
    return Nil unless $information;

    my $o = self.bless( :$information );
    $o.ref if $ref;
    $o;
  }

  method get_bitrate is also<get-bitrate> {
    gupnp_dlna_audio_information_get_bitrate($!ai);
  }

  method get_channels is also<get-channels> {
    gupnp_dlna_audio_information_get_channels($!ai);
  }

  method get_depth is also<get-depth> {
    gupnp_dlna_audio_information_get_depth($!ai);
  }

  method get_layer is also<get-layer> {
    gupnp_dlna_audio_information_get_layer($!ai);
  }

  method get_level is also<get-level> {
    gupnp_dlna_audio_information_get_level($!ai);
  }

  method get_mime is also<get-mime> {
    gupnp_dlna_audio_information_get_mime($!ai);
  }

  method get_mpeg_audio_version is also<get-mpeg-audio-version> {
    gupnp_dlna_audio_information_get_mpeg_audio_version($!ai);
  }

  method get_mpeg_version is also<get-mpeg-version> {
    gupnp_dlna_audio_information_get_mpeg_version($!ai);
  }

  method get_profile is also<get-profile> {
    gupnp_dlna_audio_information_get_profile($!ai);
  }

  method get_rate is also<get-rate> {
    gupnp_dlna_audio_information_get_rate($!ai);
  }

  method get_stream_format is also<get-stream-format> {
    gupnp_dlna_audio_information_get_stream_format($!ai);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_dlna_audio_information_get_type,
      $n,
      $t
    );
  }

  method get_wma_version is also<get-wma-version> {
    gupnp_dlna_audio_information_get_wma_version($!ai);
  }

}
