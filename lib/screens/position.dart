import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:convert';


class PositionPage extends StatefulWidget {


  @override
  _PositionPageState createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {





  MapController controller=new MapController();
  Position _position;
  StreamSubscription<Position> _positionStream;
  LatLng latLng;


  buildMap() {
     controller.onReady.then((result){
       controller.move(latLng, 15.0);
     });
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var locationOptions=LocationOptions(accuracy: LocationAccuracy.high,distanceFilter: 10);
    _positionStream=Geolocator().getPositionStream(locationOptions).listen((Position position) {
      setState(() {
        print(position);
        _position=position;
        latLng=new LatLng(_position.latitude, _position.longitude);
        print(latLng);
      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _positionStream.cancel();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrange,),
      body: FlutterMap(
        mapController: controller,
        options: MapOptions(center: buildMap(),minZoom: 5.0),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org{z}/{x}/{y}.png",
            subdomains: ['a','b','c']
          ),
        ],),
    );
  }
}
