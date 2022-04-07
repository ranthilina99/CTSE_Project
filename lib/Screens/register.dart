import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseproject/Screens/Login.dart';
import 'package:ctseproject/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  var firstName = " ";
  var lastName = " ";
  var email = " ";
  var password = " ";
  var confirmPassword = " ";

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  registration() async {
    if (password == confirmPassword) {
      try {
        UserModel userModel = UserModel();

        userModel.email = email;
        userModel.password = password;
        userModel.lastName = lastName;
        userModel.firstName = firstName;
        userModel.isUser = 1;

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password).then((value) {
          FirebaseFirestore.instance.collection('Users')
              .doc(value.user?.uid)
              .set(
              userModel.toMap()
          );
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Register Successfully",
            style: TextStyle(fontSize: 15.0),),),);

        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Register Failed",
            style: TextStyle(fontSize: 15.0),),),);
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Do not mach password",
          style: TextStyle(fontSize: 15.0),),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Color(0xff0095FF),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60.0,horizontal:
          20.0),
          child: ListView(
            children: [
              Padding(padding: const EdgeInsets.all(30.0),
                child: Image.asset("images/signup.png"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                      prefixIcon: Icon(Icons.person,color: Colors.black26,)
                  ),
                  controller: firstNameController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                      prefixIcon: Icon(Icons.person,color: Colors.black26,)
                  ),
                  controller: lastNameController,
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
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,fontSize: 15.0),
                      prefixIcon: Icon(Icons.email,color: Colors.black26,)
                  ),
                  controller: emailController,
                  validator:  (value){
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
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black26,
                          fontSize: 15.0),
                        prefixIcon: Icon(Icons.password,color: Colors.black26,)
                    ),
                    controller: passwordController,
                    validator:(value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                      return null;
                    }
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(color: Colors.black26,
                          fontSize: 15.0),
                        prefixIcon: Icon(Icons.password,color: Colors.black26,)
                    ),
                    controller: confirmPasswordController,
                    validator:(value) {
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                      return null;
                    }
                ),
              ),
              Container(
                child:Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xff0095FF),
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),

                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            firstName= firstNameController.text;
                            lastName= lastNameController.text;
                            email= emailController.text;
                            password = passwordController.text;
                            confirmPassword = confirmPasswordController.text;
                          });
                          registration();
                        }
                      },
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              SizedBox(height: 15,),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(" Already have an account "),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context,animation1,animation2)=>LoginScreen(),transitionDuration: Duration(seconds: 0),),);
                    },
                      child: Text(
                          "Login",
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
}
