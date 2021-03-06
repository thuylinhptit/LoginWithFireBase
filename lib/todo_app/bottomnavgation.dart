
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/todo_app/history.dart';
import 'package:login_firebase/todo_app/todo_tasks.dart';
import 'package:provider/provider.dart';
import 'todoscreen.dart';

class BottomNavigation extends StatefulWidget{

  @override
  _BottomNavigaton createState() => _BottomNavigaton();

}

class _BottomNavigaton extends State<BottomNavigation>{

  var _selectedIndex = 0;
   List<Widget> _widgetOptions = <Widget>[
    Center(
        child: TodoScreen(),
    ),
    Center(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Stats', style: TextStyle(fontSize: 25),
          ),
          backgroundColor: Colors.pink[200],
        ),
        body: Center(
          child: Consumer<TodoTasks>(

            builder:(context, model, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Completed Tasks', style: TextStyle( color: Colors.black, fontSize: 25),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                  child: Text(
                    '${model.countComplete()}', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Incomplete Tasks',style: TextStyle( color: Colors.black, fontSize: 25),
                ),
                Text(
                    '${model.countIncomplete()}',style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),

      ),
    ),
     Center(
       child: History(),
     )
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Center(
              child: _widgetOptions.elementAt(_selectedIndex)
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  title: Text('Todos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back),
                  title: Text('Stats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.redo),
                title: Text('History', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
              )
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.pink[200],
            onTap: _onTapItem,
          ),
      );

  }

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}