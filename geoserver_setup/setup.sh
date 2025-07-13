#!/bin/bash

# Konfiguration
GEOSERVER_URL=http://geoserver:8080/geoserver
USER=admin
PASS=geoserver
WORKSPACE=test_workspace

# Warte, bis GeoServer bereit ist
until curl -u $USER:$PASS -s "$GEOSERVER_URL/rest/about/version.xml" > /dev/null; do
  echo "⏳ Warte auf GeoServer..."
  sleep 5
done

echo "✅ GeoServer ist bereit."

# Workspace erstellen
echo "📁 Erstelle Workspace: $WORKSPACE"
curl -u $USER:$PASS -XPOST -H "Content-type: text/xml" \
  -d "<workspace><name>$WORKSPACE</name></workspace>" \
  "$GEOSERVER_URL/rest/workspaces"

# PostGIS-Store anlegen
echo "🔌 Erstelle PostGIS-Store"
curl -u $USER:$PASS -XPOST -H "Content-type: text/xml" \
  -d "<dataStore>
        <name>postgis_store</name>
        <connectionParameters>
          <host>db</host>
          <port>5432</port>
          <database>database</database>
          <user>admin</user>
          <passwd>admin</passwd>
          <dbtype>postgis</dbtype>
        </connectionParameters>
      </dataStore>" \
  "$GEOSERVER_URL/rest/workspaces/$WORKSPACE/datastores"

# 1. Layer veröffentlichen (WMS, WFS)
echo "🗺️ Veröffentliche Layer: my_table"
curl -u $USER:$PASS -XPOST -H "Content-type: text/xml" \
  -d "<featureType>
        <name>my_table</name>
        <nativeName>my_table</nativeName>
        <title>My Table</title>
      </featureType>" \
  "$GEOSERVER_URL/rest/workspaces/$WORKSPACE/datastores/postgis_store/featuretypes"

# 2. OGC API Features aktivieren
echo "🔗 Aktiviere OGC API Features für Layer: my_table"
curl -u $USER:$PASS -XPUT -H "Content-type: application/json" \
  -d '{"enabled": true}' \
  "$GEOSERVER_URL/rest/ogc/features/workspaces/$WORKSPACE/datastores/postgis_store/features/my_table"

