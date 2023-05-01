import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(25.031421, 121.566013);
  final Map<String, Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    final marker = Marker(
        markerId: MarkerId('AppWorks'),
        position: const LatLng(25.038601, 121.532356),
        infoWindow: const InfoWindow(
            title: 'AppWorks School', snippet: '100台北市中正區仁愛路二段99號'));

    setState(() {
      _markers['AppWorks'] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Map', style: TextStyle(color: Colors.black),),
            backgroundColor: const Color(0xFFEEF1F7),
            centerTitle: true,
          ),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
            markers: Set<Marker>.of(_markers.values),
          )),
    );
  }
}
