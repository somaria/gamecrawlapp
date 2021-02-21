import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gamecrawl',
      home: Home(),
    );
  }
}
