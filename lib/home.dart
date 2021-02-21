import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './widgets/home/buildbody.dart';
import './widgets/home/sidedrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final databaseReference = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gamecrawl')),
      drawer: SideDrawer(),
      body: BuildBody(context: context),
    );
  }
}
