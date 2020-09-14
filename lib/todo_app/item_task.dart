import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login_firebase/todo_app/edit_task.dart';
import 'package:login_firebase/todo_app/todo_tasks.dart';
import 'package:login_firebase/todo_app/add_task.dart';
import 'package:login_firebase/todo_app/todoscreen.dart';
import 'package:provider/provider.dart';
import 'task.dart';

class MyListTask{
  String list;

  MyListTask({@required this.list});
}

class ItemTask extends StatelessWidget{
  final Task task;
  int index;
  ItemTask({@required this.task,@required this.index});

  @override
  Widget build(BuildContext context) {
    Color _color;
    var rm = new Random();
    var rng;
    for (var i = 0; i < 1; i++) {
      rng = (rm.nextInt(7));
    }
    if( rng == 0 ){
      _color = Colors.cyan[200];
    }
    else if( rng == 1 ){
      _color = Colors.lightGreen[200];
    }
    else if( rng == 2 ){
      _color = Colors.deepOrange[200];
    }
    else if( rng == 3 ){
      _color = Colors.purple[200];
    }
    else if( rng == 4 ){
      _color = Colors.yellow[200];
    }
    else if( rng == 5 ){
      _color = Colors.red[200];
    }
    else {
      _color = Colors.blue[200];
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 7),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.35,
        child: Container(
          child: ListTile(
            leading: Checkbox(
              value: task.isdone,
              onChanged: (bool checked) {
                Provider.of<TodoTasks>(context, listen: false).toggleTodo(task);
              },
            ),
            title: Text(
              task.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.all(
              Radius.circular(9.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.pink[200],
                blurRadius: 5.0,
                  offset: Offset(0, 3)

              ),
            ],
          ),
        ),
        actions: <Widget> [
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red[300],
            icon: Icons.delete,
            onTap: () => Delete(context, index),
          ),
          IconSlideAction(
            caption: 'Edit',
            color: Colors.blue[300],
            icon: Icons.edit,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditTask(task: task, index: index,),
              fullscreenDialog: true,));
              final snackBar = SnackBar(
                content: Text('Edit Task!!'),);
              Scaffold.of(context).showSnackBar(snackBar);
            },
            closeOnTap: false,
          ),
        ],
      ),
    );
  }

  Future<bool> Delete(BuildContext context,  int index){
    final taskProvider = Provider.of<TodoTasks>(context, listen: false);

    return showDialog<bool>(
        context: context,
        builder: (context){
          return AlertDialog(
            actions: [
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              FlatButton(
                  child: Text('Delete'),
                  onPressed: () {
                    if( task.isDeleted == false ){
                      task.isDeleted = true;
                      taskProvider.deleteTask(task, task.id);
                      Navigator.of(context).pop(true);
                    }
                    else{
                      task.isDeleted = true;
                      taskProvider.delete(task, task.id);
                      Navigator.of(context).pop(true);
                    }
                    final snackBar = SnackBar(
                      content: Text('Deleted Task!!'),);
                    Scaffold.of(context).showSnackBar(snackBar);
                  },


              )
            ],
          );
        }
    );
  }


}