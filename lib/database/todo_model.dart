import 'package:flutter/cupertino.dart';
import 'package:todo_bloc/database/dbHelper.dart';

class TodoModel {
  int? tID;
  String tTITLE;
  String tDESC;
  String tCREATEDAT;

  TodoModel({
    this.tID,
    required this.tTITLE,
    required this.tDESC,
    required this.tCREATEDAT,
  });

  Map<String, String> toMap() {
    return {
      DBHelper.getInstance().COLUMN_TODO_TITLE: tTITLE,
      DBHelper.getInstance().COLUMN_TODO_DESC: tDESC,
      DBHelper.getInstance().COLUMN_TODO_CREATED_AT: tCREATEDAT
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        tID: map[DBHelper.getInstance().COLUMN_TODO_ID],
        tTITLE: map[DBHelper.getInstance().COLUMN_TODO_TITLE],
        tDESC: map[DBHelper.getInstance().COLUMN_TODO_DESC],
        tCREATEDAT: map[DBHelper.getInstance().COLUMN_TODO_CREATED_AT]);
  }
}
