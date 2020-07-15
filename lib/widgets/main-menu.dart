import 'package:flutter/material.dart';
import 'main-drawer.dart';


class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: MainDrawer(),
      appBar: AppBar(title: Text("My app"),backgroundColor: Colors.deepOrange,),
      body:Container(
          color: Colors.brown[100],
          child: Center(
            child:Center(child: Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,),)),
          )),);
  }
}
