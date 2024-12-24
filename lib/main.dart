import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/bloc/task_bloc.dart';
import 'app/bloc/task_event.dart';
import 'app/pages/tasks_pages.dart';
import 'app/repositories/task_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializamos o TaskRepository e o injetamos no TaskBloc
    final taskRepository = TaskRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(taskRepository)..add(LoadTasks()), // Carrega as tarefas ao iniciar
        ),
      ],
      child: MaterialApp(
        title: 'Lista de Tarefas',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: const TaskScreen(), // Tela inicial
      ),
    );
  }
}
