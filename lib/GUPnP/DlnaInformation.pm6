use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;
use GUPnP::Raw::DlnaInformation;

use GUPnP::DlnaAudioInformation;
use GUPnP::DlnaContainerInformation;
use GUPnP::DlnaImageInformation;
use GUPnP::DlnaVideoInformation;

use GLib::Roles::Object;

our subset GUPnPDLNAInformationAncestry is export of Mu
  where GUPnPDLNAInformation | GObject;

class GUPnP::DlnaInformation {
  also does GLib::Roles::Object;

  has GUPnPDLNAInformation $!di;

  submethod BUILD (:$information) {
    self.setGUPnPDlnaInformation($information) if $information;
  }

  method setGUPnPDlnaInformation (GUPnPDLNAInformationAncestry $_) {
    my $to-parent;

    $!di = do {
      when GUPnPDLNAInformation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDLNAInformation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDLNAInformation
    is also<GUPnPDLNAInformation>
  { $!di }

  multi method new (
    GUPnPDLNAInformationAncestry $information,
                                    :$ref      = True
  ) {
    return Nil unless $information;

    my $o = self.bless( :$information );
    $o.ref if $ref;
    $o;
  }

  # Type: GUPnPDLNAAudioInformation
  method audio-information (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GUPnP::DlnaAudioInformation.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('audio-information', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          GUPnPDLNAAudioInformation,
          GUPnP::DlnaAudioInformation
        );
      },
      STORE => -> $,  $val is copy {
        warn 'audio-information does not allow writing'
      }
    );
  }

  # Type: GUPnPDLNAContainerInformation
  method container-information (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GUPnP::DlnaContainerInformation.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('container-information', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          GUPnPDLNAContainerInformation,
          GUPnP::DlnaContainerInformation
        );
      },
      STORE => -> $,  $val is copy {
        warn 'container-information does not allow writing'
      }
    );
  }

  # Type: GUPnPDLNAImageInformation
  method image-information (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GUPnP::DlnaImageInformation.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('image-information', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          GUPnPDLNAImageInformation,
          GUPnP::DlnaImageInfomation
        );
      },
      STORE => -> $,  $val is copy {
        warn 'image-information does not allow writing'
      }
    );
  }

  # Type: gchar
  method uri is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('uri', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'uri is a construct-only attribute'
      }
    );
  }

  # Type: GUPnPDLNAVideoInformation
  method video-information (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GUPnP::DlnaVideoInformation.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('video-information', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          GUPnPDLNAVideoInformation,
          GUPnP::DlnaVideoInformation
        );
      },
      STORE => -> $,  $val is copy {
        warn 'video-information does not allow writing'
      }
    );
  }

  method get_audio_information is also<get-audio-information> {
    gupnp_dlna_information_get_audio_information($!di);
  }

  method get_container_information is also<get-container-information> {
    gupnp_dlna_information_get_container_information($!di);
  }

  method get_image_information is also<get-image-information> {
    gupnp_dlna_information_get_image_information($!di);
  }

  method get_profile_name
    is also<
      get-profile-name
      profile_name
      profile-name
    >
  {
    gupnp_dlna_information_get_profile_name($!di);
  }

  method get_uri is also<get-uri> {
    gupnp_dlna_information_get_uri($!di);
  }

  method get_video_information is also<get-video-information> {
    gupnp_dlna_information_get_video_information($!di);
  }

}
