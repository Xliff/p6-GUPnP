use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Subs;

use GLib::GList;
use GLib::Value;

use GLib::Roles::ListData;
use GLib::Roles::Pointers;

unit package GUPnP::Raw::Definitions;

# Forced compilation counter;
constant forced = 1;

class GUPnPAcl                  is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPContext              is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPContextManager       is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPControlPoint         is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDevice               is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDeviceProxy          is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDeviceInfo           is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPResourceFactory      is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPRootDevice           is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPService              is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPServiceInfo          is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPServiceIntrospection is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPServiceProxy         is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPServiceProxyAction   is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPXMLDoc               is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPWhiteList            is repr<CPointer> is export does GLib::Roles::Pointers { }

class GUPnPCDSLastChangeEntry   is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDIDLLiteContainer    is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDIDLLiteContributor  is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDIDLLiteDescriptor   is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDIDLLiteItem         is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDIDLLiteObject       is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDIDLLiteResource     is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDIDLLiteWriter       is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPFeature              is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPFeatureListParser    is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPLastChangeParser     is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPMediaCollection      is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPProtocolInfo         is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPSearchCriteriaParser is repr<CPointer> is export does GLib::Roles::Pointers { }

class GUPnPDLNAInformation      is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDLNAProfile          is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDLNAProfileGuesser   is repr<CPointer> is export does GLib::Roles::Pointers { }
class GUPnPDLNARestriction      is repr<CPointer> is export does GLib::Roles::Pointers { }

constant gupnp        is export = 'gupnp-1.2',v0;
constant gupnp-av     is export = 'gupnp-av-1.0',v2;
constant gupnp-dlna   is export = 'gupnp-dlna-2.0',v3;

BEGIN {
  constant gupnp-helper is export = do {
    %?RESOURCES<lib/libgupnp-helper.so> ??
      %?RESOURCES<lib/libgupnp-helper.so>.absolute !!
      'lib/libgnup-helper.so';
  }
}
