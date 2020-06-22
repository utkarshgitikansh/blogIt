import 'package:blogit/Model/blog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';


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
            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF051E3E)),
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
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
//                  decoration: BoxDecoration(
//                      border: Border.all(color: Colors.blue)
//                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(item[index]["title"],
                                  style: TextStyle(
                                  color: Color(0xFF051E3E),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                          ),),
                    ),
                  ),
                      SizedBox(height: 20,),
                    Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color:  Color(0xFF9AC3F7),
                        elevation: 18.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(  //item[index]['content'].toString().replaceAll('&nbsp;', ''),
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new HtmlTextView(data: item[index]['content'].toString().replaceAll('&nbsp;', ''), ),
//                           ListTile(
//                            title: Text(item[index]["title"],
//                              style: TextStyle(
//                              color: Colors.blue,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 18
//                      ),),
//                            subtitle: Text("\n\n" + "( Published on : " + item[index]["published"].toString().substring(0,10) + " )\n\n" + item[index]["content"].toString().replaceAll('<div style="text-align: center;">', '<br />\n<br />').replaceAll('</blockquote></blockquote>', '\n').replaceAll('</blockquote>', '<br /> <br />').replaceAll('.<br />', '<br />\n<br>\n<br>').replaceAll('</blockquote>\n<br />', '<br /> \n <br />').replaceAll('<br />\n<br />', '\n').replaceAll('</blockquote>', '').replaceAll('<br />\n<br />\n<br />', '<br />').replaceAll('<br />', '\n').replaceAll('\n\n', '').replaceAll(exp, '').replaceAll('[^\d]+ ', '').replaceAll('&nbsp;', '').replaceAll('\n\n', '\n\n\n').replaceAll('\n\n\n\n', '\n\n'),
////                              subtitle: Text(parse(parse(item[index]['content'].toString().replaceAll('<blockquote>', '\n')).body.text).documentElement.text,
//                                style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.bold
//                                )),
////                           subtitle: Text(parsedString,
////                             style: TextStyle(
////                                 color: Colors.white,
////                             ),)
//                          ),
                            ],
                          ),
                        ),
                      ),
                    ),
                      SizedBox(height: 20,),
                      Divider(color: Color(0xFF051E3E)),
            ],
                  ),
                );
//                    ),
          }
      );
  
//  Text('yo');
  }

}