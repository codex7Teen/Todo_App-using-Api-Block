import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_api_block/model/todo_model.dart';
import 'package:todo_app_api_block/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc(this.todoRepository) : super(TodoInitial()) {
    //! Handling Fetch todo event
    on<FetchTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await todoRepository.fetchTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError('Failed to fetch Todos...'));
      }
    });

    //! Handling Adding a new todo event
    on<AddTodo>((event, emit) async {
      try {
        await todoRepository.addTodo(event.todo);
        add(FetchTodos());
      } catch (e) {
        emit(TodoError('Failed to add todo'));
      }
    });

    //! Handling Updating a todo event
    on<UpdateTodo>((event, emit) async {
      try {
        await todoRepository.updateTodoById(event.todo);
        add(FetchTodos());
      } catch (e) {
        emit(TodoError('Failed to update Todo...'));
      }
    });

    //! Handling Deleting a todo event
    on<DeleteTodo>((event, emit) async {
      try {
      await todoRepository.deleteTodoById(event.id);
      add(FetchTodos());
      } catch (e) {
        emit(TodoError('Failed to delte Todo...'));
      }
    });


  }
}
