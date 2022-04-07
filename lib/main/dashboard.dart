import 'package:ctseproject/Screens/CategoryList.dart';
import 'package:ctseproject/Screens/addCategory.dart';
import 'package:ctseproject/Screens/todolist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screens/Login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoginScreen()), (
        route) => false);
    print("Thank You");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blueAccent,
      content: Text("Thank You",
        style: TextStyle(fontSize: 20.0),),),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
          ),
          backgroundColor: Color(0xff0095FF),
            actions: <Widget>[
              // First button - decrement
              IconButton(
                icon: Icon(Icons.logout_outlined), // The "-" icon
                onPressed: logout, // The `_decrementCounter` function
              ),]
        ),
      body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100.0,horizontal: 28.0),
        child: ListView(
            children: [
        Padding(padding: const EdgeInsets.all(0.0),
        child: Image.asset("images/dashboard.png"),
         ),
              SizedBox(height: 125),
        Container(
          margin: EdgeInsets.symmetric(),
          child:Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: Color(0xff0095FF),
            child: MaterialButton(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),

                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CategoryList(),),);
                },
                child: Text(
                  "Todo List",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ]
      ),
    ))
    );
  }
}
