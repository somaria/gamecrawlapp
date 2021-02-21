import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/home/sidedrawer.dart';
import '../pages/login.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: Dashboard(),
    );
  }
}

// Define a custom Form widget.
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        Get.offAll(Login());
      } else {
        print('User is signed in!');
      }
    });
  }

  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'https://www.youtube.com/watch?v=2SSx8O2grNg'),
              controller: textController,
            ),
            SizedBox(
              height: 16,
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                getYoutubeId();
              },
              child: Text(
                "Submit A Video",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getYoutubeId() {
    print(textController.text);
    final yturl = textController.text;
  }
}
