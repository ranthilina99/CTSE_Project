class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? uid;
  int? isUser = 1;

// receiving data
  UserModel({this.firstName,this.lastName,this.uid, this.email, this.password,this.isUser});
  factory UserModel.fromMap(map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
      isUser: map['isUser'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'isUser': isUser,
    };
  }
}