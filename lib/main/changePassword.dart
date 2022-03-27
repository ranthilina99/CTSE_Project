import 'package:ctseproject/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = " ";

  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    newPasswordController.dispose();
    super.dispose();
  }
  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async{
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text('Your password has been reset please login again',
          style: TextStyle(
              fontSize: 10.0,color: Colors.white
          ),),
      ),);
    }catch(error){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: Color(0xff070706),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/change.jpg"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "New Password: ",
                    hintText: 'New Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.black26,fontSize: 25.0),
                  ),
                  controller: newPasswordController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please enter password';
                    }
                    return null;
                  },

                ),
              ),
              SizedBox(height: 45),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff070706),
                child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 15),

                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          newPassword = newPasswordController.text;
                        });
                        changePassword();
                      }
                    },
                    child: Text(
                      "Change Password",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
