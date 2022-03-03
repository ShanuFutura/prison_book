// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class PrisonerViewSliverAppbar extends StatelessWidget {
  final Map dataMap;
  PrisonerViewSliverAppbar(this.dataMap);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                Provider.of<DBHelper>(context).urlS +
                    'images/' +
                    dataMap['photo'],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Chip(label: Text(dataMap['prisoner_name'])),
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text('age'),
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text('gender'),
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Chip(label: Text('cell no: ' + dataMap['cell_no'])),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
