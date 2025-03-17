import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';
import 'package:todo_bloc/ui/add_update_todo.dart';

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
              ),
            ]),
          ),
          body: TabBarView(
            children: [allTodo(null), allTodo(false), allTodo(true)],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUpdateTodo()));
            },
            child: Icon(Icons.add),
          ),
        ));
  }

  Widget allTodo(bool? flag) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (_, state) {
      List filter = [];

      if (flag == null) {
        filter = state.mTodo;
      } else if (flag) {
        filter = state.mTodo.where((todo) => todo.tIsCompleted).toList();
      } else {
        filter = state.mTodo.where((todo) => !todo.tIsCompleted).toList();
      }

      return filter.isNotEmpty
          ? ListView.builder(
              itemCount: filter.length,
              itemBuilder: (ctx, index) {
                DateTime time = DateTime.fromMicrosecondsSinceEpoch(
                    int.parse(filter[index].tCREATEDAT));
                DateFormat df = DateFormat.yMMMEd();

                return InkWell(
                  onTap: () {
                    /*   context
                        .read<TodoBloc>()
                        .add(DeleteTodoItem(id: filter[index].tID!));*/
                  },
                  onLongPress: () {
                    context.read<TodoBloc>().add(UpdateTodoItem(
                        title: "title Updated 2",
                        desc: "desc Updated",
                        createdAt: filter[index].tCREATEDAT,
                        id: filter[index].tID!,
                        isComplete: filter[index].tIsCompleted));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: [
                          BoxShadow(blurRadius: 5, blurStyle: BlurStyle.solid)
                        ]),
                    child: ListTile(
                      tileColor: Colors.black,
                      title: Text(filter[index].tTITLE),
                      subtitle: Text(filter[index].tDESC),
                      leading: Text(
                        filter[index].tID.toString(),
                        style: TextStyle(fontSize: 21),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(flex: 1, child: Text(df.format(time))),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {

                                    }, icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      context.read<TodoBloc>().add(
                                          DeleteTodoItem(
                                              id: filter[index].tID!));
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      context.read<TodoBloc>().add(IsCompleted(
                                          id: filter[index].tID!,
                                          isCompleted:
                                              !filter[index].tIsCompleted));
                                    },
                                    icon: Icon(
                                      filter[index].tIsCompleted
                                          ? Icons.check_circle
                                          : Icons.check_circle_outline,
                                      color: Colors.green,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: Text("Is Empty!"),
            );
    });
  }


}
