import 'dart:convert';

class TaskModel {
  final String nameTask;
  final String description;
  final bool completed;
  final DateTime dateCreated;
  final DateTime? dateComplete;

  TaskModel({
    required this.nameTask,
    required this.description,
    required this.completed,
    required this.dateCreated,
    this.dateComplete,
  });

  Map<String, dynamic> toMap() {
    return {
      'nameTask': nameTask,
      'description': description,
      'completed': completed,
      'dateCreated': dateCreated.toIso8601String(),
      'dateComplete': dateComplete?.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      nameTask: map['nasmeTask'],
      description: map['description'],
      completed: map['completed'],
      dateCreated: map['dateCreated'],
    );
  }

   // Converter para JSON (opcional, mas útil para depuração)
  String toJson() => json.encode(toMap());

  // Criar TaskModel a partir de JSON
  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source));
}
