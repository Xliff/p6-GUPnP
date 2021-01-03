gcc `pkg-config --cflags gupnp-1.2` gupnp-helper.c `pkg-config --libs gupnp-1.2` -fPIC -shared -o ../resources/lib/libgupnp-helper.so
