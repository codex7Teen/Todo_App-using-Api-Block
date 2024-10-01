import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app_api_block/screens/add_todo_screen.dart';
import 'package:http/http.dart' as http;

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    fetchTodo();
    super.initState();
  }

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
          },
          label: Text('Add Todo')),

      //! body
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: () => fetchTodo(),
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(child: Text('No Todo Items'),),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                // all data
                final data = items[index] as Map;
                // id
                final id = data['_id'] as String;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(data['title']),
                      subtitle: Text(data['description']),
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      trailing: PopupMenuButton(
                        onSelected: (value) {
                          if(value == 'edit') {
                            // perform edit
                            navigateToEditPage(data);
                          } else {
                            // perform delete
                            deleteById(id);
                          }
                        },
                        itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text("Edit")),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text("Delete")),
                        ];
                      }),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  //! Navigate to edit page
  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(builder: (context) => ScreenAddTodo(todo: item,));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  //! Navigate to add page
  Future<void> navigateToAdd() async {
    final route = MaterialPageRoute(builder: (context) => ScreenAddTodo());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  //! fetch data
  Future<void> fetchTodo() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    log('${response.statusCode}');
    if (response.statusCode == 200) {
      log('FETCH SUCCESS');
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      log('ERROR');
    }

    setState(() {
      isLoading = false;
    });
  }


  //! delete data
  Future<void> deleteById(String id) async {

    final baseUrl = 'https://api.nstack.in/v1/todos/';
    final url = '$baseUrl$id';
    final uri = Uri.parse(url);

    final response = await http.delete(uri);

    log('${response.statusCode}');
    if(response.statusCode == 200) {
      log('DELETE SUCCESS');
      
      //remove items from the list
      final filteredItem = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filteredItem;
      });
      showSuccessSnackbar('Item delted successfully.. 😊');
    } else {
      log('DELETION ERROR');
    }
  }
 

  //! snackbar
  void showSuccessSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
