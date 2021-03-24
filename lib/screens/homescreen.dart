import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/models/db_crud.dart';
import 'package:sample/models/usermodel.dart';
import 'package:sample/providers/user_provider.dart';
import 'package:sample/screens/bookmarked_users.dart';
import 'package:sample/screens/users.dart';

List<User> tempList = List<User>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _homeKey,
        appBar: AppBar(
          actions: [
            Row(children: [
              Text('Bookmark'),
              IconButton(
                  icon: Icon(Icons.mark_chat_read),
                  onPressed: () {
                    List selectedUsers = tempList;

                    if (selectedUsers.length > 0) {
                      selectedUsers.forEach((user) {
                        insert(name: user.login, image: user.avatarUrl);
                      });
                      SnackBar snackBar = SnackBar(
                        content: Text("Users Bookmarked Successfully"),
                      );
                      _homeKey.currentState.showSnackBar(snackBar);
                    } else {
                      SnackBar snackBar = SnackBar(
                        content: Text("Select atleast 1 user"),
                      );
                      _homeKey.currentState.showSnackBar(snackBar);
                    }
                  })
            ]),
            Container(width: 30)
          ],
          title: Text('Sample App'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: "Users"),
              Tab(
                  icon: Icon(Icons.select_all_rounded),
                  text: "Bookmarked Users")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Users(),
            BookmarkedUsersScreen(),
          ],
        ),
      ),
    );
  }
}

// class CustomDelegate<T> extends SearchDelegate<T> {
//   List<User> data;

//   @override
//   List<Widget> buildActions(BuildContext context) =>
//       [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

//   @override
//   Widget buildLeading(BuildContext context) => IconButton(
//       icon: Icon(Icons.chevron_left), onPressed: () => close(context, null));

//   @override
//   Widget buildResults(BuildContext context) => Container();

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List listToShow;
//     if (query.isNotEmpty)
//       listToShow =
//           data.where((e) => e.login.contains(query) && e.startsWith(query)).toList();
//     else
//       listToShow = data;

//     return ListView.builder(
//       itemCount: listToShow.length,
//       itemBuilder: (_, i) {
//         return ListTile(
//           title: Text(listToShow[i]),
//           onTap: () => close(context, listToShow[i]),
//         );
//       },
//     );
//   }
// }
