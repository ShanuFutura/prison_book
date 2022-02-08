import 'package:flutter/material.dart';

class OfficersListScreen extends StatelessWidget {
  const OfficersListScreen({Key? key}) : super(key: key);

  static const String routeName = 'officers list screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('title'),
                  subtitle: Text('subtitle'),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
