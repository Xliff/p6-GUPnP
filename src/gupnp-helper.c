#include <stdio.h>
#include <stdarg.h>
#include <libxml/tree.h>

#include "glib.h"
#include "glib-object.h"
#include "libgupnp/gupnp.h"
#include "libgupnp-av/gupnp-last-change-parser.h"

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

G_GNUC_INTERNAL gboolean
gvalue_util_set_value_from_string      (GValue       *value,
                                        const char   *str);

typedef enum _GUPnPXMLNamespace
{
        GUPNP_XML_NAMESPACE_DIDL_LITE,
        GUPNP_XML_NAMESPACE_DC,
        GUPNP_XML_NAMESPACE_DLNA,
        GUPNP_XML_NAMESPACE_PV,
        GUPNP_XML_NAMESPACE_UPNP,
        GUPNP_XML_NAMESPACE_COUNT
} GUPnPXMLNamespace;

G_BEGIN_DECLS

typedef struct _GPnPAVXMLDoc
{
    volatile int refcount;
    xmlDoc *doc;
} GUPnPAVXMLDoc;

G_GNUC_INTERNAL GUPnPAVXMLDoc *
av_xml_doc_new                             (xmlDoc *doc);

G_GNUC_INTERNAL GUPnPAVXMLDoc *
av_xml_doc_ref                             (GUPnPAVXMLDoc *doc);

G_GNUC_INTERNAL void
av_xml_doc_unref                           (GUPnPAVXMLDoc *doc);

G_GNUC_INTERNAL GType
av_xml_doc_get_type                        (void) G_GNUC_CONST;

/* Misc utilities for inspecting xmlNodes */
G_GNUC_INTERNAL xmlNode *
av_xml_util_get_element                    (xmlNode    *node,
                                             ...) G_GNUC_NULL_TERMINATED;

G_GNUC_INTERNAL GList *
av_xml_util_get_child_elements_by_name     (xmlNode *node,
                                            const char *name);

G_GNUC_INTERNAL const char *
av_xml_util_get_child_element_content      (xmlNode    *node,
                                            const char *child_name);

G_GNUC_INTERNAL guint
av_xml_util_get_uint_child_element         (xmlNode    *node,
                                            const char *child_name,
                                            guint       default_value);

G_GNUC_INTERNAL guint64
av_xml_util_get_uint64_child_element       (xmlNode    *node,
                                            const char *child_name,
                                            guint64     default_value);

G_GNUC_INTERNAL const char *
av_xml_util_get_attribute_content          (xmlNode    *node,
                                            const char *attribute_name);

G_GNUC_INTERNAL gboolean
av_xml_util_get_boolean_attribute          (xmlNode    *node,
                                            const char *attribute_name);

G_GNUC_INTERNAL guint
av_xml_util_get_uint_attribute             (xmlNode    *node,
                                            const char *attribute_name,
                                            guint       default_value);

G_GNUC_INTERNAL gint
av_xml_util_get_int_attribute              (xmlNode    *node,
                                            const char *attribute_name,
                                            gint        default_value);

G_GNUC_INTERNAL glong
av_xml_util_get_long_attribute             (xmlNode    *node,
                                            const char *attribute_name,
                                            glong       default_value);

G_GNUC_INTERNAL gint64
av_xml_util_get_int64_attribute            (xmlNode    *node,
                                            const char *attribute_name,
                                            gint64      default_value);

G_GNUC_INTERNAL xmlNode *
av_xml_util_set_child                      (xmlNode          *parent_node,
                                            GUPnPXMLNamespace ns,
                                            xmlNsPtr         *namespace,
                                            xmlDoc           *doc,
                                            const char       *name,
                                            const char       *value);

G_GNUC_INTERNAL void
av_xml_util_unset_child                    (xmlNode    *parent_node,
                                            const char *name);

G_GNUC_INTERNAL gboolean
av_xml_util_verify_attribute_is_boolean    (xmlNode    *node,
                                            const char *attribute_name);

G_GNUC_INTERNAL char *
av_xml_util_get_child_string               (xmlNode    *parent_node,
                                            xmlDoc     *doc,
                                            const char *name);

G_GNUC_INTERNAL gboolean
av_xml_util_node_deep_equal                (xmlNode *first,
                                            xmlNode *second);

G_GNUC_INTERNAL xmlNode *
av_xml_util_find_node                      (xmlNode *haystack,
                                            xmlNode *needle);

G_GNUC_INTERNAL xmlNode *
av_xml_util_copy_node                      (xmlNode *node);

G_GNUC_INTERNAL GHashTable *
av_xml_util_get_attributes_map             (xmlNode *node);

G_GNUC_INTERNAL xmlNsPtr
av_xml_util_create_namespace               (xmlNodePtr root,
                                            GUPnPXMLNamespace ns);

G_GNUC_INTERNAL xmlNsPtr
av_xml_util_lookup_namespace               (xmlDocPtr doc,
                                            GUPnPXMLNamespace ns);

G_GNUC_INTERNAL xmlNsPtr
av_xml_util_get_ns                         (xmlDocPtr doc,
                                            GUPnPXMLNamespace ns,
                                            xmlNsPtr *ns_out);

G_END_DECLS

// Lifted from libgupnp-av/gupnp_last-change-parser.c
static gboolean
read_state_variable (const char *variable_name,
                     GValue     *value,
                     xmlNode    *instance_node)
{
        xmlNode    *variable_node;
        const char *val_str;

        variable_node = av_xml_util_get_element (instance_node,
                                                 variable_name,
                                                 NULL);
        if (!variable_node)
                return FALSE;

        val_str = av_xml_util_get_attribute_content (variable_node, "val");
        if (!val_str) {
                g_warning ("No value provided for variable \"%s\" in "
                           "LastChange event",
                           variable_name);

                return FALSE;
        }

        gvalue_util_set_value_from_string (value, val_str);

        return TRUE;
}

// Lifted from libgupnp-av/gupnp_last-change-parser.c
static xmlNode *
get_instance_node (xmlDoc *doc,
                   guint   instance_id)
{
        xmlNode *node;

        if (doc->children == NULL)
                return NULL;

        for (node = doc->children->children;
             node;
             node = node->next) {
                if (node->type != XML_ELEMENT_NODE)
                        continue;

                if (!xmlStrcmp (node->name, BAD_CAST ("InstanceID")) &&
                    av_xml_util_get_uint_attribute (node, "val", 0) ==
                                        instance_id)
                        break;
        }

        return node;
}

// Copyright (C) 2006, 2007 OpenedHand Ltd.
// Copyright (C) 2007 Zeeshan Ali.
// Copyright (C) 2012 Intel Corporation
// Copyright © 2021 Genex Software

// Author: Jorn Baayen <jorn@openedhand.com>
// Author: Zeeshan Ali (Khattak) <zeeshanak@gnome.org>
// Author: Krzesimir Nowak <krnowak@openismus.com>
// Additional Author: Clifton Wood<clifton.wood@gmail.com>
//
// Condensed reimplementation of
// gupnp_last_change_parser_parse_last_change_valist
// ..without the valist
gboolean helper_gupnp_last_change_parser_parse_last_change (
	GUPnPLastChangeParser  *parser,
	guint                   instance_id,
	const char             *last_change_xml,
  const char            **names,
  GType                  *types,
	GValue                 *values,
	int                     num_items,
  GError                **error
) {
  xmlDoc  *doc;
  xmlNode *instance_node;

  g_return_val_if_fail (last_change_xml, FALSE);

  doc = xmlParseDoc ((const xmlChar *) last_change_xml);
  if (doc == NULL) {
          g_set_error (error,
                       G_MARKUP_ERROR,
                       G_MARKUP_ERROR_PARSE,
                       "Could not parse LastChange xml");

          return FALSE;
  }

  instance_node = get_instance_node (doc, instance_id);
  if (instance_node == NULL) {
          /* This is not an error since the caller of this function
           * doesn't (need to) know if the instance of his interest is
           * part of the LastChange event received.
           */
          xmlFreeDoc (doc);
  }

  for (int i = 0; i < num_items; i++) {
    GValue value = { 0, };

    g_value_init(&value, types[i]);
    if (read_state_variable (names[i],
                             &value,
                             instance_node)) {
      // Lookup G_VALUE_LCOPY for copy_error?
      g_value_copy(&value, &values[i]);
    } else {
      g_value_init(&values[i], G_TYPE_POINTER);
    }

    g_value_unset(&value);
  }

  xmlFreeDoc(doc);
  return TRUE;
}

/*
 * Copyright (C) 2007 OpenedHand Ltd.
 *
 * Author: Jorn Baayen <jorn@openedhand.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

gboolean
gvalue_util_set_value_from_string (GValue     *value,
                                   const char *str)
{
        GValue tmp_value = {0, };
        int i;
        long l;
        double d;

        g_return_val_if_fail (str != NULL, FALSE);

        switch (G_VALUE_TYPE (value)) {
        case G_TYPE_STRING:
                g_value_set_string (value, str);

                break;

        case G_TYPE_CHAR:
#if GLIB_CHECK_VERSION(2,32,0)
                g_value_set_schar (value, *str);
#else
                g_value_set_char (value, *str);
#endif

                break;

        case G_TYPE_UCHAR:
                g_value_set_uchar (value, *str);

                break;

        case G_TYPE_INT:
                i = atoi (str);
                g_value_set_int (value, i);

                break;

        case G_TYPE_UINT:
                i = atoi (str);
                g_value_set_uint (value, (guint) i);

                break;

        case G_TYPE_INT64:
                i = atoi (str);
                g_value_set_int64 (value, (gint64) i);

                break;

        case G_TYPE_UINT64:
                i = atoi (str);
                g_value_set_uint64 (value, (guint64) i);

                break;

        case G_TYPE_LONG:
                l = atol (str);
                g_value_set_long (value, l);

                break;

        case G_TYPE_ULONG:
                l = atol (str);
                g_value_set_ulong (value, (gulong) l);

                break;

        case G_TYPE_FLOAT:
                d = atof (str);
                g_value_set_float (value, (float) d);

                break;

        case G_TYPE_DOUBLE:
                d = atof (str);
                g_value_set_float (value, d);

                break;

        case G_TYPE_BOOLEAN:
                if (g_ascii_strcasecmp (str, "true") == 0 ||
                    g_ascii_strcasecmp (str, "yes") == 0)
                        g_value_set_boolean (value, TRUE);
                else if (g_ascii_strcasecmp (str, "false") == 0 ||
                         g_ascii_strcasecmp (str, "no") == 0)
                        g_value_set_boolean (value, FALSE);
                else {
                        i = atoi (str);
                        g_value_set_boolean (value, i ? TRUE : FALSE);
                }

                break;

        default:
                /* Try to convert */
                if (g_value_type_transformable (G_TYPE_STRING,
                                                G_VALUE_TYPE (value))) {
                        g_value_init (&tmp_value, G_TYPE_STRING);
                        g_value_set_static_string (&tmp_value, str);

                        g_value_transform (&tmp_value, value);

                        g_value_unset (&tmp_value);

                } else if (g_value_type_transformable (G_TYPE_INT,
                                                       G_VALUE_TYPE (value))) {
                        i = atoi (str);

                        g_value_init (&tmp_value, G_TYPE_INT);
                        g_value_set_int (&tmp_value, i);

                        g_value_transform (&tmp_value, value);

                        g_value_unset (&tmp_value);

                } else {
                        g_warning ("Failed to transform integer "
                                   "value to type %s",
                                   G_VALUE_TYPE_NAME (value));

                        return FALSE;
                }

                break;
        }

        return TRUE;
}

/*
 * Copyright (C) 2006, 2007 OpenedHand Ltd.
 * Copyright (C) 2007 Zeeshan Ali.
 * Copyright (C) 2012 Intel Corporation
 *
 * Author: Jorn Baayen <jorn@openedhand.com>
 * Author: Zeeshan Ali (Khattak) <zeeshanak@gnome.org>
 * Author: Krzesimir Nowak <krnowak@openismus.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

#include <string.h>

typedef struct _GUPnPXMLNamespaceDescription
{
        const char *uri;
        const char *prefix;
} GUPnPXMLNamespaceDescription;


static GUPnPXMLNamespaceDescription gupnp_xml_namespaces[] =
{
        { "urn:schemas-upnp-org:metadata-1-0/DIDL-Lite/", NULL },
        { "http://purl.org/dc/elements/1.1/", "dc" },
        { "urn:schemas-dlna-org:metadata-1-0/", "dlna" },
        { "http://www.pv.com/pvns/", "pv" },
        { "urn:schemas-upnp-org:metadata-1-0/upnp/", "upnp" },
        { NULL }
};

GUPnPAVXMLDoc *
av_xml_doc_new (xmlDoc *doc)
{
        GUPnPAVXMLDoc *ret = NULL;

        g_return_val_if_fail (doc, NULL);

        ret = g_new0 (GUPnPAVXMLDoc, 1);
        ret->refcount = 1;
        ret->doc = doc;

        return ret;
}

GUPnPAVXMLDoc *
av_xml_doc_ref (GUPnPAVXMLDoc *doc)
{
        g_return_val_if_fail (doc, NULL);
        g_return_val_if_fail (doc->refcount > 0, NULL);
        g_atomic_int_inc (&doc->refcount);

        return doc;
}

void
av_xml_doc_unref (GUPnPAVXMLDoc *doc)
{
        g_return_if_fail (doc);
        g_return_if_fail (doc->refcount > 0);

        if (g_atomic_int_dec_and_test (&doc->refcount)) {
                xmlFreeDoc (doc->doc);
                doc->doc = NULL;
                g_free (doc);
        }
}

xmlNode *
av_xml_util_get_element (xmlNode *node,
                         ...)
{
        va_list var_args;

        va_start (var_args, node);

        while (TRUE) {
                const char *arg;

                arg = va_arg (var_args, const char *);
                if (!arg)
                        break;

                for (node = node->children; node; node = node->next) {
                        if (node->name == NULL)
                                continue;

                        if (!g_ascii_strcasecmp (arg, (char *) node->name))
                                break;
                }

                if (!node)
                        break;
        }

        va_end (var_args);

        return node;
}

GList *
av_xml_util_get_child_elements_by_name (xmlNode *node, const char *name)
{
       GList *children = NULL;

       for (node = node->children; node; node = node->next) {
               if (node->name == NULL)
                       continue;

               if (strcmp (name, (char *) node->name) == 0) {
                       children = g_list_append (children, node);
               }
       }

       return children;
}

const char *
av_xml_util_get_child_element_content (xmlNode    *node,
                                       const char *child_name)
{
        xmlNode *child_node;
        const char *content;

        child_node = av_xml_util_get_element (node, child_name, NULL);
        if (!child_node || !(child_node->children))
                return NULL;

        content = (const char *) child_node->children->content;
        if (!content)
                return NULL;

        return content;
}

guint
av_xml_util_get_uint_child_element (xmlNode    *node,
                                    const char *child_name,
                                    guint       default_value)
{
        const char *content;

        content = av_xml_util_get_child_element_content (node, child_name);
        if (!content)
                return default_value;

        return strtoul (content, NULL, 0);
}

guint64
av_xml_util_get_uint64_child_element (xmlNode    *node,
                                      const char *child_name,
                                      guint64     default_value)
{
        const char *content;

        content = av_xml_util_get_child_element_content (node, child_name);
        if (!content)
                return default_value;

        return g_ascii_strtoull (content, NULL, 0);
}

const char *
av_xml_util_get_attribute_content (xmlNode    *node,
                                   const char *attribute_name)
{
        xmlAttr *attribute;

        for (attribute = node->properties;
             attribute;
             attribute = attribute->next) {
                if (attribute->name == NULL)
                        continue;

                if (strcmp (attribute_name, (char *) attribute->name) == 0)
                        break;
        }

        if (attribute)
                return (const char *) attribute->children->content;
        else
                return NULL;
}

gboolean
av_xml_util_get_boolean_attribute (xmlNode    *node,
                                   const char *attribute_name)
{
        const char *content;
        gchar   *str;
        gboolean ret;

        content = av_xml_util_get_attribute_content (node, attribute_name);
        if (!content)
                return FALSE;

        str = (char *) content;
        if (g_ascii_strcasecmp (str, "true") == 0 ||
            g_ascii_strcasecmp (str, "yes") == 0)
                ret = TRUE;
        else if (g_ascii_strcasecmp (str, "false") == 0 ||
                 g_ascii_strcasecmp (str, "no") == 0)
                ret = FALSE;
        else {
                int i;

                i = atoi (str);
                ret = i ? TRUE : FALSE;
        }

        return ret;
}

guint
av_xml_util_get_uint_attribute (xmlNode    *node,
                                const char *attribute_name,
                                guint       default_value)
{
        return (guint) av_xml_util_get_long_attribute (node,
                                                    attribute_name,
                                                    (glong) default_value);
}

gint
av_xml_util_get_int_attribute (xmlNode    *node,
                               const char *attribute_name,
                               gint        default_value)
{
        return (gint) av_xml_util_get_long_attribute (node,
                                                   attribute_name,
                                                   (glong) default_value);
}

glong
av_xml_util_get_long_attribute (xmlNode    *node,
                                const char *attribute_name,
                                glong       default_value)
{
    return (glong) av_xml_util_get_int64_attribute (node,
                                                 attribute_name,
                                                 (gint64) default_value);
}

gint64
av_xml_util_get_int64_attribute (xmlNode    *node,
                                 const char *attribute_name,
                                 gint64      default_value)
{
        const char *content;

        content = av_xml_util_get_attribute_content (node, attribute_name);
        if (!content)
                return default_value;

        return g_ascii_strtoll (content, NULL, 0);
}

xmlNode *
av_xml_util_set_child (xmlNode    *parent_node,
                       GUPnPXMLNamespace ns,
                       xmlNsPtr   *xmlns,
                       xmlDoc     *doc,
                       const char *name,
                       const char *value)
{
        xmlNode *node;
        xmlChar *escaped;

        node = av_xml_util_get_element (parent_node, name, NULL);
        if (node == NULL) {
                xmlNsPtr ns_ptr = NULL;

                ns_ptr = av_xml_util_get_ns (doc, ns, xmlns);
                node = xmlNewChild (parent_node,
                                    ns_ptr,
                                    (unsigned char *) name,
                                    NULL);
        }

        escaped = xmlEncodeSpecialChars (doc, (const unsigned char *) value);
        xmlNodeSetContent (node, escaped);
        xmlFree (escaped);

        return node;
}

void
av_xml_util_unset_child (xmlNode    *parent_node,
                         const char *name)
{
        xmlNode *node;

        node = av_xml_util_get_element (parent_node, name, NULL);
        if (node != NULL) {
                xmlUnlinkNode (node);
                xmlFreeNode (node);
        }
}

gboolean
av_xml_util_verify_attribute_is_boolean (xmlNode    *node,
                                         const char *attribute_name)
{
        const char *content;
        char *str;

        content = av_xml_util_get_attribute_content (node, attribute_name);
        if (content == NULL)
            return FALSE;

        str = (char *) content;

        return g_ascii_strcasecmp (str, "true") == 0 ||
               g_ascii_strcasecmp (str, "yes") == 0 ||
               g_ascii_strcasecmp (str, "false") == 0 ||
               g_ascii_strcasecmp (str, "no") == 0 ||
               g_ascii_strcasecmp (str, "0") == 0 ||
               g_ascii_strcasecmp (str, "1") == 0;
}

char *
av_xml_util_get_child_string (xmlNode    *parent_node,
                              xmlDoc     *doc,
                              const char *name)
{
        xmlBuffer *buffer;
        char      *ret;
        xmlNode   *node;

        node = av_xml_util_get_element (parent_node, name, NULL);
        if (!node)
                return NULL;

        buffer = xmlBufferCreate ();
        xmlNodeDump (buffer,
                     doc,
                     node,
                     0,
                     0);
        ret = g_strndup ((char *) xmlBufferContent (buffer),
                         xmlBufferLength (buffer));
        xmlBufferFree (buffer);

        return ret;
}

gboolean
av_xml_util_node_deep_equal (xmlNode *first,
                             xmlNode *second)
{
        GHashTable *first_attributes;
        xmlAttr *attribute;
        gboolean equal;

        if (first == NULL && second == NULL)
                return TRUE;
        if (first == NULL || second == NULL)
                return FALSE;

        if (xmlStrcmp (first->name, second->name))
                return FALSE;

        equal = FALSE;
        first_attributes = av_xml_util_get_attributes_map (first);
        /* compare attributes */
        for (attribute = second->properties;
             attribute != NULL;
             attribute = attribute->next) {
                const xmlChar *value = NULL;
                const xmlChar *key = attribute->name;

                if (g_hash_table_lookup_extended (first_attributes,
                                                  key,
                                                  NULL,
                                                  (gpointer *) &value))
                        if (!xmlStrcmp (value, attribute->children->content)) {
                                g_hash_table_remove (first_attributes, key);

                                continue;
                        }

                goto out;
        }

        if (g_hash_table_size (first_attributes))
                goto out;

        /* compare content */
        if (xmlStrcmp (first->content, second->content))
                goto out;
        equal = TRUE;
 out:
        g_hash_table_unref (first_attributes);
        if (equal) {
                xmlNode *first_child;
                xmlNode *second_child;

                for (first_child = first->children,
                     second_child = second->children;
                     first_child != NULL && second_child != NULL;
                     first_child = first_child->next,
                     second_child = second_child->next)
                        if (!av_xml_util_node_deep_equal (first_child,
                                                          second_child))
                                return FALSE;
                if (first_child != NULL || second_child != NULL)
                        return FALSE;
        }

        return equal;
}

xmlNode *
av_xml_util_find_node (xmlNode *haystack,
                       xmlNode *needle)
{
        xmlNodePtr iter;

        if (av_xml_util_node_deep_equal (haystack, needle))
                return haystack;

        for (iter = haystack->children; iter != NULL; iter = iter->next) {
                xmlNodePtr found_node = av_xml_util_find_node (iter, needle);

                if (found_node != NULL)
                        return found_node;
        }

        return NULL;
}

xmlNode *
av_xml_util_copy_node (xmlNode *node)
{
        xmlNode *dup = xmlCopyNode (node, 1);

        /* TODO: remove useless namespace definition. */

        return dup;
}

GHashTable *
av_xml_util_get_attributes_map (xmlNode *node)
{
        xmlAttr *attribute;
        GHashTable *attributes_map = g_hash_table_new (g_str_hash,
                                                       g_str_equal);

        for (attribute = node->properties;
             attribute != NULL;
             attribute = attribute->next)
                g_hash_table_insert (attributes_map,
                                     (gpointer) attribute->name,
                                     (gpointer) attribute->children->content);

        return attributes_map;
}

/**
 * av_xml_util_create_namespace:
 * @root: (allow-none): Document root node or %NULL for anonymous ns.
 * @ns: Namespace
 * @returns: Newly created namespace on root node
 */
xmlNsPtr
av_xml_util_create_namespace (xmlNodePtr root, GUPnPXMLNamespace ns)
{
        g_return_val_if_fail (ns < GUPNP_XML_NAMESPACE_COUNT, NULL);

        return xmlNewNs (root,
                         (const xmlChar *) gupnp_xml_namespaces[ns].uri,
                         (const xmlChar *) gupnp_xml_namespaces[ns].prefix);
}

/**
 * av_xml_util_lookup_namespace:
 * @doc: #xmlDoc
 * @ns: namespace to look up (except DIDL-Lite, which doesn't have a prefix)
 * @returns: %NULL if namespace does not exist, a pointer to the namespace
 * otherwise.
 */
xmlNsPtr
av_xml_util_lookup_namespace (xmlDocPtr doc, GUPnPXMLNamespace ns)
{
        xmlNsPtr *ns_list, *it, retval = NULL;
        const char *ns_prefix = NULL;
        const char *ns_uri = NULL;

        g_return_val_if_fail (ns < GUPNP_XML_NAMESPACE_COUNT, NULL);

        ns_prefix = gupnp_xml_namespaces[ns].prefix;
        ns_uri = gupnp_xml_namespaces[ns].uri;

        ns_list = xmlGetNsList (doc, xmlDocGetRootElement (doc));
        if (ns_list == NULL)
                return NULL;

        for (it = ns_list; *it != NULL; it++) {
                const char *it_prefix = (const char *) (*it)->prefix;
                const char *it_uri = (const char *) (*it)->href;

                if (it_prefix == NULL) {
                        if (ns_prefix != NULL)
                                continue;

                        if (g_ascii_strcasecmp (it_uri, ns_uri) == 0) {
                                retval = *it;
                                break;
                        }

                        continue;
                }

                if (g_ascii_strcasecmp (it_prefix, ns_prefix) == 0) {
                        retval = *it;
                        break;
                }
        }

        xmlFree (ns_list);

        return retval;
}

/**
 * av_xml_util_get_ns:
 * @doc: A #xmlDoc.
 * @ns: A #GUPnPXMLNamespace.
 * @ns_out: (out) (allow-none): return location for the namespace or %NULL.
 *
 * Lazy-create a XML namespace on @doc.
 *
 * If @ns_out is non-%NULL, the function will return @ns_out immediately.
 * @returns: either the existing #xmlNsPtr or a newly created one.
 */
xmlNsPtr
av_xml_util_get_ns (xmlDocPtr doc, GUPnPXMLNamespace ns, xmlNsPtr *ns_out)
{
        xmlNsPtr tmp_ns;

        /* User supplied namespace, just return that */
        if (ns_out != NULL && *ns_out != NULL)
                return *ns_out;

        tmp_ns = av_xml_util_lookup_namespace (doc, ns);
        if (!tmp_ns)
                tmp_ns = av_xml_util_create_namespace
                                        (xmlDocGetRootElement (doc),
                                         ns);

        if (ns_out != NULL)
                *ns_out = tmp_ns;

        return tmp_ns;
}

G_DEFINE_BOXED_TYPE (GUPnPAVXMLDoc, av_xml_doc, av_xml_doc_ref, av_xml_doc_unref)
helper_resource_factory_get_type
