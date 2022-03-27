import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
        if(snapshot.hasError){
          print("Something wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
              child: CircularProgressIndicator()
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "CTSE FLUTTER PROJECT",
          theme: ThemeData(
            primaryColor: Color(0xff070706),
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}

