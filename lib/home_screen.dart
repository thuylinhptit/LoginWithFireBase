import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_firebase/register.dart';
import 'package:login_firebase/todo_app/bottomnavgation.dart';
import 'package:login_firebase/todo_app/locator.dart';
import 'package:login_firebase/todo_app/todo_tasks.dart';
import 'package:login_firebase/todo_app/todoscreen.dart';
import 'package:provider/provider.dart';

import 'api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}
bool isSignIn;
class _HomeScreen extends State<HomeScreen>{
  bool isLoad = false;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    isSignIn = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.red[300],
              Colors.pink[300],
              Colors.pink[200],
              ]
          )
        ),
        child: SingleChildScrollView(
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
//              Expanded(
//                child:
                Container(
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
                                  controller: _email,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
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
                          onPressed: () {
                            onLogin();
                            setState(() {
                              isLoad = true;
                            });
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.pink[300]
                            ),
                            child: Center(
                              child: Text(
                                'Sign in', style: TextStyle( color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        FlatButton(
                          onPressed: () {
                            SignIn();
                            print("Press");
                            setState(() {
                              isLoad = true;
                            });
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue[200]
                            ),
                            child: Center(
                              child: Text(
                                'Sign in with Google', style: TextStyle( color: Colors.white, fontSize: 18),
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
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute ( builder:(context) => Register()));
                                final snackBar = SnackBar(
                                  content: Text('Check email'),);
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                              child: Text(
                                "Sign up", style: TextStyle( color: Colors.pink[300], fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Center(
                            child: isLoad == true ? CircularProgressIndicator() : Container()
                        )
                      ],
                    ),

                  ),
                ),

            ],
          ),
        ),

      ),
    );
  }

  void onLogin() async{

    if( _email != null && _password != null ){
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email.text.toString(),
            password: _password.text.toString()
        );
        if(!userCredential.user.emailVerified) {
          final snackBar = SnackBar(
            content: Text('email chua duoc xac thuc!!'),);
          Scaffold.of(context).showSnackBar(snackBar);
          print("email chua duoc xac thuc");
        } else {
          print("dang nhap thanh cong");
          isSignIn = true;
          locator<Api>().ref =  FirebaseFirestore.instance.collection(userCredential.user.uid);
          await Provider.of<TodoTasks>(context, listen: false).login();
          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }

  }


  Future<void> handleSignIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider
        .credential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final User user = (await _auth.signInWithCredential(credential)).user;
    isSignIn = true;
    return user;
  }
  void SignIn(){
    if( isSignIn == true ){
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
      print("OK");
    }
    else{
      Navigator.push(context, MaterialPageRoute ( builder:(context) => Register()));
      print("False");
    }
  }
}