import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sample/constants.dart';
import 'package:sample/models/usermodel.dart';
import 'package:sample/providers/user_provider.dart';

Future getAllUsers(context) async {
  List<User> list;
  try {
    var response = await http.get(apiUrl);
    list = userFromJson(response.body);
    // Provider.of<BookMarkedUsers>(context).setAllUsers(list);
  } catch (e) {
    list = [];
    print(e.toString());
  }
  return list;
}
