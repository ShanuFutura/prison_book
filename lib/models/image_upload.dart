import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class ImageUpload {
  static Future<bool> upload({
    required File imageFile,
    required Uri url,
    required String name,
    required String crime,
    required DateTime entryDate,
    required DateTime releaseDate,
    required String age,
    required String address,
    required String cellNo,
    required String gender,
    required String section,
  }) async {
    var ret = false;
    print(
      'name:' +
          name +
          ''',imageFile:''' +
          imageFile.toString() +
          ''',crime:''' +
          crime +
          ',entryDate:' +
          entryDate.toString() +
          ',release:' +
          releaseDate.toString() +
          ',age:' +
          age +
          ',address:' +
          address +
          ',cellno:' +
          cellNo +
          ',gender:' +
          gender +
          ''', section:''' +
          section,
    );
    var stream = new ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = url;

    var request = MultipartRequest("POST", uri);
    var multipartFile =
        MultipartFile('f1', stream, length, filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.fields['prisoner_name'] = name;
    request.fields['crime'] = crime;
    request.fields['entry_date'] = DateFormat('dd/mm/yyyy').format(entryDate);
    request.fields['releasing_date'] =
        DateFormat('dd/mm/yyyy').format(releaseDate);
    request.fields['age'] = age;
    request.fields['address'] = address;
    request.fields['cell_no'] = cellNo;
    request.fields['gender'] = gender;
    request.fields['section_no'] = section;
    // request.fields = {'string': 'string'};

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(jsonDecode(value)['message']);
      if (jsonDecode(value)['message'] == 'Successfully added') {
        ret = true;
      } else
        ret = false;
    });
    return ret;
  }
}
