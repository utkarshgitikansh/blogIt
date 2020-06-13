import 'package:blogit/Model/blog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart';


class Blog1 extends StatefulWidget {

  @override
  _Blog1State createState() => _Blog1State();


}

class _Blog1State extends State<Blog1> {


  Future<Blog> futureBlog;
  Map maps = Map().cast<String, dynamic>();
  List list = [];
  bool load = false;

  @override
  void initState() {
    super.initState();
    futureBlog = fetchBlog();
  }


  Future<Blog> fetchBlog() async {
    final response = await http.get(
        'http://updateitt.herokuapp.com/blog1');


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      maps = json.decode(response.body) as Map;

      setState(() {
        list = maps["items"] as List;
        load = true;
      });


      //print(map["items"].length);
      // return Blog.fromJson(json.decode(response.body));

    } else {
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {

      RegExp exp = RegExp(
          r"<[^>]*>+",
          multiLine: true,
          caseSensitive: true
      );


      if(load == false)
        return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFD7358)),
          ),

        );

    return


      ListView.builder(

          itemCount: list.length,
          itemBuilder: (context, index) {

            final item = list;



              var document = parse(item[index]["content"]);

              String parsedString = parse(document.body.text).documentElement.text;

                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white)
                  ),
                  child: Center(
                    child: Card(
                      color: Colors.black,
                      elevation: 18.0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                           ListTile(
                            title: Text(item[index]["title"],
                              style: TextStyle(
                              color: Color(0xFFFD7358),
                                  fontWeight: FontWeight.bold
                      ),),
                            subtitle: Text(item[index]["content"].toString().replaceAll('<blockquote>', '\n').replaceAll('</blockquote>', '').replaceAll('<br />\n<br />', '<br />').replaceAll('<br />\n<br />\n<br />', '<br />').replaceAll('<br />', '\n').replaceAll(exp, '').replaceAll('[^\d]+ ', '').replaceAll('&nbsp;', ''),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )),
//                           subtitle: Text(parsedString,
//                             style: TextStyle(
//                                 color: Colors.white,
//                             ),)
                          ),
                        ],
                      ),
                    ),
                  ),
                );
//                    ),
          }
      );
  
//  Text('yo');
  }

}