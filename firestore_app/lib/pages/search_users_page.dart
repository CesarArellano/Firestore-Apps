import 'package:firestore_app/models/user_model.dart';
import 'package:firestore_app/services/users_service.dart';
import 'package:flutter/material.dart';

class SearchUsersPage extends StatefulWidget {
  @override
  State<SearchUsersPage> createState() => _SearchUsersPageState();
}

class _SearchUsersPageState extends State<SearchUsersPage> {
  final UsersService _usersService= UsersService();
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search users Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Search user in Firestore', style: TextStyle(fontSize: 26)),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration (
                    borderRadius: BorderRadius.all( Radius.circular(15)),
                    color: Colors.blue[100]
                ),
                padding: EdgeInsets.all(16.0),
                child: Theme(
                  data: ThemeData(
                    colorScheme: ThemeData().colorScheme.copyWith( // Change color icons TextFormField
                      primary: Colors.black54,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by name',
                      icon: Icon(Icons.person),
                      suffixIcon: Icon(Icons.search)
                    ),
                    onChanged: (value) {
                      setState(() => name = value);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              name.length > 0
                ? StreamBuilder<List<UserModel>>(
                  stream: _usersService.getByName(name),
                  builder: (BuildContext context,  AsyncSnapshot<List<UserModel>> snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: users!.length,
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            leading: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: (users[i].profileImage == null)
                              ? Image.asset('assets/errorImage.png', width: 50, height: 50, fit: BoxFit.cover)
                              : Image.network(users[i].profileImage!, width: 50, height: 50, fit: BoxFit.cover),
                          ),
                          title: Text('${ users[i].name }'),
                          subtitle: Text('${ users[i].birthday }'),
                          trailing: Text('\$${ users[i].salary }'),
                          tileColor: (users[i].active!) ? Colors.green[100] : Colors.red[100],
                          onTap: () => print('${ users[i].userId }'),
                          );
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )
                : Text('Campo Vacío'),
            ]
          )
        ),
      )
    );
  }
}