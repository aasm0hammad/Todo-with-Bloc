import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/ui/home_page.dart';

class AddUpdateTodo extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "Enter Title"),
          ),
          SizedBox(
            height: 13,
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: "Enter Desc"),
          ),
          ElevatedButton(
              onPressed: () {
                context.read<TodoBloc>().add(AddTodoItem(
                    title: titleController.text, desc: descController.text));
                Navigator.pop(context);
              },
              child: Text("Add")),
        ]),
      ),
    );
  }
}
