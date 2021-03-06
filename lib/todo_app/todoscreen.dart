
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/home_screen.dart';
import 'package:login_firebase/todo_app/add_task.dart';
import 'package:login_firebase/todo_app/list_task.dart';
import 'package:login_firebase/todo_app/todo_tasks.dart';
import 'package:login_firebase/user.dart';
import 'package:provider/provider.dart';


class TodoScreen extends StatefulWidget{
  @override
  _TodoScreen createState() => _TodoScreen();

}
User user;
class _TodoScreen extends State<TodoScreen> {

  @override
  Widget build(BuildContext context) {

    return  Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text('App To Do', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600 , color: Colors.white),),
            backgroundColor: Colors.pink[300],
            actions: <Widget> [
              Consumer<TodoTasks>(
                builder: (context, model, _) {
                  return PopupMenuButton<Choice>(
                    onSelected: (Choice choice) {
                      _select(choice, context);
                    },
                    icon: Icon(Icons.menu),
                    itemBuilder: (BuildContext context) {
                      return choices.map((Choice choice) {
                        var color = Colors.black87;
                        if( choice.index == 1 && model.status == TodoStatus.allTasks
                            || choice.index == 2 && model.status == TodoStatus.incompleteTasks
                            || choice.index == 3 && model.status == TodoStatus.completedtask
                        ) {
                          color= Colors.pink[300];
                        }
                        return PopupMenuItem<Choice>(
                            value: choice,
                            child: Text(choice.title, style: TextStyle( color:  color), ));
                      }).toList();
                    },
                  );
                },
              ),

              PopupMenuButton<ClickAll>(
                onSelected: (ClickAll clickAll) {
                  selectClickAll(clickAll, context);
                },
                icon: Icon(Icons.more_horiz),
                itemBuilder: (BuildContext context) {
                  return listClickAll.map((ClickAll clickAll) {
                    return PopupMenuItem<ClickAll>(
                      value: clickAll,
                      child: Text(clickAll.title),
                    );
                  }).toList();
                },

              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute( builder: (context) => HomeScreen()));
                  user.username = "";
                  user.pass = "";
                  final snackBar = SnackBar(
                      content: Text('Log Out!!'),);
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              )
            ],
          ),

          body: Consumer<TodoTasks>(
            builder: (context, model, _ ){
              return ListTask( listTask: model.tasks,);
            },
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 20),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.pink[300],
              onPressed: (){
                Navigator.push(context, MaterialPageRoute( builder: (context) => AddTask()) );
                final snackBar = SnackBar(
                  content: Text('Add Task!!'),);
                Scaffold.of(context).showSnackBar(snackBar);
              },
            ),
          ),
        ),
      ],
    );
  }

  void _select(Choice choice, BuildContext context) {
    Provider.of<TodoTasks>(context, listen: false).choiceStatus(choice);
  }

  void selectClickAll (ClickAll clickAll, BuildContext context){
    var todoProvider =  Provider.of<TodoTasks>( context, listen: false);
    if( clickAll.index == 1 ){
      todoProvider.fullDone();
    }
    else{
      todoProvider.fullDelete();
    }
  }

}

class Choice {
  const Choice({this.title, this.index});
  final String title;
  final int  index;
}

const List <Choice> choices = const <Choice>[
  const Choice(title: 'All Tasks', index: 1),
  const Choice(title: 'Incomplete Tasks', index: 2),
  const Choice(title: 'Completed Tasks', index: 3),
];

class ClickAll{
  const ClickAll({this.title, this.index});
  final String title;
  final int index;
}

const List <ClickAll> listClickAll = const<ClickAll>[
  const ClickAll(title: 'All Done', index: 1),
  const ClickAll(title: 'All Delete', index: 2)
];
