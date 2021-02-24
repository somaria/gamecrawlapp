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
            child: Row(
              children: [
                Icon(
                  Icons.videogame_asset_outlined,
                  color: Colors.white70,
                  semanticLabel: 'Double tap to delete',
                  size: 32,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  'Gamecrawl',
                  style: TextStyle(fontSize: 32, color: Colors.white70),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.home,
                  color: Colors.blueGrey,
                  semanticLabel: 'Double tap to delete',
                  size: 24,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  'Home',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
            onTap: () {
              Get.offAll(() => Home());
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.settings_applications,
                  color: Colors.blueGrey,
                  semanticLabel: 'Double tap to delete',
                  size: 24,
                ),
                SizedBox(
                  width: 2,
                ),
                Text('Dashboard', style: TextStyle(fontSize: 20)),
              ],
            ),
            onTap: () {
              Get.offAll(() => Dashboard());
            },
          ),
          ListTile(
            title: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.login_outlined,
                      color: Colors.blueGrey,
                      semanticLabel: 'Double tap to delete',
                      size: 24,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text('Login',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.5))),
                  ],
                ),
              ],
            ),
            onTap: () {
              Get.offAll(() => Login());
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.login_outlined,
                  color: Colors.blueGrey,
                  semanticLabel: 'Double tap to delete',
                  size: 24,
                ),
                SizedBox(
                  width: 2,
                ),
                Text('Logout',
                    style: TextStyle(
                        fontSize: 20, color: Colors.black.withOpacity(0.5))),
              ],
            ),
            onTap: () {
              signOutGoogle();
            },
          ),
        ],
      ),
    );
  }
}
