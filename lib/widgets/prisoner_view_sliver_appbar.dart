// import 'dart:html';

import 'package:flutter/material.dart';

class PrisonerViewSliverAppbar extends StatelessWidget {
  const PrisonerViewSliverAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
            child: const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                'assets/avatar.png',
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('name'),
              Text('age'),
              Text('gender'),
              Text('num'),
              Text('cell'),
            ],
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('health stat'),
            ),
          )
        ],
      ),
    );
  }
}