import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class ChangeProfileScreen extends StatefulWidget {
  const ChangeProfileScreen({Key? key}) : super(key: key);

  @override
  _ChangeProfileScreenState createState() => _ChangeProfileScreenState();
}

class _ChangeProfileScreenState extends State<ChangeProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email1 = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  CollectionReference users =
  FirebaseFirestore.instance.collection('Users');

  Future<void> update(uid, firstName, email, lastName) {
    return users
        .doc(uid)
        .update({'firstName': firstName, 'email': email, 'lastName': lastName})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('Users')
                .doc(uid)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var firstName = data!['firstName'];
              var lastName = data['lastName'];
              var email = data['email'];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: ListView(
                  children: [
                    Padding(padding: const EdgeInsets.all(30.0),
                      child: Image.asset("images/signup.png"),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: firstName,
                        autofocus: false,
                        onChanged: (value) => firstName = value,
                        decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                        ),
                        validator:  (value){
                          if(value==null || value.isEmpty){
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: lastName,
                        autofocus: false,
                        onChanged: (value) => lastName = value,
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                        ),
                        validator:  (value){
                          if(value==null || value.isEmpty){
                            return 'Please enter last name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        initialValue: email,
                        autofocus: false,
                        enabled: false,
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 20.0),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                        ),
                        validator:  (value){
                          if(value==null || value.isEmpty){
                            return 'Please enter email';
                          }else if(!value.contains("@")){
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                update(uid, firstName, email, lastName);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}