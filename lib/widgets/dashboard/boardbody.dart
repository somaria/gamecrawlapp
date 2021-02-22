import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../dashboard/boardlist.dart';

class BoardBody extends StatefulWidget {
  String uid;
  BoardBody({
    @required this.uid,
  });

  @override
  _BoardBodyState createState() => _BoardBodyState();
}

class _BoardBodyState extends State<BoardBody> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String currentUserId = "";
  getUserId() {
    setState(() {
      currentUserId = _auth.currentUser.uid;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserId();
    super.initState();
    print("user id");
    print(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where("uid", isEqualTo: currentUserId)
          .orderBy("createdAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        print("widget id");
        print(widget.uid);
        if (!snapshot.hasData) return LinearProgressIndicator();

        return BoardList(context: context, snapshot: snapshot.data.docs);
      },
    );
  }
}
