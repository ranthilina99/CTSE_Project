import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({ Key? key }) : super(key: key);

  // test

  @override
  Widget build(BuildContext context) {
        var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * .30,
            decoration: const BoxDecoration(
              color: Color(0xFF0069FE)
              ),
          ),
          Column(
            children:  [
          Container(
            padding: EdgeInsets.only(top:35.0),
            child: Image.asset("images/email.png",width: 100),
          ),
                        SizedBox(
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.only(top:25.0),
                child: Text(
                  "Contact US",
                  style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xF1F1F1F1)
              )
            ), 
          ),

            Center(
            child:Padding(
                padding: EdgeInsets.only(top: 45.0),
                child: Icon(
                  Icons.location_on_rounded,
                  color: Colors.red, size: 40,),
            )
          ),  

          Center(
            child:Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "No 58, Soloman Mawtha, wakada, Panadura",
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
                padding: EdgeInsets.only(top: 20.0),
                child: Icon(
                  Icons.phone_android,
                  color: Colors.red, size: 40,),
            )
          ),  

          Center(
            child:Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "+94 771 373 018\n"
                  "+94 765 537 570\n"
                  "+94 770 313 651\n"
                  "+94 773 762 743\n",
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
                padding: EdgeInsets.only(top: 20.0),
                child: Icon(
                  Icons.punch_clock_rounded,
                  color: Colors.red, size: 40,),
            )
          ),  

          Center(
            child:Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "Monday - Friday",
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
                  "9am - 5pm",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(238, 109, 108, 108)
              )
            ),
          ),  

                        Center(
                child: Text(
                  "Saturday - Sunday",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(238, 109, 108, 108)
              )
            ),
          ),   

                        Center(
                child: Text(
                  "9am - 12pm",
                  style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(238, 109, 108, 108)
              )
            ),
          ),  


            ],
          )
        ],
      ),
    );
  }
}