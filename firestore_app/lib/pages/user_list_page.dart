import 'package:firestore_app/models/user_model.dart';
import 'package:firestore_app/services/users_service.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {

  final UsersService _usersService = new UsersService();

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
              Text('Users in Firestore', style: TextStyle(fontSize: 26)),
              SizedBox(height: 10),
              FutureBuilder(
                future: _usersService.get(),
                builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if( snapshot.hasData ) {
                    final userList = snapshot.data ?? [];
                    return _userListView(userList);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      )
    );
  }

  Widget _userListView(List<UserModel> userList) {
    if (userList.length == 0) {
      return Text('Not found users');
    } else {
      return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: userList.length,
      itemBuilder: (_ , i) => _userListTile(userList[i]),
    );
    }
  }

  Widget _userListTile(UserModel user) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (DismissDirection direction) async {
        await _usersService.deleteUser(user.userId!);
      },
      child: ListTile(
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
      ),
    );
  }
}