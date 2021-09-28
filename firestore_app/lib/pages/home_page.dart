import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8) ),
              child: Text('Get Users'),
              color: Colors.blue[100],
              onPressed: () => Navigator.pushNamed(context, 'user_list')
            ),
            MaterialButton(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8) ),
              child: Text('Create User'),
              color: Colors.blue[100],
              onPressed: () => Navigator.pushNamed(context, 'create_user')
            ),
            MaterialButton(
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8) ),
              child: Text('Search Users'),
              color: Colors.blue[100],
              onPressed: () => Navigator.pushNamed(context, 'search_users')
            ),
          ],
        ),
      )
    );
  }
}