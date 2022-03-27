import 'package:ctseproject/Screens/forgot.dart';
import 'package:ctseproject/Screens/register.dart';
import 'package:ctseproject/Screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = " ";
  var password = " ";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(),),);

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
      }else if(error.code == 'wrong password'){
        print('Wrong password provide by the user');
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
                    }else if(!value.contains("@")){
                      return 'Please enter valid email';
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
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
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
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(),
                child:
                    RawMaterialButton(onPressed: (){
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
                        style: TextStyle(fontSize: 20.0,color: Colors.white),
                      ),
                      fillColor: Color(0xFF0069FE),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
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
}
