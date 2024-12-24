import 'dart:convert';

import 'package:intl/intl.dart';

class TaskModel {
  final String nameTask;
  final String description;
  bool completed;
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
      'dateCreated': dateCreated.millisecondsSinceEpoch, // Para armazenamento
      'dateComplete': dateComplete?.millisecondsSinceEpoch, // Para armazenamento
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      nameTask: map['nameTask'],
      description: map['description'],
      completed: map['completed'],
      dateCreated: DateTime.fromMillisecondsSinceEpoch(map['dateCreated']),
      dateComplete: map['dateComplete'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dateComplete']) : null,
    );
  }

  // Converter para JSON (opcional, mas útil para depuração)
  String toJson() => json.encode(toMap());

  // Criar TaskModel a partir de JSON
  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source));

  /// Formata a data no formato DD/MM/AAAA
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  /// Formata a data de criação
  String get formattedDateCreated => formatDate(dateCreated);

  /// Formata a data de conclusão (se existir)
  String? get formattedDateComplete => dateComplete != null ? formatDate(dateComplete!) : null;
}
