import 'package:flutter/cupertino.dart';

import 'dart:convert';

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Task {
  String id;
  String title;
  bool isdone;
  bool isDeleted;

  Task({this.id, this.title, this.isdone, this.isDeleted = false });

  Task.fromMap(Map snapshot,String id) :
        id = id ?? '',
        title = snapshot['title'] ?? '',
        isdone = snapshot['isdone'] ?? '',
        isDeleted = snapshot['isDeleted'] ?? '';

  toJson() {
    return {
      "title": title,
      "isdone": isdone,
      "isDeleted": isDeleted,
    };
  }
  void toggleCompleted() {
    isdone = !isdone;
  }
}
