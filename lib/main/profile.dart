import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var firstName = " ";
  var lastName = " ";
  var email = " ";

  final uid = FirebaseAuth.instance.currentUser!.uid;
  // final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
          print(value);
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        firstName = loggedInUser.firstName.toString();
        lastName = loggedInUser.lastName.toString();
        email = loggedInUser.email.toString();
      });
    });
  }

  verifyEmail() async{
    if(user!=null && user!.emailVerified){
      await user!.sendEmailVerification();
      print("Verification Link has been sent");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Verification Link has been sent',
          style: TextStyle(
              fontSize: 10.0,color: Colors.white
          ),),
      ),);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Color(0xff0095FF),
        ),
        backgroundColor: Colors.white,
        body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset("images/profile.png"),
          ),
          SizedBox(height: 20.0,),

          Column(
            children: [
              Text("Full Name",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '$firstName'" " '$lastName' ,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 20.0,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email:',
                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold),
              ),
              Text(
                '$email',
                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold),
              ),
              user!.emailVerified ?
              Text('Verified',
                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
              )
                  :
              TextButton(onPressed: () =>{
                verifyEmail(),
              },
                  child: Text('Verify email',
                    style: TextStyle(fontSize: 18.0,color: Colors.red),
                  )
              ),
            ],
          ),
          SizedBox(height: 10.0,),

          Column(
            children: [
              Text("Created",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                creationTime.toString(),
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 20.0,),

          Column(
            children: [
              Text(
                "UID",
                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold),
              ),
              Text(
                uid,
                style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 20.0,),

        ],
      ),
    );
  }
}
