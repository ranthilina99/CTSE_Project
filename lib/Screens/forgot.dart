import 'package:ctseproject/Screens/login.dart';
import 'package:ctseproject/Screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({Key? key}) : super(key: key);

  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {

  final _formKey = GlobalKey<FormState>();

  var email = " ";

  final emailController  =  TextEditingController();

  resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber,
          content: Text("Password Reset Email has been sent",
          style: TextStyle(fontSize: 10.0),
          ),
      ),);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
    }on FirebaseException catch(error){
      if(error.code == 'user not found'){
        print('No user found for that email');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text('No user found for that email',
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
            child: Image.asset("images/forget.jpg"),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text('Reset Link will be send your email address',
            style: TextStyle(fontSize: 20.0),
            ),
          ),
          Expanded(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            labelText: "Email address",
                            labelStyle: TextStyle(
                              color: Colors.black26,fontSize: 15.0,
                            ),
                          ),
                          controller: emailController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please enter email';
                            }else if(!value.contains('@')){
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RawMaterialButton(onPressed: (){
                              if(_formKey.currentState!.validate()){
                                setState(() {
                                  email=emailController.text;
                                });
                                resetPassword();
                              }
                            },
                                child: Text("  Reset Password  ",
                                style: TextStyle(fontSize: 13.0,color: Colors.white
                                ),),
                              fillColor: Color(0xFF0069FE),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                            ),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);
                            },
                                child: Text("Login",
                                style: TextStyle(fontSize: 13.0),
                                ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Do you have an account"),
                            TextButton(onPressed: (){
                              Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b)=>RegisterScreen(),
                              transitionDuration: Duration(seconds: 0),), (route) => false);
                            },
                                child: Text("Register"),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
