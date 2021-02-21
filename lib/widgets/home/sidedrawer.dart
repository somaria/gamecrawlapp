import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/login.dart';
import '../../home.dart';
import '../../pages/dashboard.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key key,
  }) : super(key: key);

  Future<void> signOutGoogle() async {
    _auth.signOut();
    // await googleSignIn.signOut();
    print("User Signed Out");
    Get.offAll(() => Home());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Gamecrawl'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Get.offAll(() => Home());
            },
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Get.offAll(() => Dashboard());
            },
          ),
          ListTile(
            title: Text('Login'),
            onTap: () {
              Get.offAll(() => Login());
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              signOutGoogle();
            },
          ),
        ],
      ),
    );
  }
}
