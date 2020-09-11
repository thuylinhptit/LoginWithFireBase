import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_firebase/api.dart';
import 'package:login_firebase/todo_app/task.dart';
import 'package:login_firebase/todo_app/locator.dart';
import 'package:login_firebase/todo_app/todoscreen.dart';

enum TodoStatus { allTasks, incompleteTasks, completedtask, fullDelete }

class TodoTasks extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _history = [];
  TodoStatus status = TodoStatus.allTasks;
  Api _api = locator<Api>();
  StreamSubscription<QuerySnapshot> _streamSubscription;

  Future<List<Task>> fetchTasks() async {
    var result = await _api.getData();
    var _tasks =
    result.docs.map((doc) => Task.fromMap(doc.data(), doc.id)).toList();
    return _tasks;
  }


  StreamSubscription<QuerySnapshot> streamData() {
    return _api.streamData().listen((snapshot) {
      var tasks = snapshot.docs
          .where((doc) => doc.data()["isDeleted"] == false)
          .map((doc) {
        return Task(
            id: doc.id,
            title: doc.data()["title"],
            isdone: doc.data()["isdone"],
            isDeleted: doc.data()["isDeleted"]);
      });
      _tasks.clear();
      _tasks.addAll(tasks);
      notifyListeners();

      var history = snapshot.docs.map((doc) {
        print("addTaskH");
        return Task(
            id:  doc.id,
            title: doc.data()["title"],
            isdone: doc.data()["isdone"],
            isDeleted: doc.data()["isDeleted"]
        );
      });
      _history.clear();
      _history.addAll(history);
      notifyListeners();
    });
  }

  login() async {
    _streamSubscription = streamData();
  }

  UnmodifiableListView<Task> get tasks =>
      UnmodifiableListView(status == TodoStatus.allTasks
          ? _tasks
          : status == TodoStatus.completedtask
          ? _tasks.where((element) => element.isdone)
          : _tasks.where((element) => !element.isdone));

  UnmodifiableListView<Task> get history =>
      UnmodifiableListView(status == TodoStatus.allTasks
          ? _history
          : status == TodoStatus.completedtask
          ? _history
          : _history);

  int countComplete() {
    int count = 0;
    for (int i = 0; i < _tasks.length; i++) {
      if (_tasks[i].isdone == true) {
        count++;
      }
    }
    return count;
  }

  int countIncomplete() {
    return _tasks.length - countComplete();
  }

  Future addTask(Task task) async {
    await _api.addTask(task.toJson());
  }

  Future updateTask(Task task, String id) async {
    await _api.updateTask(task.toJson(), id);
  }

  Future deleteTask(Task task, String id) async {
  //  await _api.removeTask(id);
    _tasks.remove(task);
    task.isDeleted  = true;
    _api.updateTask(task.toJson(), id);
    notifyListeners();
  }
  Future delete( Task task, String id ) async{
    await _api.removeTask(id);
    _history.remove(task);
    notifyListeners();
  }

  Stream<QuerySnapshot> fetchTaskAsStream() {
    return _api.streamData();
  }

  Future<void> toggleTodo(Task task) async {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].toggleCompleted();
    _history[taskIndex].toggleCompleted();
    await _api.updateTask(task.toJson(), task.id);
    notifyListeners();
  }

  void choiceStatus(Choice choice) {
    if (choice.index == 1)
      status = TodoStatus.allTasks;
    else if (choice.index == 2)
      status = TodoStatus.incompleteTasks;
    else if (choice.index == 3) status = TodoStatus.completedtask;
    notifyListeners();
  }

  Future<void> fullDone() async {
    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i].isdone = true;
      _history[i].isdone = true;
      await _api.updateTask(_tasks[i].toJson(), _tasks[i].id);
      await _api.updateTask(_history[i].toJson(), _history[i].id);
    }
    notifyListeners();
  }

  void fullDelete() async{
    for (int i = 0; i < _tasks.length; i++) {
      _api.removeTask(_tasks[i].id);
      _tasks[i].isDeleted = true;
    }
    notifyListeners();
  }

  void choiceClickAll(ClickAll clickAll) {
    Task task;
    if (clickAll.index == 1) {
      if (task.isdone == false) {
        task.isdone = true;
      }
      status = TodoStatus.allTasks;
    }
    if (clickAll.index == 2) {
      for (int i = 0; i < _tasks.length; i++) {
        _tasks.removeAt(i);
      }
      status = TodoStatus.fullDelete;
    }
    notifyListeners();
  }
}
