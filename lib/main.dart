import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/providers/user_provider.dart';
import 'package:sample/screens/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookMarkedUsers(),
        )
      ],
      child: MaterialApp(
        title: 'Test Project',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
