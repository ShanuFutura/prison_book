import 'package:flutter/material.dart';

class EmployeeDrawer extends StatelessWidget {
  const EmployeeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.indigo, Colors.white])),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                  ),
                  Text('User Name')
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('View Employees'),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.reorder)),
          ),
          ListTile(
            title: Text('feedback'),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
          ),
        ],
      ),
    );
  }
}
