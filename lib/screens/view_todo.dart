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
        title: Text('View ToDo', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(todo.title, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                SizedBox(height: 30,),
                Text(todo.description, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16))
              ],
            ),
          )
        ),
      ),
    );
  }
}