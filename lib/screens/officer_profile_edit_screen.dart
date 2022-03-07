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
  var name;
  var address;
  var age;
  var phone;
  var email;
  // var position;

  final formKey = GlobalKey<FormState>();

  File? _storedImage;

  // Future<void> _takePicture(BuildContext context) async {
  //   // setState(() {
  //   //   isLoading = true;
  //   // });
  //   final picker = ImagePicker();

  //   final imageFile =
  //       await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
  //   if (imageFile == null) {
  //     // setState(() {
  //     //   isLoading = false;
  //     // });
  //     return;
  //   }
  //   setState(() {
  //     // isLoading = false;
  //     _storedImage = File(imageFile.path);
  //   });
  //   if (_storedImage != null) {
  //     Provider.of<DBHelper>(context, listen: false).officerProfileImage =
  //         _storedImage!;
  //   }

  //   // final appDir = await getApplicationDocumentsDirectory();

  //   // final fileName = basename(imageFile.path);

  //   // final savedImage =
  //   //     await File(imageFile.path).copy('${appDir.path}/$fileName');
  //   // setState(() {
  //   //   isLoading = false;
  //   // });
  //   // showDialog(
  //   //     context: context,
  //   //     builder: (BuildContext ctx) {
  //   //       return imageFileInputDialog(savedImage);
  //   //     });

  //   // print(DummyLists.oldPrescImages.toString());
  // }

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
    // formKey.currentState!.validate();
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Provider.of<DBHelper>(context, listen: false)
          .updateOfficerProfile(name, age, address, email, phone);
    }
  }

  @override
  Widget build(BuildContext context) {
     String? profileImage =
        Provider.of<DBHelper>(context).officersDetails==null? null :Provider.of<DBHelper>(context).officersDetails['photo'];
    final dynamic? officerDetails = Provider.of<DBHelper>(context).officersDetails;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: trySubmit,
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
                          ? NetworkImage(Provider.of<DBHelper>(context)
                                  .urlForEMployeeImageFetch +
                              'assets/images/' +
                              profileImage) as ImageProvider
                          : AssetImage(
                              'assets/avatar.png',
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                greyContainerBuilder(
                  TextFormField(
                    initialValue: officerDetails['officer_name'],
                    decoration: InputDecoration(label: Text('name')),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "name cannot be empty";
                      }
                    },
                    onSaved: (v) {
                      name = v;
                    },
                  ),
                ),
                greyContainerBuilder(
                  TextFormField(
                    initialValue: officerDetails['address'],
                    decoration: InputDecoration(label: Text('address')),
                    maxLines: 5,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "address cannot be empty";
                      }
                    },
                    onSaved: (v) {
                      address = v;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        color: Colors.black.withOpacity(.1),
                        padding: EdgeInsets.all(5),
                        child: TextFormField(
                          initialValue: officerDetails['age'],
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "age cannot be empty";
                            } else if (int.parse(v) > 120 || int.parse(v) < 0) {
                              return 'enter a valid age';
                            }
                          },
                          onSaved: (v) {
                            age = int.parse(v!);
                          },
                          decoration: InputDecoration(label: Text('age')),
                        ),
                      ),
                    ],
                  ),
                ),
                greyContainerBuilder(
                  TextFormField(
                    initialValue: officerDetails['officer_name'],
                    decoration: InputDecoration(label: Text('phone')),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "number cannot be empty";
                      } else if (v.length != 10) {
                        return 'enter a valid phone number';
                      }
                    },
                    onSaved: (v) {
                      phone = v;
                    },
                  ),
                ),
                greyContainerBuilder(
                  TextFormField(
                    initialValue: officerDetails['email_id'],
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
