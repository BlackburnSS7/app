import 'package:geolocator/geolocator.dart';

import '../screens/camera.dart';
import 'package:flutter/material.dart';
import '../screens/quiz.dart';
import '../screens/weather.dart';
import '../screens/gallery.dart';
import '../screens/position.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.brown[100],
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.deepOrange,Colors.white])
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/aa.png'),
                ),
              ),
            ),
            ListTile(
              title: Text("Quiz",style:TextStyle(fontSize: 20),),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push( context, MaterialPageRoute( builder: (context)=>Quiz() ) );
              },
            ),
            Divider(height: 4,color: Colors.grey,),
            ListTile(
              title: Text("Weather",style:TextStyle(fontSize: 20),),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Weather()));
              },
            ),
            Divider(height: 4,color: Colors.grey,),
            ListTile(
              title: Text("Gallery",style:TextStyle(fontSize: 20),),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Gallery()));
              },
            ),
            Divider(height: 4,color: Colors.grey,),
            ListTile(
              title: Text("Camera",style:TextStyle(fontSize: 20),),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraPage()));
              },
            ),
            Divider(height: 4,color: Colors.grey,),
            ListTile(
              title: Text("Position",style:TextStyle(fontSize: 20),),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PositionPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
