import './quiz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class QuizPage extends StatefulWidget {
  int categorie;
  QuizPage(this.categorie);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;
  var quizData;


  getData(int categorie){
    String url="https://opentdb.com/api.php?amount=5&category=${widget.categorie.toString()}";
    http.get(url).then((resp){
      setState(() {
        this.quizData=json.decode(resp.body);

      });
    }).catchError((err){
      print(err);

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.categorie);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
      ),
      body: (this.currentQuestion >= 5)
          ? Container(color: Colors.brown[100],
            child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Score : ${(100 * score / 5).round()}%",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.bold),
                ),
                MaterialButton(
                  onPressed: (){
                    setState(() {
                      this.currentQuestion=0;
                      this.score=0;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Quiz()));
                    });
                  },
                  child: Text("Restart..."),
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                )
              ],
            )),
          )
          : (this.quizData!=null)?
      Container(color: Colors.brown[100],
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Center(
                  child: Text(
                    "Question ${currentQuestion + 1}/5",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            ListTile(
              title: Text(
                quizData['results'][currentQuestion]['question'].toString(),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(title: Padding(
              padding: const EdgeInsets.all(6.0),
              child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {

                    ++currentQuestion;
                  });
                },
                child: Text(
                  quizData['results'][currentQuestion]["incorrect_answers"][0].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),),
            ListTile(title: Padding(
              padding: const EdgeInsets.all(6.0),
              child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {

                    ++currentQuestion;
                  });
                },
                child: Text(
                  quizData['results'][currentQuestion]["incorrect_answers"][1].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),),
            ListTile(title: Padding(
              padding: const EdgeInsets.all(6.0),
              child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {

                    ++currentQuestion;
                  });
                },
                child: Text(
                  quizData['results'][currentQuestion]["incorrect_answers"][2].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),),
            ListTile(title: Padding(
              padding: const EdgeInsets.all(6.0),
              child: RaisedButton(
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    ++score;
                    ++currentQuestion;
                  });
                },
                child: Text(
                  quizData['results'][currentQuestion]["correct_answer"].toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),)

          ],
        ),
      )
          :Container(color: Colors.brown[100],
          child: Center(child: CircularProgressIndicator()))
    );
  }
}
