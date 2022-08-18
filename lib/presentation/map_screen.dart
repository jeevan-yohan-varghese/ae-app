import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import "package:latlong2/latlong.dart" as latLng;

class MapScreen extends StatefulWidget{
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         child: FlutterMap(
           options: MapOptions(
            plugins: [
          MarkerClusterPlugin(),
        ],
            center: latLng.LatLng(12.970226577896517, 79.15602145012073),
            zoom: 14,
            
           ),
           
           layers: [
            TileLayerOptions(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.app',
            ),
            MarkerLayerOptions(
            markers: [
                Marker(
                  point: latLng.LatLng(12.971718289806754, 79.1664765088189),
                  width: 80,
                  height: 80,
                  builder: (context) => FlutterLogo(),
                ),
            ],
        ),
            
           ],
           nonRotatedChildren: [
            // AttributionWidget.defaultWidget(
            //     source: 'OpenStreetMap contributors',
            //     onSourceTapped: null,
            // ),
           ],
            ),
       ),
     );
  }
}