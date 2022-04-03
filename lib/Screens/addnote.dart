import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  String id;

  AddNote(this.id);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String des;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        backgroundColor: Color(0xff0095FF),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(
            12.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      size: 24.0,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff0095FF),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 8.0,
                        ),
                      ),
                    ),
                  ),
                  //
                  ElevatedButton(
                    onPressed:(){
                      add(widget.id);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "lato",
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff0095FF),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 8.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //
              SizedBox(
                height: 12.0,
              ),
              //
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: "Title",
                      ),
                      style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "lato",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      onChanged: (_val) {
                        title = _val;
                      },
                    ),
                    //
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Todo Description",
                        ),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                          color: Colors.grey,
                        ),
                        onChanged: (_val) {
                          des = _val;
                        },
                        maxLines: 20,
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

void add(String id) async {
  // save to db
  CollectionReference ref = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Categories')
      .doc(id)
      .collection('Todo');

  var data = {
    'title': title,
    'description': des,
    'created': DateTime.now(),
  };

  ref.add(data);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Text("Category Create Successfully",
      style: TextStyle(fontSize: 15.0),),),);

  //

  Navigator.pop(context);
}
}
