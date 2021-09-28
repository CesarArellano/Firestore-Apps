import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_app/models/user_model.dart';

class UsersService {
  CollectionReference _usersRef =
      FirebaseFirestore.instance.collection(UserModel.collectionId);
  
  Future<void> create(UserModel user) async {
    await _usersRef.add(user.toMap());
  }

  Future<UserModel> getById(String uid) async {
    UserModel user = UserModel();
    DocumentSnapshot documentSnapshot = await _usersRef.doc(uid).get();
    if (documentSnapshot.exists) {
      user = UserModel.fromSnapshot(
        documentSnapshot.id, 
        documentSnapshot.data() as Map<String, dynamic>
      );
    }
    return user;
  }

  Future<List<UserModel>> get() async {
    QuerySnapshot querySnapshot = await _usersRef.get();
    return querySnapshot.docs.map(
      (ds) => UserModel.fromSnapshot(ds.id, ds.data() as Map<String, dynamic>)
    ).toList();
  }

  Future<void> deleteUser(String uid) async {
    await _usersRef.doc(uid).delete();
  }


  Stream<List<UserModel>> getByName(String name) {
    return _usersRef.where('name', isLessThanOrEqualTo: name).snapshots().map( (e) => 
      e.docs.map(
        (ds) => UserModel.fromSnapshot(ds.id, ds.data() as Map<String, dynamic>)
      ).toList()
    );
  }
}