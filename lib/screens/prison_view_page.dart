import 'package:flutter/material.dart';

class PrisonViewpage extends StatelessWidget {
  const PrisonViewpage({Key? key}) : super(key: key);

  static const String routeName = 'prisoner view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prison_Name'),
      ),
      body: Container(),
    );
  }
}
