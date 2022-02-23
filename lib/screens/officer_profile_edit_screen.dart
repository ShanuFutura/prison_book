import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prisonbook/models/db_helper.dart';
import 'package:provider/provider.dart';

class OfficerProfileEditScreen extends StatefulWidget {
  const OfficerProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<OfficerProfileEditScreen> createState() =>
      _OfficerProfileEditScreenState();
  static const String routeName = 'Officer Profile Edit screen';
}

class _OfficerProfileEditScreenState extends State<OfficerProfileEditScreen> {
  var _gender = '';
  var position;
  var state;
  final formKey = GlobalKey<FormState>();

  File? _storedImage;

  Future<void> _takePicture(BuildContext context) async {
    // setState(() {
    //   isLoading = true;
    // });
    final picker = ImagePicker();

    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      // setState(() {
      //   isLoading = false;
      // });
      return;
    }
    setState(() {
      // isLoading = false;
      _storedImage = File(imageFile.path);
    });
    if (_storedImage != null) {
      Provider.of<DBHelper>(context, listen: false).officerProfileImage =
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

  Widget greyContainerBuilder(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black.withOpacity(.1),
        ),
        padding: EdgeInsets.all(5),
        child: child,
      ),
    );
  }

  trySubmit() {
    formKey.currentState!.validate();
    if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    File? profileImage =
        Provider.of<DBHelper>(context).getOfficerProfileImage();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.done),
      ),
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage) as ImageProvider
                          : AssetImage(
                              'assets/avatar.png',
                            ),
                    ),
                    GestureDetector(
                        onTap: () {
                          _takePicture(context);
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.edit),
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                greyContainerBuilder(
                  TextFormField(
                    decoration: InputDecoration(label: Text('name')),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "name cannot be empty";
                      }
                    },
                  ),
                ),
                greyContainerBuilder(
                  TextFormField(
                    decoration: InputDecoration(label: Text('address')),
                    maxLines: 5,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "address cannot be empty";
                      }
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
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "age cannot be empty";
                          } else if (int.parse(v) > 120 || int.parse(v) < 0) {
                            return 'enter a valid age';
                          }
                        },
                        decoration: InputDecoration(label: Text('age')),
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(.1),
                      padding: EdgeInsets.all(5),
                      child: DropdownButton(
                          hint: Text(_gender == '' ? 'gender' : _gender),
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
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "number cannot be empty";
                      } else if (v.length != 10) {
                        return 'enter a valid phone number';
                      }
                    },
                  ),
                ),
                greyContainerBuilder(
                  TextFormField(
                    decoration: InputDecoration(label: Text('email')),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'email cannot be empty';
                      } else if (!v.contains('@') ||
                          !v.contains('.') ||
                          v.contains(' ')) {
                        return 'email is badly formated';
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Colors.black.withOpacity(.1),
                      padding: EdgeInsets.all(5),
                      child: DropdownButton(
                          hint: Text(position == null ? 'position' : position),
                          items: const [
                            DropdownMenuItem(
                              child: Text('position 1'),
                              value: 'position 1',
                            ),
                            DropdownMenuItem(
                              child: Text('position 2'),
                              value: 'position 2',
                            )
                          ],
                          onChanged: (val) {
                            setState(() {
                              position = val.toString();
                            });
                          }),
                    ),
                    Container(
                      color: Colors.black.withOpacity(.1),
                      padding: EdgeInsets.all(5),
                      child: DropdownButton(
                          hint: Text(state == null ? 'state' : state),
                          items: const [
                            DropdownMenuItem(
                              child: Text('kerala'),
                              value: 'kerala',
                            ),
                            DropdownMenuItem(
                              child: Text('tamilnadu'),
                              value: 'tamilnadu',
                            )
                          ],
                          onChanged: (val) {
                            setState(() {
                              state = val.toString();
                            });
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
