import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/register.dart';

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreen createState() => _HomeScreen();

}
class _HomeScreen extends State<HomeScreen>{
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.pink[400],
              Colors.pink[300],
              Colors.pink[200],
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login', style: TextStyle( color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Welcome', style: TextStyle( color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 60,),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink[300],
                              blurRadius: 10,
                              offset: Offset(0, 9)
                            )
                          ]
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                controller: _username,
                                decoration: InputDecoration(
                                  hintText: 'Enter your username',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                controller: _password,
                                decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 80,),
                      FlatButton(
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pink[400]
                          ),
                          child: Center(
                            child: Text(
                              'Sign In', style: TextStyle( color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox( height: 10,),
                      Row(
                        children: [
                          SizedBox( width: 70,),
                          Text(
                            "I'm a new user, ", style: TextStyle( color:  Colors.black, fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute ( builder:(context) => Register())),
                            child: Text(
                              "Sign up", style: TextStyle( color: Colors.pink[300], fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }


}