import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseproject/Screens/forgot.dart';
import 'package:ctseproject/Screens/register.dart';
import 'package:ctseproject/Screens/home.dart';
import 'package:ctseproject/main/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = " ";
  var password = " ";
  int? isUser;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  UserModel loggedInUser = UserModel();

  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
          .then((value){
        checkUserLevel(value.user!.uid);
      });

    }on FirebaseException catch(error){

      if(error.code == 'user not found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('No user found for that email',
            style: TextStyle(
                fontSize: 10.0,color: Colors.amber
            ),),
        ),);
      }else if(error.code == 'wrong password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('Wrong password provide by the user',
            style: TextStyle(
                fontSize: 10.0,color: Colors.amber
            ),),
        ),);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Color(0xff0095FF),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 68.0,horizontal: 28.0),
          child: ListView(
            children: [
              Padding(padding: const EdgeInsets.all(0.0),
                child: Image.asset("images/login.jpg"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,
                        fontSize: 15.0),
                      prefixIcon: Icon(Icons.email,color: Colors.black26,)
                  ),
                  controller: emailController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(),
                child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black26,
                          fontSize: 15.0),
                      prefixIcon: Icon(Icons.lock,color: Colors.black26,)
                    ),
                    controller: passwordController,
                    validator:(value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      // if (!regex.hasMatch(value)) {
                      //   return ("Enter Valid Password(Min. 6 Character)");
                      // }
                      return null;
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(),
                child: Row(
                  children: [
                    Expanded(child: Container(),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotScreen(),),);
                    },
                      child: Text(
                        "Forgot password",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(),
                child:Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color:  Color(0xff0095FF),
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),

                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email=emailController.text;
                            password = passwordController.text;
                          });
                          userLogin();
                        }
                      },
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                   ),
                ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Do you have an account?"),
                    TextButton(onPressed: (){
                      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b)=>RegisterScreen(),transitionDuration: Duration(seconds: 0)), (route) => false);
                    },
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkUserLevel(String uid) {
    print(uid);
    FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
        print(loggedInUser.isUser.toString());

        setState(() {
          isUser = loggedInUser.isUser;
          print(isUser);

          if(isUser == 1){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Login Successfully",
                style: TextStyle(fontSize: 15.0),),),);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(),),);
          }
          else if(isUser == 0){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Admin Login Successfully",
                style: TextStyle(fontSize: 15.0),),),);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminScreen(),),);

          }
      });
    });
  }
}
