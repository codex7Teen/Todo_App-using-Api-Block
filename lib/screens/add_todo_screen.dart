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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          if (!isEdit) {
            titleController.text = '';
            descriptionController.text = '';
            // calling this will help to reset the form state (to prevent the validation error displayed)
            _formKey.currentState?.reset();
          }
        } else if (state is TodoError) {
          showCustomSnackBar(context, state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(isEdit ? 'Update Todo' : 'Add Todo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Enter title' ,hintStyle: TextStyle(fontWeight: FontWeight.w400)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    } else {
                      return null;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Enter Description',hintStyle: TextStyle(fontWeight: FontWeight.w400)),
                  keyboardType: TextInputType.multiline,
                  minLines: 5,
                  maxLines: 8,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(elevation: WidgetStatePropertyAll(2)),
                      onPressed: () {
                        // validate and submit data
                        if (_formKey.currentState!.validate()) {
                          isEdit ? _updateTodo() : _addTodo();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          isEdit ? 'Update' : 'Submit',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.purple),
                        ),
                      )),
                )
              ],
            ),
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
