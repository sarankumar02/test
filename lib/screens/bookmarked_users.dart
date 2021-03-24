import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/models/capitalize.dart';
import 'package:sample/models/database_helper.dart';
import 'package:sample/models/db_crud.dart';
import 'package:sample/models/usermodel.dart';
import 'package:sample/providers/user_provider.dart';

class BookmarkedUsersScreen extends StatefulWidget {
  @override
  _BookmarkedUsersScreenState createState() => _BookmarkedUsersScreenState();
}

class _BookmarkedUsersScreenState extends State<BookmarkedUsersScreen> {
  Size screenSize;
  final dbHelper = DatabaseHelper.instance;
  TextEditingController editingController = TextEditingController();
  String searchquery;
  List filteredUsers = [];
  List bookMarkedUserss;
  // getAllMarkedUsers() async {
  //   allMarkedUsers = await query();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchquery = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchquery = "";
    filteredUsers.clear();
    editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BookMarkedUsers providerData = Provider.of<BookMarkedUsers>(context);
    screenSize = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    // filterSearchResults(value);
                    filteredUsers = [];
                    setState(() {
                      searchquery = value;
                      bookMarkedUserss.forEach((user) {
                        // if (user['name'].contains(searchquery)) {
                        //   print(true);
                        // }
                        if (user['name'].trim().contains(searchquery) == true &&
                            searchquery != "") {
                          filteredUsers.add(user);
                          print(user['name']);
                        }
                        print(filteredUsers);
                        // filteredUsers.add(user);
                      });
                    });

                    // print(filteredUsers);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Container(
                height: screenSize.height * 0.8,
                child: FutureBuilder(
                  future: query(),
                  builder: (context, projectSnap) {
                    bookMarkedUserss = projectSnap.data;
                    if (projectSnap.hasData) {
                      if (projectSnap.data.length < 1) {
                        return Center(child: Text("No Users Found"));
                      }
                      return searchquery == ""
                          ? ListView.builder(
                              itemCount: projectSnap.data.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                    key: UniqueKey(),
                                    background: Container(
                                      color: Colors.red,
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 4, bottom: 8),
                                      height: 70,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 28,
                                          backgroundImage: NetworkImage(
                                              projectSnap.data[index]['image']),
                                        ),
                                        title: Text(
                                          capitalize(
                                            projectSnap.data[index]['name'],
                                          ),
                                        ),
                                      ),
                                    ),
                                    onDismissed: (DismissDirection direction) {
                                      delete(
                                          id: projectSnap.data[index]['_id']);

                                      // setState(() {});
                                    });
                              })
                          : ListView.builder(
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) {
                                return
                                    // Text(capitalize(
                                    //   filteredUsers[index]['name'],
                                    // ));

                                    Container(
                                  padding: EdgeInsets.only(top: 4, bottom: 8),
                                  height: 70,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(
                                          filteredUsers[index]['image']),
                                    ),
                                    title: Text(
                                      capitalize(
                                        filteredUsers[index]['name'],
                                      ),
                                    ),
                                  ),
                                );
                              });

                      // Container(height: 56, width: 35, color: Colors.red);
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              )
            ],
          ),
        ));
  }
}
