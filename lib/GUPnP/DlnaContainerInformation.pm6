use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::DlnaContainerInformation;

use GLib::Roles::Object;

our subset GUPnPDLNAContainerInformationAncestry is export of Mu
  where GUPnPDLNAContainerInformation | GObject;

class GUPNP::DlnaContainerInformation {
  also does GLib::Roles::Object;

  has GUPnPDLNAContainerInformation $!ci;

  submethod BUILD (:$information) {
    self.setGUPnPDLNAContainerInformation($information) if $information;
  }

  method setGUPnPDLNAContainerInformation (
    GUPnPDLNAContainerInformationAncestry $_
  ) {
    my $to-parent;

    $!ci = do {
      when GUPnPDLNAContainerInformation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDLNAContainerInformation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDLNAContainerInformation
    is also<GUPnPDLNAContainerInformation>
  { $!ci }

  method new (
    GUPnPDLNAContainerInformationAncestry $information,
                                          :$ref        = True
  ) {
    return Nil unless $information;

    my $o = self.bless( :$information );
    $o.ref if $ref;
    $o;
  }

  method get_mime
    is also<
      get-mime
      mime
    >
  {
    gupnp_dlna_container_information_get_mime($!ci);
  }

  method get_mpeg_version
    is also<
      get-mpeg-version
      mpeg_version
      mpeg-version
    >
  {
    gupnp_dlna_container_information_get_mpeg_version($!ci);
  }

  method get_packet_size
    is also<
      get-packet-size
      packet_size
      packet-size
    >
  {
    gupnp_dlna_container_information_get_packet_size($!ci);
  }

  method get_profile
    is also<
      get-profile
      profile
    >
  {
    gupnp_dlna_container_information_get_profile($!ci);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_dlna_container_information_get_type,
      $n,
      $t
    );
  }

  method get_variant
    is also<
      get-variant
      variant
    >
  {
    gupnp_dlna_container_information_get_variant($!ci);
  }

  method is_system_stream is also<is-system-stream> {
    so gupnp_dlna_container_information_is_system_stream($!ci);
  }

}
