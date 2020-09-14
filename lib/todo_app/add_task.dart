
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/todo_app/todo_tasks.dart';
import 'package:provider/provider.dart';

import 'task.dart';

class AddTask extends StatefulWidget {
  final Task task;
  final int index;

  AddTask({this.task, this.index});

  @override
  _AddTask createState() => _AddTask();
}

class _AddTask extends State<AddTask> {
  final taskTextController = TextEditingController();
  bool statusDone = false;
  bool statusDeleted = false ;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      taskTextController.text = widget.task.title;
    }
  }

  @override
  void dispose() {
    taskTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Task'),
        backgroundColor: Colors.red[300],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                      child: TextField(
                        controller: taskTextController,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(labelText: 'Add Todo'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      color: Colors.red[300],
                      child: Text('Add'),
                      onPressed: onSubmit,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  Future<void> onSubmit() async {
    final String tasktext = taskTextController.text;
    final bool isdone = statusDone;
    final bool isDeleted = statusDeleted;
    final taskProvider = Provider.of<TodoTasks>(context, listen:  false);
    //Add
    if (tasktext.isNotEmpty) {
      Task todo = Task(
        title: tasktext,
        isdone: isdone,
        isDeleted: isDeleted,
      );
      print("${tasktext.toString()}");
      await taskProvider.addTask(todo);
      Navigator.pop(context);
      print('Done Add');
    }
    else{
      print("Not");
    }
  }
}
