import 'dart:ui';

import 'package:blogit/Model/blog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html/parser.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';

class Blog2 extends StatefulWidget {
  @override
  _Blog2State createState() => _Blog2State();
}

class _Blog2State extends State<Blog2> {

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
    try {
      var response = await http.get(
          'http://updateitt.herokuapp.com/blog2');


      if (response.statusCode == 200) {


        maps = json.decode(response.body) as Map;

        setState(() {
          list = maps["items"] as List;
          load = true;
        });



      } else {
        throw Exception('Failed to load album');
      }
    } catch (err) {
      print('Caught error: $err');
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

            String parsedString = parse(document.body.text).documentElement.text; //

            return  Container(
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
                            new HtmlTextView(data: item[index]['content'].toString().replaceAll('\n<br />\n', '').replaceAll('\n<br />', '').replaceAll('\n\n', '').replaceAll('&nbsp;', ''),)
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
