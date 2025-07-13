# geoserver

Simple Geoserver with WFS/WMS service and OGC API Features.

## Sample Data

Two simple points (Munich and Berlin), stored in the sample_data/init.sql.
This data is automigrated to Postgres/PostGIS database and connected via geoserver_setup/setup.sh script to Geoserver. Following steps are done via Geoserver REST API:

- Create Workspace: test_workspace
- Create Datastore: postgis_store
- Publish Layer (WMS/WFS): my_table
- Enable the OGC API Features Plugin
- Puplish OGC API Feature Collection: my_table

## Geoserver as Docker

Used Version: [2.27.1](docker.osgeo.org/geoserver:2.27.1)

## Run setup

```
docker-compose up --build
```

## Serve the applications

### Geoserver

```
http://localhost:8080/geoserver
```

### Configure Geoserver

- Login to geoserver:
  - user: admin
  - password: geoserver
- Preview Layer and use them:
  - Select "Layer-Preview"
  - Select the Layer "my_table"
  - Select "All Formats" -> "WFS" -> "GeoJSON"
  - Use the URI as QGIS/OpenLayers Adress:
    - WMS/WFS: http://localhost:8080/geoserver/test_workspace/ows
    - OGC API Features: http://localhost:8080/geoserver/ogc/features/v1
  - for specific features: use the preview URL
