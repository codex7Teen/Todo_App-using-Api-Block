// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_api_block/screens/add_todo_screen.dart';
import 'package:todo_app_api_block/screens/view_todo.dart';
import 'package:todo_app_api_block/theme_block/theme_bloc.dart';
import 'package:todo_app_api_block/todo_bloc/todo_bloc.dart';
import 'package:todo_app_api_block/widget/snackbar.dart';

class ScreenHome extends StatelessWidget {
  // bool to track the first fetch of data
  static bool isFirstFetch = false;

  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! A P P - B A R
      appBar: AppBar(
        centerTitle: true,
        // Appbar title
        title: const Text('ToDo List',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          // Blockbuilder to rebuild the themetoggle icon upon tap
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                // Theme-toggle button
                child: IconButton(
                    onPressed: () {
                      // Calling the toggle theme event from the event block
                      context.read<ThemeBloc>().add(ToggleTheme());
                    },
                    icon: Icon(state.themeData.brightness == Brightness.dark
                        ? Icons.brightness_7
                        : Icons.brightness_6)),
              );
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.purple,
          onPressed: () {
            // Navigate to Todo-add page
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ScreenAddTodo()));
          },
          label: const Row(
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 5,
              ),
              Text('Add Todo',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          )),

      //! B O D Y
      // Block listener which listens to the todoDeleted state
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoDeleted) {
            // Show snackbar when a todo has been deleted
            showCustomSnackBar(context, state.message);
          }
        },
        // Block builder
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading || state is TodoAddingUpdating) {
              // return circular progress indicator when loading
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoLoaded) {
              // Condition to Show snackbar only when the first time todos are got fetched
              if (!isFirstFetch) {
                isFirstFetch = true;
                Future.delayed(Duration.zero, () {
                  showCustomSnackBar(
                      context, "Todos fetched successfully! 🎉🎉");
                });
              }
              // getting the list of todomodel from the state to the variable todos
              // reversing the list to make newly added come first
              final todos = state.todos.reversed.toList();
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  // all data
                  final data = todos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenViewTodo(
                                    todo: data,
                                  ))),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            data.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          subtitle: Text(
                            data.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.purple,
                            child: Text('${index + 1}'),
                          ),
                          trailing: PopupMenuButton(
                              iconColor: Colors.purple,
                              onSelected: (value) {
                                if (value == 'edit') {
                                  // perform edit
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ScreenAddTodo(
                                                todo: data,
                                              )));
                                } else {
                                  // perform delete
                                  context
                                      .read<TodoBloc>()
                                      .add(DeleteTodo(data.id));
                                  // display snackbar when todo gets deleted
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                      value: 'edit',
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, size: 18),
                                          SizedBox(width: 5),
                                          Text("Edit"),
                                        ],
                                      )),
                                  const PopupMenuItem(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, size: 18),
                                          SizedBox(width: 5),
                                          Text("Delete"),
                                        ],
                                      )),
                                ];
                              }),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is TodoError) {
              // show error message if fetching failed
              return Center(child: Text(state.message));
            } else if (state is TodoEmpty) {
              // show text if todolist is empty
              return const Center(
                  child: Text(
                'No Todos available !',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ));
            }
            // show text if unknown error happend
            return const Center(
              child: Text(
                "Something went wrong !",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            );
          },
        ),
      ),
    );
  }
}
