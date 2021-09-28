class UserModel {
  String? userId;
  String? name;
  String? birthday;
  String? profileImage;
  int? salary;
  bool? active;

  static const collectionId = 'users';

  UserModel({
    this.userId,
    this.name,
    this.birthday,
    this.salary,
    this.profileImage,
    this.active
  });

  UserModel.fromSnapshot(String userId, Map<String, dynamic> user)
      : userId = userId,
        name = user['name'],
        birthday = user['birthday'],
        salary = user['salary'],
        active = user['active'];

  Map<String, dynamic> toMap() => {
    'name': name,
    'birthday': birthday,
    'salary': salary,
    'active': active,
  };

  @override
  String toString() {
    return 'Usuario{ userId: $userId, name: $name, birthday: $birthday, salary: $salary, avatarUrl: $active }';
  }
  
}