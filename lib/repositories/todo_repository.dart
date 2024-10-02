import 'package:todo_app_api_block/model/todo_model.dart';
import 'package:todo_app_api_block/services/api_services.dart';

//! The repository handles interactions between the BLoC and the API service.
class TodoRepository {

  final ApiServices apiServices;

  TodoRepository(this.apiServices);

  // Fetch all todos from the API.
  Future<List<TodoModel>> fetchTodos() => apiServices.fetchTodos();

  // Add a new todo
  Future<void> addTodo(TodoModel todo) => apiServices.addTodo(todo);
  
  // Update a Todo by ID
  Future<void> updateTodoById(TodoModel todo) => apiServices.updateTodoById(todo);

  // Delete a todo by ID
  Future<void> deleteTodoById(String id) => apiServices.deleteTodoById(id);
}