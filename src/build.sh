gcc `pkg-config --cflags gupnp-av-1.0` `pkg-config --cflags gupnp-1.2` gupnp-helper.c `pkg-config --libs gupnp-av-1.0` `pkg-config gupnp-1.2` -fPIC -shared -o ../resources/lib/libgupnp-helper.so
