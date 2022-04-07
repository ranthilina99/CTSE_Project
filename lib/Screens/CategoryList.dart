import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctseproject/Screens/addCategory.dart';
import 'package:ctseproject/Screens/todolist.dart';
import 'package:ctseproject/Screens/viewCategory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Categories');

  List<Color> myColors = [
    Color(0xFFFCE4Ed),
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
              builder: (context) => CategoryScreen(),
            ),
          )
              .then((value) {
            print("Calling Set  State !");
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
          "Category",
        ),
        backgroundColor: Color(0xff0095FF),
      ),
      //
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
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
                Color bg = myColors[random.nextInt(4)];
                Map? data = snapshot.data!.docs[index].data() as Map?;
                String docId = snapshot.data!.docs[index].id;
                DateTime mydateTime = data!['created'].toDate();
                String formattedTime =
                DateFormat.yMMMd().add_jm().format(mydateTime);

                return
                  Slidable(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => TodoListScreen(
                              docId,
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
                              SizedBox(height: 15,),
                              Row(
                                children:  <Widget>[
                                  Expanded(
                                    child: Text(
                                      "${data['title']}",
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontFamily: "lato",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
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
                            builder: (context) => ViewCategory(
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