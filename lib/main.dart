import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_api_block/repositories/todo_repository.dart';
import 'package:todo_app_api_block/screens/splash_screen.dart';
import 'package:todo_app_api_block/services/api_services.dart';
import 'package:todo_app_api_block/theme_block/theme_bloc.dart';
import 'package:todo_app_api_block/todo_bloc/todo_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // getting instance of apiservices and passing to todoRepository.
    final ApiServices apiServices = ApiServices();
    final TodoRepository todoRepository = TodoRepository(apiServices);

    return MultiBlocProvider(
      providers: [
        // To-do Bloc
        BlocProvider(
          create: (context) => TodoBloc(todoRepository)..add(FetchTodos()),
        ),
        // Theme Bloc
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // allowing the theme-bloc to decide the app theme
            theme: themeState.themeData,
            title: 'Todo_App_Using_Api & Block',
            home: const ScreenSplash(),
          );
        },
      ),
    );
  }
}
