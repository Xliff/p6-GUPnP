use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use SOUP::Raw::Definitions;
use GUPnP::Raw::Definitions;

unit package GUPnP::Raw::DeviceInfo;

### /usr/include/gupnp-1.2/libgupnp/gupnp-device-info.h

sub gupnp_device_info_get_context (GUPnPDeviceInfo $info)
  returns GUPnPContext
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_description_value (
  GUPnPDeviceInfo $info,
  Str             $element
)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_device (GUPnPDeviceInfo $info, Str $type)
  returns GUPnPDeviceInfo
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_device_type (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_friendly_name (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_icon_url (
  GUPnPDeviceInfo $info,
  Str             $requested_mime_type,
  gint            $requested_depth,
  gint            $requested_width,
  gint            $requested_height,
  gboolean        $prefer_bigger,
  CArray[Str]     $mime_type,
  gint            $depth is rw,
  gint            $width is rw,
  gint            $height is rw
)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_location (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_manufacturer (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_manufacturer_url (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_model_description (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_model_name (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_model_number (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_model_url (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_presentation_url (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_resource_factory (GUPnPDeviceInfo $device_info)
  returns GUPnPResourceFactory
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_serial_number (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_service (GUPnPDeviceInfo $info, Str $type)
  returns GUPnPServiceInfo
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_udn (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_upc (GUPnPDeviceInfo $info)
  returns Str
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_get_url_base (GUPnPDeviceInfo $info)
  returns SoupURI
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_list_device_types (GUPnPDeviceInfo $info)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_list_devices (GUPnPDeviceInfo $info)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_list_dlna_capabilities (GUPnPDeviceInfo $info)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_list_dlna_device_class_identifier (GUPnPDeviceInfo $info)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_list_service_types (GUPnPDeviceInfo $info)
  returns GList
  is native(gupnp)
  is export
{ * }

sub gupnp_device_info_list_services (GUPnPDeviceInfo $info)
  returns GList
  is native(gupnp)
  is export
{ * }
