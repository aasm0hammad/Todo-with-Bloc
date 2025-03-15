import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';
import 'package:todo_bloc/database/dbHelper.dart';
import 'package:todo_bloc/database/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  DBHelper dbHelper;

  TodoBloc({required this.dbHelper}) : super(TodoState(mTodo: [])) {
    on<AddTodoItem>((event, emit) async {
      bool check = await dbHelper.addTodo(TodoModel(
          tTITLE: event.title,
          tDESC: event.desc,
          tCREATEDAT: DateTime.now().microsecondsSinceEpoch.toString()));
      if (check) {
        List<TodoModel> allTodo = await dbHelper.fetchInitialTodo();
        emit(TodoState(mTodo: allTodo));
      }
    });

    on<GetInitialTodoEvent>((event, emit) async {
      List<TodoModel> allTodo = await dbHelper.fetchInitialTodo();
      emit(TodoState(mTodo: allTodo));
    });
    on<UpdateTodoItem>((event, emit) async {
      bool check = await dbHelper.updateTodo(TodoModel(
          tTITLE: event.title,
          tDESC: event.desc,
          tCREATEDAT: event.createdAt,
          tID: event.id));

      if (check) {
        List<TodoModel> all = await dbHelper.fetchInitialTodo();
        emit(TodoState(mTodo: all));
      }
    });
    on<DeleteTodoItem>((event,emit)async{

     bool check= await dbHelper.deleteTodo(event.id);
     if(check){

       List<TodoModel> all= await dbHelper.fetchInitialTodo();
       emit(TodoState(mTodo: all));
     }

    });
  }
}
