// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScreenAddTodo extends StatefulWidget {
  final Map? todo;
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
   if(widget.todo != null) {
    isEdit = true;
   }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isEdit ?  Text('Edit Todo') :Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title'
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Description' 
              ),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              submitData();
            }, child: isEdit? Text('Update') : Text('Submit'))
          ],
        ),
      ),
    );
  }

  //! submit all data
  void submitData() async {
    // get the data from form
    final title = titleController.text;
    final description = descriptionController.text;

  // body for sending to server
    final body = {
  "title": title,
  "description": description,
  "is_completed": false
};
 
    // submit data to the server
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    
    // show success or fail message based on submit status

    if(response.statusCode == 201) {
      log('Post Success.. :)');
      titleController.text = '';
      descriptionController.text = '';
      showSuccessSnackbar('Todo submitted successfully...😊');
    } else {
      log('Post Failed!');
      showSuccessSnackbar('Failed to submit... 😔');
    }
  }

  //! snackbar
  void showSuccessSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}