import 'package:flutter/material.dart';
import './quizz-page.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> cat=["Books",
    "Film",
   "Music",
   "Musicals/Theatre",
   "Television",
   "Video Games",
   "Board Games",
   "Science and Nature"];

  Widget getButtonWidgets(List<String> cat){

    List<Widget> list=new List<Widget>();
    for(var i=0;i<7;i++){
        int val=i.toInt()+10;
        list.add(Container(width: double.infinity,
          child: new RaisedButton(
            child: Text(cat[i],style: TextStyle(color: Colors.black),),
            color: Colors.deepOrange,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizPage(val)));
            },),
        ),);
    }

    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(color: Colors.brown[100],
        child: Column(
          children: <Widget>[
            Center(
                child: Text("Catégorie",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
            ),
            getButtonWidgets(cat)
          ],

        ),
      ));
  }
}
