import 'package:flutter/material.dart';
import 'package:todo_app_api_block/model/todo_model.dart';

class ScreenViewTodo extends StatelessWidget {
  // getting data from home screen
  final TodoModel todo;
  const ScreenViewTodo({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('View ToDo',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      //! B O D Y
      body: Center(
        child: Card(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title text
              Text(todo.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 20)),
              const SizedBox(height: 25),
              // Description text
              Text(todo.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16))
            ],
          ),
        )),
      ),
    );
  }
}
