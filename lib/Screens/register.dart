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

  registration() async{
    if(password == confirmPassword){
      try{
        UserModel userModel = UserModel();

        userModel.email = email;
        userModel.password = password;
        userModel.lastName = lastName;
        userModel.firstName = firstName;

        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
          FirebaseFirestore.instance.collection('Users').doc(value.user?.uid).set(
            userModel.toMap()
          );
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Register Successfully",
            style: TextStyle(fontSize: 20.0),),),);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen(),),);
      }on FirebaseException catch(error){
        if(error.code == 'weak password'){
          print('Password is to weak');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Password is to weak',
              style: TextStyle(
                  fontSize: 10.0,color: Colors.amber
              ),),
          ),);
        }else if(error.code == 'email already in use'){
          print('Account is already exists');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Account is already exists',
              style: TextStyle(
                  fontSize: 10.0,color: Colors.amber
              ),),
          ),);
        }else{
          print('Password and confirm password does not match');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.black26,
            content: Text('Password and confirm password does not match',
              style: TextStyle(
                  fontSize: 10.0,color: Colors.amber
              ),),
          ),);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ),
                  controller: emailController,
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
                    ),
                    controller: confirmPasswordController,
                    validator:(value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }
                ),
              ),
              Container(
                child: RawMaterialButton(onPressed: (){
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
                  child: Text('Register',
                    style: TextStyle(fontSize: 20.0,color: Colors.white),
                  ),
                  fillColor: Color(0xFF0069FE),
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                  ),
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
                      child: Text("Login"),
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
