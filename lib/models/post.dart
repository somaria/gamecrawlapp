import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Post {
  final String username;
  final String ytTitle;
  final int noOfVotes;
  final String ytImageUrl;
  final String pid;
  final String ytid;
  final String ytDescription;
  final String ytChannelTitle;
  final DocumentReference reference;

  Post.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['username'] != null),
        username = map['username'],
        ytTitle = map['ytTitle'],
        ytImageUrl = map['ytImageUrl'],
        noOfVotes = map['noOfVotes'],
        pid = map['pid'],
        ytDescription = map['ytDescription'],
        ytChannelTitle = map['ytChannelTitle'],
        ytid = map['ytid'];

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Post<$username:$noOfVotes>";
}
