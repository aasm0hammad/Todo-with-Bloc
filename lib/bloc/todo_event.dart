import 'package:todo_bloc/database/todo_model.dart';

abstract class TodoEvent {}


/// Add Todo Event
class AddTodoItem extends TodoEvent {
  String title;
  String desc;

  AddTodoItem({required this.title, required this.desc});
}

/// GetInitial Todo Event
class GetInitialTodoEvent extends TodoEvent {}

class UpdateTodoItem extends TodoEvent {
  String title;
  String desc;
  String createdAt;
  int id;

  UpdateTodoItem(
      {required this.title,
      required this.desc,
      required this.createdAt,
      required this.id});
}

class DeleteTodoItem extends TodoEvent {
  int id;

  DeleteTodoItem({required this.id});
}
