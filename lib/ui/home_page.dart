import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TodoBloc>().add(GetInitialNoteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(builder: (_, state) {
        return ListView.builder(
            itemCount: state.mTodo.length,
            itemBuilder: (ctx, index) {
              DateTime time = DateTime.fromMicrosecondsSinceEpoch(
                  int.parse(state.mTodo[index].tCREATEDAT));
              DateFormat df = DateFormat.yMMMEd();

              return ListTile(
                title: Text(state.mTodo[index].tTITLE),
                subtitle: Text(state.mTodo[index].tDESC),
                leading: Text(state.mTodo[index].tID.toString()),
                trailing: Text(df.format(time)),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.read<TodoBloc>().add(AddTodoItem(title: "work", desc: "Done"));
      }),
    );
  }
}
