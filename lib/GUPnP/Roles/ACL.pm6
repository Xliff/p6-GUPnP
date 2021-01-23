use v6.c;

use Method::Also;

use NativeCall;

use GUPnP::Raw::Types;
use GUPnP::Raw::ACL;

role GUPnP::Roles::ACL {
  has GUPnPAcl $!acl;

  method roleInit-GUPnPAcl is also<roleInit_GUPnPAcl> {
    return if $!acl;

    my \i = findProperImplementor(self.^attributes);
    $!acl = cast( GUPnPAcl, i.get_value(self) );
  }

  method GUPnP::Raw::Definitions::GUPnPAcl
    is also<GUPnPAcl>
  { $!acl }

  method can_sync is also<gupnp-acl-can-sync> {
    so gupnp_acl_can_sync($!acl);
  }

  proto method is_allowed (|)
    is also<gupnp-acl-is-allowed>
  { * }

  multi method is_allowed (
    Str()          $path,
    Str()          $address,
    GUPnPDevice()  :$device  = GUPnPDevice,
    GUPnPService() :$service = GUPnPService,
    Str()          :$agent   = Str
  ) {
    samewith($device, $service, $path, $address, $agent);
  }
  multi method is_allowed (
    GUPnPDevice()  $device,
    GUPnPService() $service,
    Str()          $path,
    Str()          $address,
    Str()          $agent
  ) {
    so gupnp_acl_is_allowed($!acl, $device, $service, $path, $address, $agent);
  }

  proto method is_allowed_async (|)
      is also<gupnp-acl-is-allowed-async>
  { * }

  multi method is_allowed_async (
    Str()          $path,
    Str()          $address,
                   &callback,
    gpointer       $user_data    = gpointer,
    GUPnPDevice()  :$device      = GUPnPDevice,
    GUPnPService() :$service     = GUPnPService,
    Str()          :$agent       = Str,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      $device,
      $service,
      $path,
      $address,
      $agent,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method is_allowed_async (
    GUPnPDevice()  $device,
    GUPnPService() $service,
    Str()          $path,
    Str()          $address,
    Str()          $agent,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    gupnp_acl_is_allowed_async(
      $!acl,
      $device,
      $service,
      $path,
      $address,
      $agent,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method is_allowed_finish (
    GAsyncResult()          $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<is-allowed-finish>
  {
    clear_error;
    my $rv = so gupnp_acl_is_allowed_finish($!acl, $res, $error);
    set_error($error);
    $rv;
  }

  method acl_get_type is also<acl-get-type> {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &gupnp_acl_get_type, $n, $t );
  }

}

use GLib::Roles::Object;

our subset GUPnPACLAncestry is export of Mu
  where GUPnPAcl | GObject;

class GUPnP::ACL {
  also does GLib::Roles::Object;
  also does GUPnP::Roles::ACL;

  submethod BUILD (:$acl) {
    self.setGUPnPAcl($acl) if $acl;
  }

  method setGUPnPAcl (GUPnPACLAncestry $_) {
    my $to-parent;
    $!acl = do {
      when GUPnPAcl {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPAcl, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GUPnPACLAncestry $acl, :$ref = True) {
    return Nil unless $acl;

    my $o = self.bless( :$acl );
    $o.ref if $ref;
    $o;
  }

  method get_type (GUPnP::ACL:U: ) is also<get-type> {
    GUPnP::ACL.acl_get_type;
  }

}
