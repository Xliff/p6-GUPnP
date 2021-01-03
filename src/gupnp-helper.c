#include <stdio.h>

#include "glib.h"
#include "glib-object.h"
#include "libgupnp/gupnp.h"

GType helper_gupnp_root_device_get_type () {
  gupnp_root_device_get_type();
}

GType helper_gupnp_device_proxy_get_type () {
  gupnp_device_proxy_get_type();
}

GType helper_gupnp_service_proxy_get_type () {
  gupnp_service_proxy_get_type();
}

GType helper_gupnp_device_info_get_type () {
  gupnp_device_proxy_get_type();
}

GType helper_gupnp_service_info_get_type () {
  gupnp_service_proxy_get_type();
}

GType helper_gupnp_context_get_type () {
  gupnp_context_get_type();
}

GType helper_gupnp_control_point_get_type () {
  gupnp_control_point_get_type();
}

GType helper_gupnp_context_manager_get_type () {
  gupnp_context_manager_get_type();
}

GType helper_resource_factory_get_type () {
  gupnp_resource_factory_get_type();
}

GType helper_service_introspection_get_type () {
  gupnp_service_introspection_get_type();
}

GType helper_xml_doc_get_type () {
  gupnp_xml_doc_get_type();
}
