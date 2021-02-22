import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/home/sidedrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/dashboard.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);

  if (authResult.additionalUserInfo.isNewUser) {
    final db = FirebaseFirestore.instance;
    final data = authResult;
    db.collection("users").doc(authResult.user.uid).set({
      'email': data.user.email,
      'name': data.user.displayName,
      'photourl': data.user.photoURL,
      'uid': data.user.uid,
      'username': data.user.uid,
      'ytchannelurl': "https://youtube.com/c/gamecrawl",
      'twitter': "https://twitter.com/xgamecrawl",
      'facebook': "https://facebook.com/gamecrawl",
      'twitch': "https://twitch.tv/gamecrawlx",
      'instagram': "https://instagram.com/gamecrawl/",
      'bio': "A gamer",
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'votes': []
    });
  }

  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    final uid = user.uid;

    print('signInWithGoogle succeeded: $user');
    Get.offAll(Dashboard());

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Get.offAll(Dashboard());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 120,
          ),
          Center(
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  side: BorderSide(color: Colors.red)),
              color: Colors.red.shade300,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(18.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                signInWithGoogle();
              },
              child: Text(
                "Sign In With Google",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
