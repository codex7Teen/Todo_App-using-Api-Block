import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodoModel(
      {required this.id,
      required this.title,
      required this.description,
      this.isCompleted = false});

  // Factory constructor to convert JSON to a TodoModel
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        id: json['_id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['is_completed'] ?? false);
  }

  // Method to convert TodoModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'is_completed': isCompleted
    };
  }

  // Overriding props to enable value comparison for equality checks
  @override
  List<Object?> get props => [id, title, description, isCompleted];
}
