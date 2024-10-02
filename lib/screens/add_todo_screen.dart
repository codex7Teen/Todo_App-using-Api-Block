import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_api_block/model/todo_model.dart';
import 'package:todo_app_api_block/todo_bloc/todo_bloc.dart';
import 'package:todo_app_api_block/widget/snackbar.dart';

class ScreenAddTodo extends StatefulWidget {
  // IF todo is not null, we are editing
  final TodoModel? todo;
  const ScreenAddTodo({super.key, this.todo});

  @override
  State<ScreenAddTodo> createState() => _ScreenAddTodoState();
}

class _ScreenAddTodoState extends State<ScreenAddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isEdit = false;

  @override
  void initState() {
    final todo = widget.todo;
    // IF todo is not null, we are editing
    if (todo != null) {
      isEdit = true;
      final title = todo.title;
      final description = todo.description;
      titleController.text = title;
      descriptionController.text = description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoLoaded) {
          // Show snackbar when todo added or updated
          final message = isEdit
              ? 'Todo updated successfully! 🎉🎉'
              : 'Todo added successfully! 🎉🎉';
              showCustomSnackBar(context, message);
              // clear the field after adding a todo
              if(!isEdit) {
                titleController.text = '';
                descriptionController.text = '';
              }
              
        } else if(state is TodoError) {
          showCustomSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(isEdit ? 'Update Todo' : 'Add Todo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Description'),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 8,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    isEdit ? _updateTodo() : _addTodo();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(isEdit ? 'Update' : 'Submit'),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  //! A D D - T O D O
  void _addTodo() {
    final title = titleController.text;
    final description = descriptionController.text;

    final newTodo = TodoModel(id: '', title: title, description: description);

    // Dispatch addtodo event using block
    context.read<TodoBloc>().add(AddTodo(newTodo));
  }

  //! U P D A T E - T O D O
  void _updateTodo() {
    final title = titleController.text;
    final description = descriptionController.text;

    final updatedTodo =
        TodoModel(id: widget.todo!.id, title: title, description: description);

    // Dispatch addtodo event using block
    context.read<TodoBloc>().add(UpdateTodo(updatedTodo));
  }
}
