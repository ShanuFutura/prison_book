import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class FeedBackScreen extends StatefulWidget {
  FeedBackScreen({Key? key}) : super(key: key);

  static const String routeName = 'feedback screen';

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final feedController = TextEditingController();

  var isLoading = false;

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
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          final isSent = await Provider.of<DBHelper>(context, listen: false)
              .feedBackSend(feedController.text);
          setState(() {
            isLoading = false;
          });
          if (isSent) {
            Fluttertoast.showToast(msg: 'feedback sent');
            feedController.clear();
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Couldn\'t send feedback'),
                  );
                });
          }

          // feedController.clear();
        },
        child: isLoading ? CircularProgressIndicator() : Icon(Icons.send),
      ),
    );
  }
}
