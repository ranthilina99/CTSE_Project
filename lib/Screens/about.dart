import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({ Key? key }) : super(key: key);

  //test

  @override
  Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: Color(0xFF0069FE)
              ),
          ),
          Column(
            children:  [
              SizedBox(
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(top:35.0,bottom:10.0),
                child: Text(
                  "About US",
                  style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xF1F1F1F1)
              )
            ), 
          ),
          Container(
            child: Image.asset("images/dashboard.png"),
          ),
          Center(
            child:Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  "This app was built by 4th year Software Engineering",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(238, 109, 108, 108)
              )
            ),
          )
          ),   

                                  Center(
                child: Text(
                  "Undergarutes at SLIIT",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(238, 109, 108, 108)
              )
            ),
          ),   
 

                    Center(
            child:Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Text(
                  "Team",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(238, 109, 108, 108)
              )
            ),
          )
          ), 
                    Center(
            child:Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  "IT19101620 - Salika Madhushanka W.J \n"
                  "IT19240152 - Umesh Ranthilina K.M \n"
                  "IT19129372 - H.H.W.M.B.S PARANAGAMA \n"
                  "IT19117256 - P.Y.D.Jayasinghe \n",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(238, 109, 108, 108)
              )
            ),
          )
          ), 
           Center(
            child:Padding(
                padding: EdgeInsets.only(top:45),
                child: Text(
                  "Copyright @2022",
                  style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(238, 109, 108, 108)
              )
            ),
          )
          ), 
            ],
          )
        ],
      ),
    );
  }
}