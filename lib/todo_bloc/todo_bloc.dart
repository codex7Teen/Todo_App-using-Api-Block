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
        // this is to show the circular indicator in submit button till data gets fetched
        emit(TodoAddingUpdating());
        final todos = await todoRepository.fetchTodos();

        if (todos.isEmpty) {
          // Emit empty state if there are no todos
          emit(TodoEmpty());
        } else {
          // load all the todo list to todoloaded state
          emit(TodoLoaded(todos));
        }
      } catch (e) {
        emit(TodoError('Failed to fetch Todos...'));
      }
    });

    //! Handling Adding a new todo event
    on<AddTodo>((event, emit) async {
      emit(TodoAddingUpdating());
      try {
        await todoRepository.addTodo(event.todo);
        add(FetchTodos());
      } catch (e) {
        emit(TodoError('Failed to add todo ! 🙁'));
      }
    });

    //! Handling Updating a todo event
    on<UpdateTodo>((event, emit) async {
      emit(TodoAddingUpdating());
      try {
        await todoRepository.updateTodoById(event.todo);
        add(FetchTodos());
      } catch (e) {
        emit(TodoError('Failed to update Todo ! 🙁'));
      }
    });

    //! Handling Deleting a todo event
    on<DeleteTodo>((event, emit) async {
      try {
        await todoRepository.deleteTodoById(event.id);
        emit(TodoDeleted("Todo deleted successfully! ✔️"));
        add(FetchTodos());
      } catch (e) {
        emit(TodoError('Failed to delte Todo...'));
      }
    });
  }
}
