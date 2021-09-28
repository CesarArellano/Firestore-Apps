import 'package:firestore_app/models/user_model.dart';
import 'package:firestore_app/services/users_service.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  UserModel user = UserModel();
  UsersService _usersService= UsersService();
  final TextEditingController nameField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Create User in Firestore', style: TextStyle(fontSize: 26)),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  icon: Icon(Icons.person)
                ),
                controller: nameField,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20),
              Text('User Data', style: TextStyle(fontSize: 20)),
              SizedBox(height: 5),
              FutureBuilder(
                future: _usersService.getById('yuKZudHBF9OiidlZcJfp'), 
                builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                  if(snapshot.hasData) {
                    user = snapshot.data!;
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: (user.profileImage == null)
                          ? Image.asset('assets/errorImage.png', width: 50, height: 50, fit: BoxFit.cover)
                          : Image.network(user.profileImage!, width: 50, height: 50, fit: BoxFit.cover),
                      ),
                      title: Text('${ user.name }'),
                      subtitle: Text('${ user.birthday }'),
                      trailing: Text('\$${ user.salary }'),
                      tileColor: (user.active!) ? Colors.green[100] : Colors.red[100],
                      onTap: () => print('${ user.userId }'),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
                
              )
            ]
          )
        )
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
        backgroundColor: Colors.blue[100],
        child: Icon(Icons.save, color: Colors.black),
        onPressed: () async {
          String message = '';
          if( nameField.text.isEmpty ) return;
          user.name = nameField.text;
          user.birthday = '15-02-2000';
          user.salary = 15000;
          user.active = true;
          user.profileImage = 'https://avatars.githubusercontent.com/u/38898501?v=4';
          
          try {
            await _usersService.create(user);
            message = 'User created and save in Firestore';
          } catch(e) {
            message = 'an error occurred';
          } finally {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: Text(message),
              duration: Duration(seconds: 2),
            ));
          }
        },
      ),
    );
  }
}