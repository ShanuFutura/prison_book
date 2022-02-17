import 'package:flutter/material.dart';

class ParolList extends StatelessWidget {
  const ParolList({Key? key}) : super(key: key);

  static const String routeName = 'parol list screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming parols'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Prisoner name'),
                  subtitle: Text('parol date'),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
