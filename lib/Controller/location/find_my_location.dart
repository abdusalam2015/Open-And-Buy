import 'dart:math';

import 'package:flutter/material.dart';
 
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//void main() => runApp(MyApp());

class FindMyLocation extends StatefulWidget {
  final BuildContext cont; 
  FindMyLocation(this.cont);
  @override
  _FindMyLocationState createState() => _FindMyLocationState();
}

class _FindMyLocationState extends State<FindMyLocation> {
  LocationResult _pickedLocation ;

double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  @override
  Widget build(BuildContext context) {
  //var lat = double.parse(str.split(','));

//title: 'location picker',
      
      // localizationsDelegates: const [
      //   location_picker.S.delegate,
      //   location_picker.S.delegate,
      //   GlobalMaterialLocalizations.delegate,
        
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ];
      // supportedLocales: const <Locale>[
      //   Locale('en', ''),
      //   Locale('ar', ''),
      //   Locale('pt', ''),
      //   Locale('tr', ''),
      // ];
      
    return  Scaffold(
        appBar: AppBar(
          title: const Text('location picker'),
        ),
        body: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    LocationResult result = await showLocationPicker(
                      context,
                      'AIzaSyBwq6jURpuskUG8UoYj7IOJf_B3o0oRims',
                      initialCenter: LatLng(31.1975844, 29.9598339),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                      myLocationButtonEnabled: true,
                      layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
                    );
                    print("result = $result");
                    setState(() => _pickedLocation = result);
                    //  var p1 = _pickedLocation.latLng;
                    //  var pp1= 57.73046550564395;
                    //  var pp2 = 12.978611625730991;
                    //  print("The Diffreent :");
                    //  print( calculateDistance(p1.latitude,p1.longitude,pp1,pp2));
                  },
                  child: Text('Pick location'),
                ),
                _pickedLocation!= null ?Text(_pickedLocation.toString()):Text('null'),
               // double lat = _pickedLocation.latLng.latitude;
               // double lng = _pickedLocation.latLng.longitude;
              ],
            ),
          );
        }),
      
    );
  }
}