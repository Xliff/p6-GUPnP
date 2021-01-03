use v6.c;

use GUPnP::Raw::Types;
use GUPnP::Raw::ACL;

role GUPnP::Roles::ACL {
  has GUPnPAcl $!acl;

  method roleInit-GUPnPAcl {
    return if $!acl;

    my \i = findProperImplementor(self.^attributes);
    $!acl = cast( GUPnPAcl, i.get_value(self) );
  }

  method GUPnP::Raw::Definitions::GUPnPAcl
  { $!acl }

  method gupnp_acl_can_sync {
    so gupnp_acl_can_sync($!acl);
  }

  method gupnp_acl_is_allowed (
    Str()         $path,
    Str()         $address,
    GUPnPDevice() :$device  = GUPnPDevice,
    GUPnPService  :$service = GUPnPService,
    Str()         :$agent   = Str
  ) {
    samewith($device, $service, $path, $address, $agent);
  }
  method gupnp_acl_is_allowed (
    GUPnPDevice() $device,
    GUPnPService  $service,
    Str()         $path,
    Str()         $address,
    Str()         $agent
  ) {
    so gupnp_acl_is_allowed($!acl, $device, $service, $path, $address, $agent);
  }

  proto method gupnp_acl_is_allowed_async (|)
  { * }

  method gupnp_acl_is_allowed_async (
    Str()          $path,
    Str()          $address,
                   &callback,
    gpointer       $user_data    = gpointer
    GUPnPDevice()  :$device      = GUPnPDevice,
    GUPnPService   :$service     = GUPnPService,
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
  method gupnp_acl_is_allowed_async (
    GUPnPDevice()  $device,
    GUPnPService   $service,
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

  method gupnp_acl_is_allowed_finish (
    GAsyncResult()         $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so gupnp_acl_is_allowed_finish($!acl, $res, $error);
    set_error($error);
    $rv;
  }

  method acl_get_type {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &gnupnp_acl_get_type, $n, $t );
  }

}

our subset GUPnPAclAncestry is export of Mu
  where GUPnPACLAncestry | GObject;

class GUPnP::ACL {
  also does GLib::Roles::Object;
  also does GUPnP::Roles::ACL;

  submethod BUILD (:$acl) {
    self.setGUPnPAcl($acl) if $acl;
  }

  method setGUPnPAcl (GUPnPAclAncestry $_) {
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

  multi method new (GUPnPAclAncestry $acl, :$ref = True) {
    return Nil unless $acl;

    my $o = self.bless( :$acl );
    $o.ref if $ref;
    $o;
  }

  method get_type (GUPnP::ACL:U: ) {
    GUPnP::ACL.acl_get_type;
  }

}
