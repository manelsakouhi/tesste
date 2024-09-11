// import 'dart:math';


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:http/http.dart' as http;
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart';

// import 'locaition_services.dart';

// class GoogleMapsServices extends GetxController {
//   // map
//   late CameraPosition initialCameraPosition;
//   late LocationServices locationServices;
//   late GoogleMapController googleMapController;
//   late RoutesServices routesServices;
//   late LatLng userOrderLocation;

//   Set<Marker> markers = {};
//   Set<Polyline> polylines = {};

//   // start get markes
//   getMakers({required List<OrdersDetailsModel> dataOrders}) async {
//     var startMarker = BitmapDescriptor.fromBytes(await getImageFromRowData(
//         image: AppImageAsset.markerOrders, width: 100));
//     var endMarker = BitmapDescriptor.fromBytes(
//         await getImageFromRowData(image: AppImageAsset.markerUser, width: 100));
//     markers.add(Marker(
//       markerId: const MarkerId("1"),
//       icon: endMarker,
//       position: LatLng(
//           double.parse(dataOrders.first.ordersAddressUserLat.toString()),
//           double.parse(dataOrders.first.ordersAddressUserLong.toString())),
//     ));
//     markers.add(Marker(
//       markerId: const MarkerId("2"),
//       icon: startMarker,
//       position: LatLng(
//           double.parse(dataOrders.first.ordersToAddressLat.toString()),
//           double.parse(dataOrders.first.ordersToAddressLong.toString())),
//     ));
//     update();
//   }
//   // end get markes

//   // start get current location
//   void updateCurrentLocation(
//       {required List<OrdersWithDelivaryModel> dataOrders}) async {
//     try {
//       // var locationData = await locationServices.getLocation();
//       // LatLng myCurrentLocation =
//       //     LatLng(locationData.latitude!, locationData.longitude!);
//       userOrderLocation = LatLng(
//           double.parse(dataOrders.first.ordersAddressUserLat!),
//           double.parse(dataOrders.first.ordersAddressUserLong!));
//       CameraPosition myCurrentLocationPosition = CameraPosition(
//         target: userOrderLocation,
//         zoom: 15,
//       );
//       googleMapController.animateCamera(
//           CameraUpdate.newCameraPosition(myCurrentLocationPosition));
//       update();
//     } on LocationServiceException catch (e) {
//       // to do
//     } on LocationPermissionException catch (e) {
//       // to do
//     } catch (e) {
//       // to do
//     }
//     update();
//   }
//   // end get current location

//   void updateCurrentDelivaryLocation(
//       {required List<DelivaryOrdersDetailsModel> dataOrders}) async {
//     try {
//       // var locationData = await locationServices.getLocation();
//       // LatLng myCurrentLocation =
//       //     LatLng(locationData.latitude!, locationData.longitude!);
//       userOrderLocation = LatLng(
//           double.parse(dataOrders.first.ordersAddressUserLat!),
//           double.parse(dataOrders.first.ordersAddressUserLong!));
//       CameraPosition myCurrentLocationPosition = CameraPosition(
//         target: userOrderLocation,
//         zoom: 15,
//       );
//       googleMapController.animateCamera(
//           CameraUpdate.newCameraPosition(myCurrentLocationPosition));
//       update();
//     } on LocationServiceException catch (e) {
//       // to do
//     } on LocationPermissionException catch (e) {
//       // to do
//     } catch (e) {
//       // to do
//     }
//     update();
//   }

//   List<LatLng> parseLatLngString(String latLngString) {
//     // Remove "LatLng(" and ")" from the string
//     latLngString = latLngString.replaceAll('LatLng(', '').replaceAll(')', '');

//     // Split the string by "-"
//     List<String> latLngPairs = latLngString.split('-');

//     // Create a list to store LatLng objects
//     List<LatLng> latLngList = [];

//     // Iterate through each pair and create LatLng objects
//     for (String latLngPair in latLngPairs) {
//       // Split the pair by ", "
//       List<String> latLngValues = latLngPair.split(', ');

//       // Parse latitude and longitude values
//       double latitude = double.parse(latLngValues[0]);
//       double longitude = double.parse(latLngValues[1]);

//       // Create LatLng object and add it to the list
//       latLngList.add(LatLng(latitude, longitude));
//     }

//     return latLngList;
//   }

//   // start get route data
//   Future<List<LatLng>> getRouteData(
//       {required List<OrdersDetailsModel> dataOrders}) async {
//     LocationInfoModel origin = LocationInfoModel(
//         location: LocationModel(
//       latLng: LatLngModel(
//         latitude: double.parse(dataOrders.first.ordersAddressUserLat!),
//         longitude: double.parse(dataOrders.first.ordersAddressUserLong!),
//       ),
//     ));

//     LocationInfoModel destination = LocationInfoModel(
//         location: LocationModel(
//       latLng: LatLngModel(
//         latitude: double.parse(dataOrders.first.ordersToAddressLat!),
//         longitude: double.parse(dataOrders.first.ordersToAddressLong!),
//       ),
//     ));

//     RoutesModifires routesModifires = RoutesModifires(
//       avoidFerries: false,
//       avoidHighways: false,
//       avoidTolls: false,
//     );

//     RoutesModel routes = await routesServices.fetchRoutes(
//         origin: origin,
//         destination: destination,
//         routesModifires: routesModifires);
//     List<LatLng> points = getDecodedRoutes(routes);
//     return points;
//   }

//   List<LatLng> getDecodedRoutes(RoutesModel routes) {
//     PolylinePoints polylinePoints = PolylinePoints();
//     List<PointLatLng> result = polylinePoints
//         .decodePolyline(routes.routes!.first.polyline!.encodedPolyline!);
//     List<LatLng> points =
//         result.map((e) => LatLng(e.latitude, e.longitude)).toList();
//     return points;
//   }

//   // end get route data

//   // start display route between two points
//   void displayRoutes(List<LatLng> points) {
//     Polyline route = Polyline(
//       polylineId: const PolylineId('route'),
//       points: points,
//       // color: Colors.blue,
//       color: AppColor.primaryColor,
//       width: 4,
//     );
//     polylines.add(route);
//     LatLngBounds bounds = getLatLngBounds(points);
//     googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 32));
//     update();
//   }

//   LatLngBounds getLatLngBounds(List<LatLng> points) {
//     var southWestLatitute = points.first.latitude;
//     var southWestLongitude = points.first.longitude;

//     var northEastLatitute = points.first.latitude;
//     var northEastLongitude = points.first.longitude;

//     for (var point in points) {
//       southWestLatitute = min(southWestLatitute, point.latitude);
//       southWestLongitude = min(southWestLongitude, point.longitude);
//       northEastLatitute = max(northEastLatitute, point.latitude);
//       northEastLongitude = max(northEastLongitude, point.longitude);
//     }
//     return LatLngBounds(
//       southwest: LatLng(southWestLatitute, southWestLongitude),
//       northeast: LatLng(northEastLatitute, northEastLongitude),
//     );
//   }
//   // end display route between two points

// // get real time location for user
//   void updateUserLocation(List<LatLng> points) async {
//     locationServices.location.changeSettings(distanceFilter: 2);
//     locationServices.getRealTimeLocationData((locationData) {
//       var userLocationMarker = Marker(
//         markerId: const MarkerId("user"),
//         position: LatLng(locationData.latitude!, locationData.longitude!),
//       );
//       markers.add(userLocationMarker);
//       LatLngBounds bounds = getLatLngBounds(points);
//       googleMapController
//           .animateCamera(CameraUpdate.newLatLngBounds(bounds, 32));
//       update();
//     });
//   }

// // start get network image marker
//   Future<BitmapDescriptor> getNetworkImageMarker(String url,
//       {int width = 100, int height = 100}) async {
//     final http.Response response = await http.get(Uri.parse(url));
//     final Uint8List bytes = response.bodyBytes;
//     ui.Codec codec = await ui.instantiateImageCodec(bytes,
//         targetWidth: width, targetHeight: height);
//     ui.FrameInfo fi = await codec.getNextFrame();

//     // Create a new picture recorder and canvas
//     final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);
//     final Size size = Size(width.toDouble(), height.toDouble());

//     // Draw the image into a circular clip path
//     canvas.clipRRect(RRect.fromRectAndRadius(
//         Rect.fromLTWH(0, 0, size.width, size.height),
//         Radius.circular(size.width / 2)));
//     paintImage(
//         canvas: canvas,
//         rect: Rect.fromLTWH(0, 0, size.width, size.height),
//         image: fi.image);

//     // Convert canvas to image, then to bytes
//     final ui.Image image =
//         await pictureRecorder.endRecording().toImage(width, height);
//     final ByteData? byteData =
//         await image.toByteData(format: ui.ImageByteFormat.png);
//     final Uint8List imgBytes = byteData!.buffer.asUint8List();

//     return BitmapDescriptor.fromBytes(imgBytes);
//   }

//   Future<BitmapDescriptor> getNetworkImageMarkerWithBorder(String url,
//       {int width = 100,
//       int height = 100,
//       Color borderColor = Colors.blue,
//       double borderWidth = 5}) async {
//     final http.Response response = await http.get(Uri.parse(url));
//     final Uint8List bytes = response.bodyBytes;
//     ui.Codec codec = await ui.instantiateImageCodec(bytes,
//         targetWidth: width, targetHeight: height);
//     ui.FrameInfo fi = await codec.getNextFrame();

//     // Create a new picture recorder and canvas
//     final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//     final ui.Canvas canvas = ui.Canvas(pictureRecorder);
//     final ui.Size size = ui.Size(width.toDouble(), height.toDouble());

//     // Draw the image into a circular clip path
//     final path = ui.Path()
//       ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
//     canvas.clipPath(path);

//     // Adjust the image size to fit within the border
//     final adjustedSize = size.width - 2 * borderWidth;
//     final imageRect =
//         Rect.fromLTWH(borderWidth, borderWidth, adjustedSize, adjustedSize);
//     paintImage(
//         canvas: canvas, rect: imageRect, image: fi.image, fit: BoxFit.fill);

//     // Draw the border
//     final paint = ui.Paint()
//       ..color = borderColor
//       ..style = ui.PaintingStyle.stroke
//       ..strokeWidth = borderWidth;
//     canvas.drawCircle(
//         size.center(Offset.zero), size.width / 2 - borderWidth / 2, paint);

//     // Convert canvas to image, then to bytes
//     final ui.Image image =
//         await pictureRecorder.endRecording().toImage(width, height);
//     final ByteData? byteData =
//         await image.toByteData(format: ui.ImageByteFormat.png);
//     final Uint8List imgBytes = byteData!.buffer.asUint8List();

//     return BitmapDescriptor.fromBytes(imgBytes);
//   }

// // end get network image marker

// // start get custom image from assets and modify width
//   Future<Uint8List> getImageFromRowData(
//       {required String image, required double width}) async {
//     var imageData = await rootBundle.load(image);
//     var imageCodec = await ui.instantiateImageCodec(
//         imageData.buffer.asUint8List(),
//         targetWidth: width.toInt());
//     var imageFrameInfo = await imageCodec.getNextFrame();
//     var imageBytData =
//         await imageFrameInfo.image.toByteData(format: ui.ImageByteFormat.png);
//     return imageBytData!.buffer.asUint8List();
//   }

//   // end

//   @override
//   void onInit() {
//     initialCameraPosition = const CameraPosition(
//       target: LatLng(0, 0),
//     );
//     locationServices = LocationServices();
//     routesServices = RoutesServices();
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     googleMapController.dispose();
//     super.dispose();
//   }
// }
