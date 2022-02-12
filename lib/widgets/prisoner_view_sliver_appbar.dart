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
            children: const [
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text('name'),
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
                child: Text('num'),
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text('cell'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
