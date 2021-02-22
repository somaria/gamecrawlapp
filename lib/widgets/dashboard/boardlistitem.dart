import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/post.dart';

class BoardListItem extends StatelessWidget {
  const BoardListItem({
    Key key,
    @required this.context,
    @required this.data,
  }) : super(key: key);

  final BuildContext context;
  final DocumentSnapshot data;

  void deletePost(pid) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(pid)
        .delete()
        .then((value) {
      print("delete successful");
      Fluttertoast.showToast(
          msg: "Gameplay deleted successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.green.shade50,
          textColor: Colors.black,
          fontSize: 24.0);
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    final post = Post.fromSnapshot(data);

    return Padding(
      key: ValueKey(post.username),
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
          ),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              post.ytImageUrl,
              width: 80,
            ),
          ),
          title: Text(post.ytTitle),
          subtitle: Text("Votes: " + post.noOfVotes.toString()),
          trailing: GestureDetector(
            onDoubleTap: () {
              print("tapping");
              print(post.pid);
              deletePost(post.pid);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.grey,
              semanticLabel: 'Double tap to delete',
            ),
          ),
        ),
      ),
    );
  }
}
