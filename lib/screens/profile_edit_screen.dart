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
  final formKey = GlobalKey<FormState>();
  var name, address, age, gender, phone, email;

  Widget greyContainerBuilder(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Colors.black.withOpacity(.1),
        padding: EdgeInsets.all(5),
        child: child,
      ),
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

  trySubmit(BuildContext context) {
    if (_gender == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Please select gender'),
            );
          });
    }
    formKey.currentState!.validate();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Provider.of<DBHelper>(context, listen: false).employeeProfileEdit(
        name,
        age,
        address,
        _gender,
        phone,
        email,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    File? profileImage = Provider.of<DBHelper>(context).getProfileImage();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          trySubmit(context);
        },
        child: Icon(Icons.done),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
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
                ),
                greyContainerBuilder(
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(label: Text('name')),
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return 'enter a name';
                      } else if (v.trim().length < 3) {
                        return 'enter a valid name';
                      }
                    },
                    onSaved: (v) {
                      name = v;
                    },
                  ),
                ),
                greyContainerBuilder(
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(label: Text('address')),
                    maxLines: 5,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return 'enter addrenss';
                      }
                    },
                    onSaved: (v) {
                      address = v;
                    },
                  ),
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
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.trim().isEmpty) {
                            return 'enter age';
                          } else if (int.parse(v) > 120 || int.parse(v) < 0) {
                            return 'enter valid age';
                          }
                        },
                        onSaved: (v) {
                          age = v;
                        },
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
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return 'enter phone number';
                      } else if (v.trim().length != 10) {
                        return 'enter valid phone number';
                      }
                    },
                    onSaved: (v) {
                      phone = v;
                    },
                    decoration: InputDecoration(
                      label: Text('phone'),
                    ),
                  ),
                ),
                greyContainerBuilder(
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(label: Text('email')),
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return 'enter email address';
                      } else if (!v.contains('@') ||
                          !v.contains('.') ||
                          v.contains(' ')) {
                        return 'email is badly formatted';
                      }
                    },
                    onSaved: (v) {
                      email = v;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
