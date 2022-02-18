import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
  static const String routeName = 'Profile Edit screen';
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  var _gender;
  bool isLoading = false;
  File? _storedImage;
  Widget greyContainerBuilder(Widget child) {
    return Container(
      color: Colors.black.withOpacity(.1),
      padding: EdgeInsets.all(5),
      child: child,
    );
  }

  Future<void> _takePicture(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final picker = ImagePicker();

    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      // isLoading = false;
      _storedImage = File(imageFile.path);
    });
    if (_storedImage != null) {
      Provider.of<DBHelper>(context, listen: false).profileImage =
          _storedImage!;
    }

    // final appDir = await getApplicationDocumentsDirectory();

    // final fileName = basename(imageFile.path);

    // final savedImage =
    //     await File(imageFile.path).copy('${appDir.path}/$fileName');
    // setState(() {
    //   isLoading = false;
    // });
    // showDialog(
    //     context: context,
    //     builder: (BuildContext ctx) {
    //       return imageFileInputDialog(savedImage);
    //     });

    // print(DummyLists.oldPrescImages.toString());
  }

  @override
  Widget build(BuildContext context) {
    File? profileImage = Provider.of<DBHelper>(context).getProfileImage();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: profileImage == null
                        ? AssetImage('assets/avatar.png') as ImageProvider
                        : FileImage(profileImage),
                  ),
                  CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            _takePicture(context);
                          },
                          icon: Icon(Icons.edit))),
                ],
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
