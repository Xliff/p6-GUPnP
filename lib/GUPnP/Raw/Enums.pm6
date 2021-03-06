use v6.c;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;

unit package GUPnP::Raw::Enums;

# CORE

our enum GUPnPControlErrorEnum is export (
  GUPNP_CONTROL_ERROR_INVALID_ACTION => 401,
  GUPNP_CONTROL_ERROR_INVALID_ARGS   => 402,
  GUPNP_CONTROL_ERROR_OUT_OF_SYNC    => 403,
  GUPNP_CONTROL_ERROR_ACTION_FAILED  => 501,
);

constant GUPnPEventingError is export := guint32;
our enum GUPnPEventingErrorEnum is export <
  GUPNP_EVENTING_ERROR_SUBSCRIPTION_FAILED
  GUPNP_EVENTING_ERROR_SUBSCRIPTION_LOST
  GUPNP_EVENTING_ERROR_NOTIFY_FAILED
>;

constant GUPnPRootdeviceError is export := guint32;
our enum GUPnPRootdeviceErrorEnum is export <
  GUPNP_ROOT_DEVICE_ERROR_NO_CONTEXT
  GUPNP_ROOT_DEVICE_ERROR_NO_DESCRIPTION_PATH
  GUPNP_ROOT_DEVICE_ERROR_NO_DESCRIPTION_FOLDER
  GUPNP_ROOT_DEVICE_ERROR_NO_NETWORK
  GUPNP_ROOT_DEVICE_ERROR_FAIL
>;

constant GUPnPServerError is export := guint32;
our enum GUPnPServerErrorEnum is export <
  GUPNP_SERVER_ERROR_INTERNAL_SERVER_ERROR
  GUPNP_SERVER_ERROR_NOT_FOUND
  GUPNP_SERVER_ERROR_NOT_IMPLEMENTED
  GUPNP_SERVER_ERROR_INVALID_RESPONSE
  GUPNP_SERVER_ERROR_INVALID_URL
  GUPNP_SERVER_ERROR_OTHER
>;

constant GUPnPServiceActionArgDirection is export := guint32;
our enum GUPnPServiceActionArgDirectionEnum is export <
  GUPNP_SERVICE_ACTION_ARG_DIRECTION_IN
  GUPNP_SERVICE_ACTION_ARG_DIRECTION_OUT
>;

constant GUPnPXMLError is export := guint32;
our enum GUPnPXMLErrorEnum is export <
  GUPNP_XML_ERROR_PARSE
  GUPNP_XML_ERROR_NO_NODE
  GUPNP_XML_ERROR_EMPTY_NODE
  GUPNP_XML_ERROR_INVALID_ATTRIBUTE
  GUPNP_XML_ERROR_OTHER
>;

# AV

constant GUPnPCDSLastChangeEvent is export := guint32;
our enum GUPnPCDSLastChangeEventEnum is export <
  GUPNP_CDS_LAST_CHANGE_EVENT_INVALID
  GUPNP_CDS_LAST_CHANGE_EVENT_OBJECT_ADDED
  GUPNP_CDS_LAST_CHANGE_EVENT_OBJECT_REMOVED
  GUPNP_CDS_LAST_CHANGE_EVENT_OBJECT_MODIFIED
  GUPNP_CDS_LAST_CHANGE_EVENT_ST_DONE
>;

constant GUPnPDIDLLiteFragmentResult is export := guint32;
our enum GUPnPDIDLLiteFragmentResultEnum is export <
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_OK
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_CURRENT_BAD_XML
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_NEW_BAD_XML
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_CURRENT_INVALID
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_NEW_INVALID
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_REQUIRED_TAG
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_READONLY_TAG
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_MISMATCH
  GUPNP_DIDL_LITE_FRAGMENT_RESULT_UNKNOWN_ERROR
>;

constant GUPnPDLNAConversion is export := guint32;
our enum GUPnPDLNAConversionEnum is export (
  GUPNP_DLNA_CONVERSION_NONE       => 0,
  GUPNP_DLNA_CONVERSION_TRANSCODED => 1,
);

constant GUPnPDLNAFlags is export := guint32;
our enum GUPnPDLNAFlagsEnum is export (
  GUPNP_DLNA_FLAGS_NONE                      =>         0,
  GUPNP_DLNA_FLAGS_SENDER_PACED              => (1 +< 31),
  GUPNP_DLNA_FLAGS_TIME_BASED_SEEK           => (1 +< 30),
  GUPNP_DLNA_FLAGS_BYTE_BASED_SEEK           => (1 +< 29),
  GUPNP_DLNA_FLAGS_PLAY_CONTAINER            => (1 +< 28),
  GUPNP_DLNA_FLAGS_S0_INCREASE               => (1 +< 27),
  GUPNP_DLNA_FLAGS_SN_INCREASE               => (1 +< 26),
  GUPNP_DLNA_FLAGS_RTSP_PAUSE                => (1 +< 25),
  GUPNP_DLNA_FLAGS_STREAMING_TRANSFER_MODE   => (1 +< 24),
  GUPNP_DLNA_FLAGS_INTERACTIVE_TRANSFER_MODE => (1 +< 23),
  GUPNP_DLNA_FLAGS_BACKGROUND_TRANSFER_MODE  => (1 +< 22),
  GUPNP_DLNA_FLAGS_CONNECTION_STALL          => (1 +< 21),
  GUPNP_DLNA_FLAGS_DLNA_V15                  => (1 +< 20),
  GUPNP_DLNA_FLAGS_LINK_PROTECTED_CONTENT    => (1 +< 16),
  GUPNP_DLNA_FLAGS_CLEAR_TEXT_BYTE_SEEK_FULL => (1 +< 15),
  GUPNP_DLNA_FLAGS_LOP_CLEAR_TEXT_BYTE_SEEK  => (1 +< 14),
);

constant GUPnPDLNAOperation is export := guint32;
our enum GUPnPDLNAOperationEnum is export (
  GUPNP_DLNA_OPERATION_NONE     => 0x00,
  GUPNP_DLNA_OPERATION_RANGE    => 0x01,
  GUPNP_DLNA_OPERATION_TIMESEEK => 0x10,
);

constant GUPnPDLNAValueState is export := guint32;
our enum GUPnPDLNAValueStateEnum is export <
  GUPNP_DLNA_VALUE_STATE_SET
  GUPNP_DLNA_VALUE_STATE_UNSET
  GUPNP_DLNA_VALUE_STATE_UNSUPPORTED
>;

constant GUPnPOCMFlags is export := guint32;
our enum GUPnPOCMFlagsEnum is export (
  GUPNP_OCM_FLAGS_NONE               =>  0x0,
  GUPNP_OCM_FLAGS_UPLOAD             => 0x01,
  GUPNP_OCM_FLAGS_CREATE_CONTAINER   => 0x02,
  GUPNP_OCM_FLAGS_DESTROYABLE        => 0x04,
  GUPNP_OCM_FLAGS_UPLOAD_DESTROYABLE => 0x08,
  GUPNP_OCM_FLAGS_CHANGE_METADATA    => 0x10,
);

constant GUPnPProtocolError is export := guint32;
our enum GUPnPProtocolErrorEnum is export <
  GUPNP_PROTOCOL_ERROR_INVALID_SYNTAX
  GUPNP_PROTOCOL_ERROR_OTHER
>;

constant GUPnPSearchCriteriaOp is export := guint32;
our enum GUPnPSearchCriteriaOpEnum (
  # G_TYPE_STRING
  GUPNP_SEARCH_CRITERIA_OP_EQ               => G_TOKEN_LAST + 1,
  GUPNP_SEARCH_CRITERIA_OP_NEQ              => G_TOKEN_LAST + 2,
  GUPNP_SEARCH_CRITERIA_OP_LESS             => G_TOKEN_LAST + 3,
  GUPNP_SEARCH_CRITERIA_OP_LEQ              => G_TOKEN_LAST + 4,
  GUPNP_SEARCH_CRITERIA_OP_GREATER          => G_TOKEN_LAST + 5,
  GUPNP_SEARCH_CRITERIA_OP_GEQ              => G_TOKEN_LAST + 6,
  GUPNP_SEARCH_CRITERIA_OP_CONTAINS         => G_TOKEN_LAST + 7,
  GUPNP_SEARCH_CRITERIA_OP_DOES_NOT_CONTAIN => G_TOKEN_LAST + 8,
  GUPNP_SEARCH_CRITERIA_OP_DERIVED_FROM     => G_TOKEN_LAST + 9,
  # G_TYPE_BOOLEAN
  GUPNP_SEARCH_CRITERIA_OP_EXISTS           => G_TOKEN_LAST + 10
);

constant GUPnPSearchCriteriaParserError is export := guint32;
our enum GUPnPSearchCriteriaParserErrorEnum is export <
  GUPNP_SEARCH_CRITERIA_PARSER_ERROR_FAILED
>;
