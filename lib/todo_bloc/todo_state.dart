part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  
  @override
  List<Object?> get props => [];
}


//! Initial state when app is loaded
class TodoInitial extends TodoState {}


//! Loading state when data is being fetched from the API
class TodoLoading extends TodoState {}


//! State when todos are suxxesfully loaded
class TodoLoaded extends TodoState {
  final List<TodoModel> todos;
  TodoLoaded(this.todos);

  @override
  List<Object?> get props => [todos];
}


//! Empty state when fetched todo list is empty
class TodoEmpty extends TodoState {}



//! Error state in case API Got failure
class TodoError extends TodoState {
  final String message;

  TodoError(this.message);

  @override
  List<Object?> get props => [message];
}


//! State when todo is successfully delted
class TodoDeleted extends TodoState {
  final String message;

  TodoDeleted(this.message);

  @override
  List<Object?> get props => [message];
}
