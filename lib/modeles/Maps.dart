import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Admin/controller/google_maps_controller.dart';


class Maps extends StatelessWidget {
  const Maps({super.key});

   

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.put(MapController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Obx(() {
        return GoogleMap(
          initialCameraPosition: mapController.cameraPosition.value,
          markers: mapController.markers,
          polygons: mapController.polygons,
          onMapCreated: (GoogleMapController controller) {
            mapController.onMapCreated(controller);
          },
          onCameraMove: (CameraPosition position) {
            mapController.updateCameraPosition(position);
          },
        );
      }),
    );
  }
}
