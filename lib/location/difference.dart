/*
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:great_circle_distance/great_circle_distance.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geolocator/models/position.dart' as geoposition;

double getDistanceBetween(GeoPoint point1, GeoPoint point2, {int method = 1}) {
  var gcd = new GreatCircleDistance.fromDegrees(latitude1: point1.latitude, longitude1: point1.longitude, latitude2: point2.latitude, longitude2: point2.longitude);
  print('Distance from location 1 to 2 using the Haversine formula is: ${gcd.haversineDistance()}');
  print('Distance from location 1 to 2 using the Spherical Law of Cosines is: ${gcd.sphericalLawOfCosinesDistance()}');
  print('Distance from location 1 to 2 using the Vicenty`s formula is: ${gcd.vincentyDistance()}');
  if (method == 1)
    return gcd.haversineDistance();
  else if (method == 2)
    return gcd.sphericalLawOfCosinesDistance();
  else
    return gcd.vincentyDistance();
}

// Future<GeoPoint> getCurrentGeoPoint() async {
//   Geolocator _geolocator = new Geolocator();
//   geoposition.Position position;
//   GeoPoint geoPoint;
//   try {
//       position = await _geolocator.getPosition(LocationAccuracy.high);
//       geoPoint = new GeoPoint(position.latitude, position.longitude);
//   } on PlatformException {
//       print("Couldn't get position");
//       geoPoint = new GeoPoint(0.0, 0.0);
//   }
//   return geoPoint;
// }
*/