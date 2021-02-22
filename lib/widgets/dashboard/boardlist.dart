import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../dashboard/boardlistitem.dart';

class BoardList extends StatelessWidget {
  const BoardList({
    Key key,
    @required this.context,
    @required this.snapshot,
  }) : super(key: key);

  final BuildContext context;
  final List<DocumentSnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 20.0),
        children: snapshot
            .map((data) => BoardListItem(context: context, data: data))
            .toList(),
      ),
    );
  }
}
