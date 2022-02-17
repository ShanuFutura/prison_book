import 'package:flutter/material.dart';

class MaliciousActivityListScreen extends StatelessWidget {
  const MaliciousActivityListScreen({Key? key}) : super(key: key);

  static const String routeName = 'Malicious act list screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Malicious Activities'),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(),
                  title: Text('Prisoner name'),
                  subtitle: Text('activity'),
                ),
                Divider()
              ],
            );
          }),
    );
  }
}
