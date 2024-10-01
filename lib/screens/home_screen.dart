import 'package:flutter/material.dart';
import 'package:todo_app_api_block/screens/add_todo_screen.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo List'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateToAdd(); 
          }, label: Text('Add Todo')),
    );
  }

  // Navigate to add page
  void navigateToAdd() {
    final route = MaterialPageRoute(builder: (context) => ScreenAddTodo());
    Navigator.push(context, route);
  }
}
