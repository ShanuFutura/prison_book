import 'package:flutter/material.dart';
import 'package:prisonbook/screens/profile_edit_screen.dart';

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
                  Stack(alignment: Alignment.bottomRight, children: [
                    const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                        'assets/avatar.png',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(ProfileEditScreen.routeName),
                      child: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
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
