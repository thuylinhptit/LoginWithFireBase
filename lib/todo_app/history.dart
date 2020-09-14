import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/todo_app/list_history.dart';
import 'package:login_firebase/todo_app/todo_tasks.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget{
  @override
  _History createState() => _History();

}
class _History extends State<History>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink[200],
        title: Text(
          "History", style: TextStyle( color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(

        child: Consumer<TodoTasks>(
          builder: (context, model, _ ){
            return ListHistory( listHistory: model.history,);
          },
        ),

      )
    );
  }

}