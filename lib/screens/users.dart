import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import "package:sample/models/capitalize.dart";
import 'package:sample/models/database_helper.dart';
import 'package:sample/models/db_crud.dart';
import 'package:sample/models/usermodel.dart';
import 'package:sample/providers/user_provider.dart';
import 'package:sample/screens/homescreen.dart';
import 'package:sample/services/get_users.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<BookMarkedUsers>(context, listen: false).bookMarkedUsers = [];
    tempList = [];
  }

  @override
  Widget build(BuildContext context) {
    BookMarkedUsers providerData = Provider.of<BookMarkedUsers>(context);
    return Container(
        child: FutureBuilder(
            future: getAllUsers(context),
            builder: (context, projectSnap) {
              if (projectSnap.hasData) {
                return ListView.builder(
                  itemCount: projectSnap.data.length,
                  itemBuilder: (context, index) {
                    return UserBox(userData: projectSnap.data[index]);

                    //
                    //
                    // Container(
                    //   padding: EdgeInsets.only(top: 4, bottom: 8),
                    //   height: 70,
                    //   child: ListTile(
                    //       leading: CircleAvatar(
                    //         radius: 28,
                    //         backgroundImage: NetworkImage(
                    //             '${projectSnap.data[index].avatarUrl}'),
                    //       ),
                    //       title:
                    //           Text(capitalize(projectSnap.data[index].login)),
                    //       onLongPress: () {
                    //         providerData
                    //             .onLongPress(!providerData.isLongPressed);
                    //         print(providerData.isLongPressed);
                    //       },
                    //       trailing: providerData.isLongPressed
                    //           ? Checkbox(
                    //               value: true,
                    //               onChanged: (e) {
                    //                 print(e);
                    //               })
                    //           : Container(height: 1, width: 1)),
                    // );
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  // void _update() async {
  //   // row to update
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId: 1,
  //     DatabaseHelper.columnName: 'Mary',
  //     DatabaseHelper.columnImage: 32
  //   };
  //   final rowsAffected = await dbHelper.update(row);
  //   print('updated $rowsAffected row(s)');
  // }

}

class UserBox extends StatefulWidget {
  final userData;
  UserBox({this.userData});
  @override
  _UserBoxState createState() => _UserBoxState();
}

class _UserBoxState extends State<UserBox> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 8),
      height: 70,
      child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage('${widget.userData.avatarUrl}'),
          ),
          title: Text(capitalize(widget.userData.login)),
          trailing: Checkbox(
              value: selected,
              onChanged: (e) {
                selected = e;
                print(selected);
                setState(() {});
                if (selected) {
                  tempList.add(widget.userData);
                } else {
                  tempList.remove(widget.userData);
                }
                print(tempList);
              })
          // : Container(height: 1, width: 1)
          ),
    );
  }
}
