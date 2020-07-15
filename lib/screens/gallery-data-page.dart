import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryDataPage extends StatefulWidget {
  String keyword;

  GalleryDataPage(this.keyword);

  @override
  _GalleryDataPageState createState() => _GalleryDataPageState();
}

class _GalleryDataPageState extends State<GalleryDataPage> {
  int currentPage = 1;
  int size = 10;
  List<dynamic> hits=List<dynamic>();
  var galleryData;
  int totalPages;
  ScrollController _scrollController=new ScrollController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        if(currentPage<totalPages){
          ++currentPage;
          this.getData();
        }
      }
    });
    this.getData();
  }



  getData() {
    String url =
        "https://pixabay.com/api/?key=17345484-08864c182fe54556bb9a2ce55&q=${widget.keyword}&page=${currentPage}&per_page=${size}";
    http.get(url).then((resp) {
      setState(() {
        galleryData = json.decode((resp.body));
        hits.addAll( galleryData["hits"]);
        if(galleryData['totalHits']%size==0)
          totalPages=galleryData['totalHits']~/size;
        else
          totalPages=1+(galleryData['totalHits']/size).floor();

      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.keyword}, Page ${currentPage}/${totalPages}"),
          backgroundColor: Colors.deepOrange,
        ),
        body: (galleryData == null
            ? Container(color: Colors.brown[100],
            child: Center(child: CircularProgressIndicator()))
            : Container(color: Colors.brown[100],
              child: ListView.builder(
                  itemCount: (galleryData == null ? 0 : hits.length),
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          width:double.infinity,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  hits[index]['tags'],
                                  style: TextStyle(fontSize: 22, color: Colors.white,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            color: Colors.deepOrange,
                          ),
                        ),
                        Container(
                          child: Card(
                            child: Image.network(hits[index]['webformatURL'],fit: BoxFit.fitWidth,),
                          ),
                          padding: EdgeInsets.only(left:10,bottom:10),
                        ),

                      ],
                    );
                  }),
            )));
  }
}
