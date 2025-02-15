# geoserver

Simple geoserver with WFS/WMS service

## Structure

```
geoserver
```

## Sample Data

Sample file downloaded from [Infrageomatics/Open Infrastructure Map](https://www.infrageomatics.com/products/osm-export)

## Geoserver as Docker

Used Version: [2.26.1](https://github.com/kartoza/docker-geoserver)

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
- Crate "Workspace":
  - Name: demo
  - Namespace URI needs to be integrated as part of the WFS/WMS-Service-Layer in QGIS/OpenLayers
  - optional: Set Workspace as Default
- Configure the "Workspace" to enable WFS/WMS as service
  - select the workspace and enable necessary Services (WFS/WFS)
- Create "Store" within the "Worskpace" demo
  - "Store" could be Databases, Files etc.
  - easiest way (included into this repo): simple shapefile ([mast](./data/demo_files/mast))
- Create "Layer" to publish as WFS/WMS
  - Select "Layer" in the tree (left)
  - Click "Add a new Layer"
  - Select the "demo:mast" Store
  - Publish the Layer
  - Calculate Bounding Boxes of Layer by given Store
- Preview Layer and get WFS/WMS-URI
  - Select "Layer-Preview"
  - Select the Layer "mast"
  - Select "All Formats" -> "WFS" -> "GeoJSON"
  - Use the URI as QGIS/OpenLayers Adress: http://localhost:8080/geoserver/demo/{wfs/wms}
  - for specific features: use the preview URL
