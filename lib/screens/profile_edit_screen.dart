import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
  static const String routeName = 'Profile Edit screen';
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  var _gender = '';

  Widget greyContainerBuilder(Widget child) {
    return Container(
      color: Colors.black.withOpacity(.1),
      padding: EdgeInsets.all(5),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  'assets/avatar.png',
                ),
              ),
              greyContainerBuilder(
                TextFormField(
                  decoration: InputDecoration(label: Text('name')),
                ),
              ),
              greyContainerBuilder(
                TextFormField(
                    decoration: InputDecoration(label: Text('address')),
                    maxLines: 5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 70,
                    color: Colors.black.withOpacity(.1),
                    padding: EdgeInsets.all(5),
                    child: TextFormField(
                      decoration: InputDecoration(label: Text('age')),
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(.1),
                    padding: EdgeInsets.all(5),
                    child: DropdownButton(
                        hint: Text(_gender == null ? 'gender' : _gender),
                        items: const [
                          DropdownMenuItem(
                            child: Text('male'),
                            value: 'male',
                          ),
                          DropdownMenuItem(
                            child: Text('female'),
                            value: 'female',
                          )
                        ],
                        onChanged: (val) {
                          setState(() {
                            _gender = val.toString();
                          });
                        }),
                  ),
                ],
              ),
              greyContainerBuilder(
                TextFormField(
                  decoration: InputDecoration(label: Text('phone')),
                ),
              ),
              greyContainerBuilder(
                TextFormField(
                  decoration: InputDecoration(label: Text('email')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
