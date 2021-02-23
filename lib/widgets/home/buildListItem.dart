import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamecrawlapp/pages/details.dart';
import 'package:get/get.dart';
import '../../models/post.dart';

class BuildListItem extends StatelessWidget {
  const BuildListItem({
    Key key,
    @required this.context,
    @required this.data,
  }) : super(key: key);

  final BuildContext context;
  final DocumentSnapshot data;

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
          title: GestureDetector(
            child: Text(post.ytTitle),
            onTap: () {
              Get.to(Details(), arguments: {'post': post});
            },
          ),
          trailing: Text(post.noOfVotes.toString()),
        ),
      ),
    );
  }
}
