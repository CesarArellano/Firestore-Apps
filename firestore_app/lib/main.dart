import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_app/pages/create_user_page.dart';
import 'package:firestore_app/pages/search_users_page.dart';
import 'package:firestore_app/pages/user_list_page.dart';
import 'package:flutter/material.dart';

import 'package:firestore_app/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'user_list': (_) => UserListPage(),
        'create_user': (_) => CreateUserPage(),
        'search_users': (_) => SearchUsersPage()
      },
    );
  }
}