import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_api_block/screens/add_todo_screen.dart';
import 'package:todo_app_api_block/todo_bloc/todo_bloc.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo List'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenAddTodo()));
          },
          label: Text('Add Todo')),

      //! body
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
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
                    title: Text(data.title),
                    subtitle: Text(data.description),
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    trailing: PopupMenuButton(onSelected: (value) {
                      if (value == 'edit') {
                        // perform edit
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenAddTodo(todo: data,)));
                      } else {
                        // perform delete
                        context.read<TodoBloc>().add(DeleteTodo(data.id));
                      }
                    }, itemBuilder: (context) {
                      return [
                        PopupMenuItem(value: 'edit', child: Text("Edit")),
                        PopupMenuItem(value: 'delete', child: Text("Delete")),
                      ];
                    }),
                  ),
                ),
              );
            },
          );
          } else if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No todos available'));
        },
      ),
    );
  }
}
