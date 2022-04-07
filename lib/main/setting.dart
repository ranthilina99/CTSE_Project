import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseproject/Screens/about.dart';
import 'package:ctseproject/Screens/changeProfile.dart';
import 'package:ctseproject/Screens/contact.dart';
import 'package:ctseproject/Screens/login.dart';
import 'package:ctseproject/Screens/changePassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference ref = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  User? user = FirebaseAuth.instance.currentUser;

  delete(String uid) async{
    try{
      await FirebaseFirestore.instance.collection("Users").doc(uid).delete();
      FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black,
        content: Text("Delete Successfully",
          style: TextStyle(fontSize: 20.0),),),);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
    }catch(error){
      print(error);
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoginScreen()), (
        route) => false);
    print("Thank You");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black26,
      content: Text('Thank You',
        style: TextStyle(
            fontSize: 10.0, color: Colors.white
        ),),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    final ChangeProfile = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff0095FF),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChangeProfileScreen(),),);
          },
          child: Text(
            "Change Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final ChangePasssword = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff0095FF),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChangePassword(),),);
          },
          child: Text(
            "Change Password",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final Delete = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff0095FF),
      child: MaterialButton(

          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            _delete(user!.uid);
          },
          child: Text(
            "Delete Account",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final Logout = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff0095FF),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            logout();
          },
          child: Text(
            "Logout",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final Aboutus = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff0095FF),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => About(),),);
          },
          child: Text(
            "About us",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final ContactUs = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xff0095FF),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => Contact(),),);
          },
          child: Text(
            "ContactUs",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        backgroundColor: Color(0xff0095FF),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 35),
                    ChangeProfile,
                    SizedBox(height: 35),
                    ChangePasssword,
                    SizedBox(height: 35),
                    Delete,
                    SizedBox(height: 35),
                    Aboutus,
                    SizedBox(height: 35),
                    ContactUs,
                    SizedBox(height: 35),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _delete(String uid) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the box?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // Remove the box
                    delete(uid);

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}