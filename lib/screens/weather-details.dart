import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherDetails extends StatefulWidget {
  String city;
  WeatherDetails(this.city);
  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {

   var weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather of city ${widget.city}"),
        backgroundColor: Colors.deepOrange,
      ),
      body: (weatherData==null)?
          Container(color: Colors.brown[100],
              child: Center(child: CircularProgressIndicator(),)):
          Container(color: Colors.brown[100],
            child: ListView.builder(
                itemCount:(weatherData==null?0:weatherData["list"].length) ,
                itemBuilder: (context,index){
                  return Card(
                    color: Colors.deepOrangeAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage("images/${weatherData['list'][index]['weather'][0]['main'].toString().toLowerCase()}.png"),
                          ),
                          Text(
                              "${ new DateFormat('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(weatherData['list'][index]['dt']*1000000))}",style: TextStyle(fontSize: 22,color: Colors.white)
                          ),
                          Text(
                            "${(weatherData['list'][index]['main']['temp']-273.15).round()}°C",style: TextStyle(fontSize: 30,color: Colors.white),
                          ),

                        ],
                      ),
                    ),
                  );
                }),
          )
    );
  }

  getData(String city){
    String url="http://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=abdab90c7653e989e79d7966421ab9c8";
    http.get(url).then((resp){
      setState(() {
        this.weatherData=json.decode(resp.body);
        print(this.weatherData);
      });
    }).catchError((err){
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    getData(widget.city);
  }
}
