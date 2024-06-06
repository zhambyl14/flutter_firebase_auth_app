import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../bottom_nav_bar.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map Page"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(51.090682, 71.418236),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('MarkerYMBA'),
            position: const LatLng(51.090682, 71.418236),
            infoWindow: const InfoWindow(
              title: 'Company YMBA (Puzzle Escape)',
              snippet: 'пр-т. Мангилик Ел., Астана 020000',
            ),
          ),
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }
}
