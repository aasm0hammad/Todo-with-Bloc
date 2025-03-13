import 'package:todo_bloc/database/todo_model.dart';

abstract class TodoEvent {}

class AddTodoItem extends TodoEvent {
  String title;
  String desc;

  AddTodoItem({required this.title, required this.desc});
}

class GetInitialNoteEvent extends TodoEvent {}
