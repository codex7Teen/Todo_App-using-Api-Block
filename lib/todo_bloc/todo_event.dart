part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {

  @override
  List<Object?> get props => [];
}


//! Event for fetching all todos
class FetchTodos extends TodoEvent {}


//! Event for adding a new todo
class AddTodo extends TodoEvent {
  final TodoModel todo;

  AddTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}


//! Event for delteting a todo by ID
class DeleteTodo extends TodoEvent {
  final String id;

  DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}


//! Event for updating an existing todo
class UpdateTodo extends TodoEvent {
  final TodoModel todo;

  UpdateTodo(this.todo);

  @override
  List<Object?> get props => [todo];
}

