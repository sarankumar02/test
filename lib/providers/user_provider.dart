import 'package:flutter/material.dart';
import 'package:sample/models/usermodel.dart';
// import 'package:http/http.dart' as http;
// import 'package:sample/constants.dart';

class BookMarkedUsers extends ChangeNotifier {
  bool isEditPressed = false;
  //
  List<User> bookMarkedUsers = List<User>();
  List<User> _allUsers = [];
  //
  // List<User> get bookMarked => _bookMarkedUsers;
  List<User> get allUser => _allUsers;

  // Future getAllUsers() async {
  //   try {
  //     var response = await http.get(apiUrl);
  //     _allUsers = userFromJson(response.body);
  //   } catch (e) {
  //     _allUsers = [];
  //     print(e.toString());
  //   }
  //   return _allUsers;
  // }

  // Future getBookMarkedUsers() async {
  //   return _bookMarkedUsers;
  // }

//
  void setAllUsers(users) {
    _allUsers = users;
    notifyListeners();
  }

  void bookMarkUsers(user) {
    bookMarkedUsers.add(user);
    notifyListeners();
  }

  void removeBookMarkUsers(user) {
    bookMarkedUsers.remove(user);
    notifyListeners();
  }

//
  void onEditPress(value) {
    isEditPressed = value;
    notifyListeners();
  }
}
