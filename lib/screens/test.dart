import 'package:http/http.dart';

validate() async{
  final res =await post(
    Uri.parse('url'),
    body: {'email': 'name@name.name', 'passw': 'pass'},
  );
  print(res.statusCode);
}
