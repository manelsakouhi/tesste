import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(34.6614, 135.4927), // Center of Yumeshimanaka, Osaka
    zoom: 15,
  ).obs;

  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polygon> polygons = <Polygon>{}.obs;
  late GoogleMapController mapController;

  @override
  void onInit() {
    super.onInit();
    _setStaticLocation();
    _addCityBorder();
  }

  void _setStaticLocation() {
    const latitude = 34.6614; // Latitude for Yumeshimanaka, Osaka
    const longitude = 135.4927; // Longitude for Yumeshimanaka, Osaka

    updateCameraPosition(CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    ));
    _addMarker(latitude, longitude);
  }

  void _addMarker(double latitude, double longitude) {
    final marker = Marker(
      markerId: MarkerId('static_location'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(
        title: 'Yumeshimanaka, Osaka',
        snippet: 'This is a marker that stays visible',
      ),
    );
    markers.add(marker);
  }

  void _addCityBorder() {
    final List<LatLng> cityBorderCoords = [
      LatLng(34.6634, 135.4857),
      LatLng(34.6604, 135.4907),
      LatLng(34.6584, 135.4937),
      LatLng(34.6554, 135.4917),
      LatLng(34.6574, 135.4867),
    ];

    polygons.add(
      Polygon(
        polygonId: PolygonId('city_border'),
        points: cityBorderCoords,
        strokeColor: Colors.red,
        strokeWidth: 3,
        fillColor: Colors.transparent,
        geodesic: true,
      ),
    );
  }

  void updateCameraPosition(CameraPosition newPosition) {
    cameraPosition.value = newPosition;
  }

  // Method to set the GoogleMapController
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Move the camera to the desired location
    mapController.animateCamera(CameraUpdate.newLatLngZoom(cameraPosition.value.target, 15));
    // Force the info window to be shown
    _showMarkerInfoWindow();
  }

  void _showMarkerInfoWindow() {
    // Show the info window of the first marker (if you have multiple markers, you'll need to adjust this)
    if (markers.isNotEmpty) {
      final marker = markers.first;
      mapController.showMarkerInfoWindow(marker.markerId);
    }
  }
}
