// import 'dart:convert';

// import '../data/models/location_info/location_info.dart';
// import '../data/models/routes_model/routes_model.dart';
// import 'package:http/http.dart' as http;

// import '../data/models/routes_modifires.dart';
// import '../utils/utils.dart';

// class RoutesServices {
//   final String baseURL =
//       'https://routes.googleapis.com/directions/v2:computeRoutes';
//   final String _apiKey = Utils.googleRoutesApiKey;

//   Future<RoutesModel> fetchRoutes(
//       {required LocationInfoModel origin,
//       required LocationInfoModel destination,
//       required RoutesModifires routesModifires}) async {
//     Uri url = Uri.parse(baseURL);
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'X-Goog-Api-Key': _apiKey,
//       'X-Goog-FieldMask':
//           'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
//     };

//     Map<String, dynamic> body = {
//       "origin": origin.toJson(),
//       "destination": destination.toJson(),
//       "travelMode": "DRIVE",
//       "routingPreference": "TRAFFIC_AWARE",
//       "computeAlternativeRoutes": false,
//       "routeModifiers": routesModifires.toJson(),
//       "languageCode": "en-US",
//       "units": "IMPERIAL"
//     };

//     var response =
//         await http.post(url, headers: headers, body: jsonEncode(body));
//     if (response.statusCode == 200) {
//       return RoutesModel.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Failed to load routes");
//     }
//   }
// }
