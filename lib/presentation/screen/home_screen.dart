import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:todo_app/bloc/task_state.dart';
import 'package:todo_app/presentation/widget/task_item.dart';

import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(centerTitle: true, title: Text('Tasks')),

      //body
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),

            //Searching TextField
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                context.read<TaskBloc>().add(SearchTask(query));
              },
              decoration: InputDecoration(
                hintText: 'Search for your task...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          //to show task in home screen.
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading)
                  return Center(child: CircularProgressIndicator());
                if (state is TaskLoaded) {
                  if (state.tasks.isEmpty)
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            // color: Colors.amber,
                            child: Image.asset(
                              'asset/images/task.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Text(
                            "What do you want to do today?",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text('Tap + to add your tasks'),
                        ],
                      ),
                    );
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItem(task: state.tasks[index]);
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),

      //add task floating button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddTaskScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
