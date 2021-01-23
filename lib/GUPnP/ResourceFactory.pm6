use v6.c;

use Method::Also;

use GUPnP::Raw::Types;
use GUPnP::Raw::ResourceFactory;

use GLib::Roles::Object;

our subset GUPnPResourceFactoryAncestry is export of Mu
  where GUPnPResourceFactory | GObject;

class GUPnP::ResourceFactory {
  also does GLib::Roles::Object;

  has GUPnPResourceFactory $!rf;

  submethod BUILD (:$factory) {
    self.setGUPnPResourceFactory($factory) if $factory;
  }

  method setGUPnPResourceFactory (GUPnPResourceFactoryAncestry $_) {
    my $to-parent;

    $!rf = do {
      when GUPnPResourceFactory {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUPnPResourceFactory, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GUPnP::Raw::Definitions::GUPnPResourceFactory
      is also<GUPnPResourceFactory>
  { $!rf }

  proto method new (|)

  { * }

  multi method new (GUPnPResourceFactoryAncestry $factory, :$ref = True) {
    return Nil unless $factory;

    my $o = self.bless( :$factory );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $factory = gupnp_resource_factory_new();

    $factory ?? self.bless( :$factory ) !! Nil;
  }

  method get_default is also<get-default> {
    my $factory = gupnp_resource_factory_get_default();

    $factory ?? self.bless( :$factory ) !! Nil;
  }


  method register_resource_proxy_type (Str() $upnp_type, Int() $type)
    is also<register-resource-proxy-type>
  {
    my GType $t = $type;

    gupnp_resource_factory_register_resource_proxy_type(
      $!rf,
      $upnp_type,
      $t
    );
  }

  method register_resource_type (Str() $upnp_type, Int() $type)
    is also<register-resource-type>
  {
    my GType $t = $type;

    gupnp_resource_factory_register_resource_type($!rf, $upnp_type, $t);
  }

  method unregister_resource_proxy_type (Str() $upnp_type)
    is also<unregister-resource-proxy-type>
  {
    so gupnp_resource_factory_unregister_resource_proxy_type($!rf, $upnp_type);
  }

  method unregister_resource_type (Str() $upnp_type) 
    is also<unregister-resource-type>
  {
    so gupnp_resource_factory_unregister_resource_type($!rf, $upnp_type);
  }

}
