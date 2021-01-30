use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::DlnaImageInformation;

use GLib::Roles::Object;

our subset GUPnPDLNAImageInformationAncestry is export of Mu
  where GUPnPDLNAImageInformation | GObject;

class GUPnP::DlnaImageInformation {
  also does GLib::Roles::Object;

  has GUPnPDLNAImageInformation $!ii;

  submethod BUILD (:$information) {
    self.setGUPnPDLNAImageInformation($information) if $information;
  }

  method setGUPnPDLNAImageInformation (GUPnPDLNAImageInformationAncestry $_) {
    my $to-parent;

    $!ii = do {
      when GUPnPDLNAImageInformation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPDLNAImageInformation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPDLNAImageInformation
    is also<GUPnPDLNAImageInformation>
  { $!ii }

  method new (GUPnPDLNAImageInformationAncestry $information, :$ref = True) {
    return Nil unless $information;

    my $o = self.bless( :$information );
    $o.ref if $ref;
    $o;
  }

  method get_depth
    is also<
      get-depth
      depth
    >
  {
    gupnp_dlna_image_information_get_depth($!ii);
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    gupnp_dlna_image_information_get_height($!ii);
  }

  method get_mime
    is also<
      get-mime
      mime
    >
  {
    gupnp_dlna_image_information_get_mime($!ii);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gupnp_dlna_image_information_get_type,
      $n,
      $t
    );
  }

  method get_width
    is also<
      get-width
      width
    >
  {
    gupnp_dlna_image_information_get_width($!ii);
  }

}
