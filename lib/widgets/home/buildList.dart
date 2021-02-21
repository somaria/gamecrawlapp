import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'buildListItem.dart';

class BuildList extends StatelessWidget {
  const BuildList({
    Key key,
    @required this.context,
    @required this.snapshot,
  }) : super(key: key);

  final BuildContext context;
  final List<DocumentSnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot
          .map((data) => BuildListItem(context: context, data: data))
          .toList(),
    );
  }
}
