use v6.c;

use NativeCall;

use GUPnP::Raw::Types;

role GUPnP::Roles::Signals::ServiceProxy {
  has %!signals-sp;

  # GUPnPServiceProxy, gpointer, gpointer
  method connect-subscription-lost (
    $obj,
    $signal = 'subscription-lost',
    &handler?
  ) {
    my $hid;
    %!signals-sp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-subscription-lost($obj, $signal,
        -> $, $g, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-sp{$signal}[0].tap(&handler) with &handler;
    %!signals-sp{$signal}[0];
  }

}

# GUPnPServiceProxy, gpointer, gpointer
sub g-connect-subscription-lost(
  Pointer $app,
  Str     $name,
          &handler (Pointer, gpointer, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
