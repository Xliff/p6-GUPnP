use v6.c;

use NativeCall;

use GUPnP::Raw::Types;

role GUPnP::Roles::Signals::ContextManager {
  has %!signals-cm;

  # GUPnPContextManager, GUPnPContext, gpointer
  method connect-context (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-cm{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-context($obj, $signal,
        -> $, $c, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $c, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-cm{$signal}[0].tap(&handler) with &handler;
    %!signals-cm{$signal}[0];
  }

}

sub g-connect-context(
  Pointer $app,
  Str $name,
  &handler (GUPnPContextManager, GUPnPContext, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
