import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:todo_app_api_block/model/todo_model.dart';

class ApiServices {

  //! GET Todo FROM API
  Future<List<TodoModel>> fetchTodos() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      log('GET SUCCESS');
      final List data = jsonDecode(response.body)['items'];
      return data.map((item) => TodoModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch Todos');
    }
  }


  //! ADD NEW Todo TO API
  Future<void> addTodo(TodoModel todo) async {
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);

    final response = await http.post(uri,
        body: jsonEncode(todo.toJson()),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    } else {
      log('ADD SUCCESS');
    }
  }


  //! UPDATE Todo IN API
  Future<void> updateTodoById(TodoModel todo) async {
    final baseUrl = 'https://api.nstack.in/v1/todos/';
    final url = '$baseUrl${todo.id}';
    final uri = Uri.parse(url);

    final response = await http.put(uri,
        body: jsonEncode(todo.toJson()),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    } else {
      log('UPDATE SUCCESS');
    }
  }


  //! DELETE Todo FROM API by ID
  Future<void> deleteTodoById(String id) async {
    final baseUrl = 'https://api.nstack.in/v1/todos/';
    final url = '$baseUrl$id';
    final uri = Uri.parse(url);

    final response = await http.delete(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete Todo');
    } else {
      log('DELETE SUCCESS');
    }
  }


}
