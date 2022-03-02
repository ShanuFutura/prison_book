import 'package:flutter/material.dart';

class Tets extends StatelessWidget {
  const Tets({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      var x=[234,345,67,77];
    return Column(
children:

            x.map((e) => Text(e.toString())).toList()
      
    );
  }
}