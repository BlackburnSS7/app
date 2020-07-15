import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';



class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  File imageFile;

  _openGallery(BuildContext context) async {
     var picture=await ImagePicker.pickImage(source: ImageSource.gallery);
          this.setState(() {
              imageFile=picture;
          });
          Navigator.of(context).pop();
  }
  _openCamera(BuildContext context) async{
    var picture=await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile=picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showDialogChoice(BuildContext context){
    return showDialog(context: context,builder:(BuildContext context){
        return AlertDialog(

          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: (){
                    _openGallery(context);
                  },
                ),
                Padding(padding: EdgeInsets.all(8),),
                GestureDetector(
                  child: Text("Camera"),
                  onTap: (){
                    _openCamera(context);
                  },
                )
              ],
            ),
          )
      );
    });
  }

  Widget _decideImageView(){
    if(imageFile==null){
      return Text("No Image Selected");
    }else{
      return Image.file(imageFile,width:400,height:400);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepOrange,title: Text('Camera',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),),
      body: Container(color: Colors.brown[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: (){
                _showDialogChoice(context);
              },
                child: Text("Select Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),),
              )
            ],
          ),
        ),
      )
    );
  }
}
