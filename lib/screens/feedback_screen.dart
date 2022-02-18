import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class FeedBackScreen extends StatelessWidget {
  FeedBackScreen({Key? key}) : super(key: key);

  static const String routeName = 'feedback screen';

  final feedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              color: Colors.grey.withOpacity(.5),
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: feedController,
                maxLines: 15,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<DBHelper>(context, listen: false)
              .feedBackSend(feedController.text);
          feedController.clear();
          Fluttertoast.showToast(msg: 'feedback sent');
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
