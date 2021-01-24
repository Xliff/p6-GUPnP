use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;
use GUPnP::Raw::Types;

use GLib::Roles::Signals::Generic;

role GUPnP::Roles::Signals::SearchCriteriaParser {
  also does GLib::Roles::Signals::Generic;

  has %!signals-p;

  # GUPnPSearchCriteriaParser, gchar, GUPnPSearchCriteriaOp, gchar, gpointer, gpointer --> gboolean
  method connect-expression (
    $obj,
    $signal = 'expression',
    &handler?
  ) {
    my $hid;
    %!signals-p{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-expression($obj, $signal,
        -> $, $s1, $scp, $s2, $p, $ud --> gboolean {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $s1, $scp, $s2, $p, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-p{$signal}[0].tap(&handler) with &handler;
    %!signals-p{$signal}[0];
  }

}

# GUPnPSearchCriteriaParser, gchar, GUPnPSearchCriteriaOp, gchar, gpointer, gpointer --> gboolean
sub g-connect-expression(
  Pointer $app,
  Str     $name,
          &handler (
            GUPnPSearchCriteriaParser,
            Str,
            GUPnPSearchCriteriaOp,
            Str,
            Pointer,
            Pointer
            --> gboolean
          ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
