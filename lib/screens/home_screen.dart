import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_api_block/screens/add_todo_screen.dart';
import 'package:todo_app_api_block/theme_block/theme_bloc.dart';
import 'package:todo_app_api_block/todo_bloc/todo_bloc.dart';
import 'package:todo_app_api_block/widget/snackbar.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    // bool to track the first fetch of data
    bool isFirstFetch = false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo List', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                    onPressed: () {
                      // Dispatch toggletheme event
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
          backgroundColor: Colors.purpleAccent,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScreenAddTodo()));
          },
          label: Text('Add Todo',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),

      //! body
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoDeleted) {
            // Show snackbar when a todo has been deleted
            showCustomSnackBar(context, "Todo delted successfully! 🗑️");
          }
        },
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TodoLoaded) {
              // Show snackbar only the first time the todos are fetched successfully
              if (!isFirstFetch) {
                isFirstFetch = true;
                Future.delayed(Duration.zero, () {
                  showCustomSnackBar(
                      context, "Todos fetched successfully! 🎉🎉");
                });
              }
              final todos = state.todos;
              return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  // all data
                  final data = todos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          data.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                        subtitle: Text(data.description),
                        leading: CircleAvatar(
                          backgroundColor: Colors.purpleAccent,
                          child: Text('${index + 1}'),
                        ),
                        trailing: PopupMenuButton(
                            iconColor: Colors.purpleAccent,
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
                                PopupMenuItem(
                                    value: 'edit', child: Text("Edit")),
                                PopupMenuItem(
                                    value: 'delete', child: Text("Delete")),
                              ];
                            }),
                      ),
                    ),
                  );
                },
              );
            } else if (state is TodoError) {
              return Center(child: Text(state.message));
            } else if (state is TodoEmpty) {
              return Center(child: Text('No todos available...'));
            }
            return Center(
              child: Text("Something went wrong!"),
            );
          },
        ),
      ),
    );
  }
}
