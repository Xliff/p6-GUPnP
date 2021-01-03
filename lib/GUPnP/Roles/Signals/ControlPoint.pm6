use v6.c;

use NativeCall;

use GUPnP::Raw::Types;

role GUPnP::Roles::Signals::ControlPoint {
  has %!signals-cp;

  # GUPnPControlPoint, GUPnPServiceProxy, gpointer
  method connect-device-proxy (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-cp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-device-proxy($obj, $signal,
        -> $, $d, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $d, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-cp{$signal}[0].tap(&handler) with &handler;
    %!signals-cp{$signal}[0];
  }

  # GUPnPControlPoint, GUPnPServiceProxy, gpointer
  method connect-service-proxy-unavailable (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-cp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-service-proxy($obj, $signal,
        -> $, $s, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $s, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-cp{$signal}[0].tap(&handler) with &handler;
    %!signals-cp{$signal}[0];
  }

}


# GUPnPControlPoint, GUPnPDeviceProxy, gpointer
sub g-connect-service-proxy(
  Pointer $app,
  Str     $name,
          &handler (GUPnPControlPoint, GUPnPDeviceProxy, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GUPnPControlPoint, GUPnPServiceProxy, gpointer
sub g-connect-service-proxy(
  Pointer $app,
  Str     $name,
          &handler (GUPnPControlPoint, GUPnPServiceProxy, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
