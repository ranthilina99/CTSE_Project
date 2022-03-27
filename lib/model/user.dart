class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? uid;

// receiving data
  UserModel({this.firstName,this.lastName,this.uid, this.email, this.password});
  factory UserModel.fromMap(map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      uid: map['uid'],
      email: map['email'],
      password: map['password'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}