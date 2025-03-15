import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_bloc/database/todo_model.dart';

class DBHelper {
  DBHelper._();

  static DBHelper getInstance() => DBHelper._();

  String TABLE_TODO = 'TODO';
  String COLUMN_TODO_ID = 'id';
  String COLUMN_TODO_TITLE = 'title';
  String COLUMN_TODO_DESC = 'desc';
  String COLUMN_TODO_CREATED_AT = 'createdAT';

  Database? _db;

  Future<Database> getDB() async {
    _db ??= await openDB();

    return _db!;
  }

  Future<Database> openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path, 'TodoDB.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          "create table $TABLE_TODO ( $COLUMN_TODO_ID integer primary key autoincrement, $COLUMN_TODO_TITLE text, $COLUMN_TODO_DESC text, $COLUMN_TODO_CREATED_AT text ) ");
    });
  }

  Future<bool> addTodo(TodoModel newTodo) async {
    Database db = await getDB();
    int rowEffected = await db.insert(TABLE_TODO, newTodo.toMap());
    return rowEffected > 0;
  }

  Future<List<TodoModel>> fetchInitialTodo() async {
    Database db = await getDB();
    List<Map<String, dynamic>> mTodo = await db.query(TABLE_TODO);

    List<TodoModel> allTodo = [];
    for (Map<String, dynamic> eachTodo in mTodo) {
      allTodo.add(TodoModel.fromMap(eachTodo));
    }
    return allTodo;
  }

  Future<bool> updateTodo(TodoModel updateValue) async {
    Database db = await getDB();

    int rowEffected = await db.update(TABLE_TODO, updateValue.toMap(),
        where: "$COLUMN_TODO_ID=?", whereArgs: ['${updateValue.tID!}']);
    return rowEffected > 0;
  }

  deleteTodo(int id)async{

    Database db=await getDB();
    int rowEffected= await db.delete(TABLE_TODO, where: "$COLUMN_TODO_ID=$id");
    return rowEffected >0;

  }
}
