import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseproject/Screens/budget.dart';
import 'package:ctseproject/Screens/viewnote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'addnote.dart';

class TodoListScreen extends StatefulWidget {
  String id;

  TodoListScreen(this.id);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  List<Color> myColors = [
    Color(0xFFFCE4EC),
    Color(0xFFE8F5E9),
    Color(0xFFE3F2FD),
    Color(0xFFFFF3E0),
    Color(0xFFE8EAF6),
    Color(0xFFFFEBEE),
    Color(0xFFFFFDE7),
    Color(0xFFEFEBE9),
    Color(0xFFE0F2F1),
    Color(0xFFF3E5F5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(
                widget.id,
              ),
            ),
          )
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[700],
      ),
      //
      appBar: AppBar(
        title: Text(
          "Notes",
        ),
        backgroundColor: Color(0xff0095FF),
      ),
      //
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Categories')
            .doc(widget.id)
            .collection('Todo').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length == 0) {
              return Center(
                child: Text(
                  "You have no saved Notes !",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                Random random = new Random();
                Color bg = myColors[random.nextInt(2)];
                Map? data = snapshot.data!.docs[index].data() as Map?;
                String docId1 = snapshot.data!.docs[index].id;
                String mydateTime ="${data!['date']}";

                String formattedTime =mydateTime.toString();

                return
                  Slidable(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => BudgectScreen(
                              docId1,
                              widget.id,
                            ),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Card(
                        color: bg,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['title']}",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: "lato",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 15,),
                              Text(
                                "Start Time" +" " +"${data['startDate']}",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(238, 109, 108, 108)
                                ),
                              ),

                              Row(
                                children:  <Widget>[
                                  Expanded(
                                    child: Text(
                                      "End Time" +" " +"${data['endDate']}",
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: "lato",
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(238, 109, 108, 108)
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Date :" +" " + "${data['date']}",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          fontFamily: "lato",
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(238, 109, 108, 108)

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actionPane: SlidableScrollActionPane(),
                    actions:<Widget> [
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.green,
                        icon: Icons.edit,
                        onTap: () =>Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => ViewNote(
                              data,
                              formattedTime,
                              snapshot.data!.docs[index].reference,
                            ),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        }),
                      ),
                    ],
                    actionExtentRatio: 1/5,
                  );
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}

