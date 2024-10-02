import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // Default to dark theme
  ThemeBloc() : super(ThemeState(ThemeData.dark())) {
    on<ToggleTheme>((event, emit) {
      // Toggle between light and dark
      if (state.themeData.brightness == Brightness.dark) {
        emit(ThemeState(ThemeData.light()));
      } else {
        emit(ThemeState(ThemeData.dark()));
      }
    });
  }
}
