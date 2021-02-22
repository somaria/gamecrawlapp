import 'package:dio/dio.dart' as dio;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/home/sidedrawer.dart';
import '../pages/login.dart';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:youtube_parser/youtube_parser.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

// Define a custom Form widget.

class Post {
  final String kind;
  final Map<String, dynamic> items;
  Post({this.kind, this.items});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(kind: json['kind'], items: json['items']);
  }
}

// class Item {
//   final String kind;
//   Item({this.kind});
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(kind: json['items']['kind']);
//   }
// }

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var username = "";
  var photourl = "";
  var uid = "";

  void getUsername(uid) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where("uid", isEqualTo: uid)
        .limit(1)
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 1) {
      print("username jfjfjf");
      print(documents[0]['username']);
      username = documents[0]['username'];
    }
  }

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
        uid = _auth.currentUser.uid;
        photourl = _auth.currentUser.photoURL;

        getUsername(uid);
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

  getFromYoutube(ytid) async {
    var url =
        'https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=${ytid}&key=AIzaSyAj0013WhXawuuJhfo3IcJ2GZposL3ubzU';
    var response = await http.get(url);

    print(response.body);

    //below code works too
    // final parsed = convert.jsonDecode(response.body);
    // for (int i = 0; i < parsed["items"].length; i++) {
    //   print(parsed["items"][i]["snippet"]["title"]);
    // }

    final myData = convert.jsonDecode(response.body);
    // print(myData);
    var title =
        (((myData['items'] as List).first as Map)['snippet'] as Map)['title'];
    print(title);

    var description = (((myData['items'] as List).first as Map)['snippet']
        as Map)['description'];
    print(description);

    var channelTitle = (((myData['items'] as List).first as Map)['snippet']
        as Map)['channelTitle'];
    print(channelTitle);

    var channelId = (((myData['items'] as List).first as Map)['snippet']
        as Map)['channelId'];
    print(channelId);

    var publishedAt = (((myData['items'] as List).first as Map)['snippet']
        as Map)['publishedAt'];
    print(publishedAt);

    var mediumUrl = (((((myData['items'] as List).first as Map)['snippet']
        as Map)['thumbnails'] as Map)['medium'] as Map)['url'];
    print(mediumUrl);

    var tags =
        (((myData['items'] as List).first as Map)['snippet'] as Map)['tags'];
    print(tags);

    var tag2 =
        (((myData['items'] as List)[0] as Map)['snippet'] as Map)['tags'];
    print(tag2);

    print(myData['kind']);

    final postId = FirebaseFirestore.instance.collection("posts").doc().id;

    FirebaseFirestore.instance.collection("posts").doc(postId).set({
      "ytTitle": title,
      "ytid": ytid,
      "ytDescription": description,
      "ytpublishedAt": publishedAt,
      "ytImageUrl": mediumUrl,
      "ytTags": tags,
      "ytChannelTitle": channelTitle,
      "ytChannelId": channelId,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "username": username,
      "photourl": photourl,
      "pid": postId,
      "uid": uid,
      "noOfVotes": 0
    }).then((value) {
      print("successfully posted the video");
      setState(() {});
      Fluttertoast.showToast(
          msg: "This gameplay has been posted successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.green.shade50,
          textColor: Colors.black,
          fontSize: 24.0);
    }).catchError((error) => print("Failed to add post: $error"));
  }

  @override
  Widget build(BuildContext context) {
    getYoutubeId() async {
      print(textController.text);
      final yturl = textController.text;

      String ytid = getIdFromUrl(yturl);

      print(ytid);

      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('posts')
          .where("ytid", isEqualTo: ytid)
          .limit(1)
          .get();

      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 1) {
        print("doc is found");
        // getFromYoutube("8DRbRRmck04");
        Fluttertoast.showToast(
            msg: "This video has already been posted",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.red.shade50,
            textColor: Colors.black,
            fontSize: 24.0);
      } else {
        //not found
        print("doc not found");
        getFromYoutube(ytid);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'https://www.youtube.com/watch?v=2SSx8O2grNg'),
              controller: textController,
            ),
            SizedBox(
              height: 28,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(12.0),
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
}
