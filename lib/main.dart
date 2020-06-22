import 'package:blogit/Model/blog1.dart';
import 'package:blogit/Model/blog2.dart';
import 'package:flutter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin{

  TabController controller;

  String value;
  List docs = [0,1];
  // final DBRef = Firestore.instance.collection('items');


  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xFF9AC3F7),
      appBar: AppBar(
        title: new TabBar(
          labelColor: Color(0xFF9AC3F7),
          indicatorColor: Color(0xFF9AC3F7),
          controller: controller,
          tabs: <Widget>[
            new Tab(icon: new Icon(Icons.beach_access)),
            new Tab(icon: new Icon(Icons.laptop)),
          ],
        ),
//        title: Text('BlogIt'),
        centerTitle: true,
        backgroundColor: Color(0xFF051E3E),

      ),

      body:
      new TabBarView(
        controller: controller,
        children: <Widget>[

          Blog1(),

          Blog2(),

        ],
      ),

    );
  }

}


