use v6.c;

unit package GUPnP::Raw::Exports;

our @gupnp-exports is export;

BEGIN {
  @gupnp-exports = <
    GUPnP::Raw::Definitions
  >;
}
