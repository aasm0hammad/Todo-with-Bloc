import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
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

    super.initState();
    context.read<TodoBloc>().add(GetInitialTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
          bottom: TabBar(tabs: [
            Tab(
             text: "All",
            ),
            Tab(
              text: "Pending",
            ),
            Tab(
              text: "Complete",
            ), ]),
        ),
      body: TabBarView(
        children:[allTodo(),Center(child: Text("Pending?")),Center(child: Text("Complete?"))],
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        context.read<TodoBloc>().add(AddTodoItem(title: "work", desc: "Done"));
        MotionToast.success(

          title: Text("Congratulations New ToDo add successfully"),
          description: Text(""),
           ).show(context);
      },child: Icon(Icons.add),),
    ));
  }
  Widget allTodo() {
    return
      BlocBuilder<TodoBloc, TodoState>(builder: (_, state) {
        return state.mTodo.isNotEmpty? ListView.builder(
            itemCount: state.mTodo.length,
            itemBuilder: (ctx, index) {
              DateTime time = DateTime.fromMicrosecondsSinceEpoch(
                  int.parse(state.mTodo[index].tCREATEDAT));
              DateFormat df = DateFormat.yMMMEd();

              return InkWell(

                onTap: (){
                  context.read<TodoBloc>().add(DeleteTodoItem(id: state.mTodo[index].tID!));
                },
                onLongPress: (){
                  context.read<TodoBloc>().add(UpdateTodoItem(title: "title Updated 2", desc: "desc Updated", createdAt: state.mTodo[index].tCREATEDAT, id: state.mTodo[index].tID!));

                },
                child: ListTile(
                  title: Text(state.mTodo[index].tTITLE),
                  subtitle: Text(state.mTodo[index].tDESC),
                  leading:  Text(state.mTodo[index].tID.toString(),style: TextStyle(fontSize: 21),),
                  trailing: Text(df.format(time)),
                ),
              );
            }):Center(child: Text("Is Empty!"),);
      });
  }

}