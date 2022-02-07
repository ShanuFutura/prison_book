import 'package:flutter/material.dart';
import 'package:prisonbook/screens/home_page.dart';

main() => runApp(PrisonBook());

class PrisonBook extends StatelessWidget {
  const PrisonBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
