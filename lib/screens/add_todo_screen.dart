// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_api_block/data/my_data.dart';

class ScreenAddTodo extends StatefulWidget {
  const ScreenAddTodo({super.key});

  @override
  State<ScreenAddTodo> createState() => _ScreenAddTodoState();
}

class _ScreenAddTodoState extends State<ScreenAddTodo> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Todo'),
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
            }, child: Text('Submit'))
          ],
        ),
      ),
    );
  }

  // submit all the inputs
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
    final baseUrl = 'https://api.nstack.in/v1/todos';
    final url = "$baseUrl?key=$apiKey";
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    
    // show success or fail message based on submit status

    if(response.statusCode == 201) {
      log('Post Success.. :)');
    } else {
      log('Post Failed!');
    }
  }
}