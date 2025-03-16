import 'package:flutter/cupertino.dart';
import 'package:todo_bloc/database/dbHelper.dart';

class TodoModel {
  int? tID;
  String tTITLE;
  String tDESC;
  String tCREATEDAT;
  bool tIsCompleted;

  TodoModel({
    this.tID,
    required this.tTITLE,
    required this.tDESC,
    required this.tCREATEDAT,
    required this.tIsCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      DBHelper.COLUMN_TODO_TITLE: tTITLE,
      DBHelper.COLUMN_TODO_DESC: tDESC,
      DBHelper.COLUMN_TODO_CREATED_AT: tCREATEDAT,
      DBHelper.COLUMN_TODO_ISCOMPLETED: tIsCompleted ? 1 : 0,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        tID: map[DBHelper.COLUMN_TODO_ID],
        tTITLE: map[DBHelper.COLUMN_TODO_TITLE],
        tDESC: map[DBHelper.COLUMN_TODO_DESC],
        tCREATEDAT: map[DBHelper.COLUMN_TODO_CREATED_AT],
        tIsCompleted: map[DBHelper.COLUMN_TODO_ISCOMPLETED] == 0 ? false : true);
  }
}
