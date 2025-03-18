import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/ui/home_page.dart';

class AddUpdateTodo extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  int id = -1;
  String title = '';
  String desc = '';
  String createdAt = '';
  bool isUpdated = false;
  bool isCompleted=false;

  AddUpdateTodo(
      {this.title = '',
      this.desc = '',
      this.createdAt = '',
      this.isUpdated = false,
      this.id = -1,
        this.isCompleted=false});

  @override
  Widget build(BuildContext context) {
    if(isUpdated){

      titleController.text=title;
      descController.text=desc;
    }
    return Scaffold(
      appBar: AppBar(title: isUpdated?Text("Update Todo"):Text("Add Todo"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              label: Text('Title'),
                enabledBorder: OutlineInputBorder(),
                focusedBorder:OutlineInputBorder(),
                hintText: "Enter Title"),
          ),
          SizedBox(
            height: 13,
          ),
          TextField(
            controller: descController,
            maxLines: null,
            textInputAction: TextInputAction.newline,
           // keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder:OutlineInputBorder(),

              label: Text("Desc"),
                border: InputBorder.none, hintText: "Enter Desc"),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
               if(isUpdated){
                 context.read<TodoBloc>().add(UpdateTodoItem(title: titleController.text, desc: descController.text, createdAt: createdAt, id: id,isComplete: isCompleted ));
               }else{
                 context.read<TodoBloc>().add(AddTodoItem(
                     title: titleController.text, desc: descController.text));
               }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(11),

                  ),
                  textStyle: TextStyle(fontSize:16,color: Colors.green),
                minimumSize: Size(300, 50),

              ),
              child:isUpdated? Text("Update",style: TextStyle(color: Colors.black),):Text("Add",style: TextStyle(color: Colors.black))),
        ]),
      ),
    );
  }
}
