import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/task_model.dart';
import '../repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      try {
        final tasks = await repository.getTasks();
        emit(TaskLoaded(tasks));
      } catch (e, s) {
        log('error: $e, stacktrace $s');
        emit(TaskError('Falha ao ler as tarefas'));
      }
    });

    on<AddTask>((event, emit) async {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = List<TaskModel>.from(currentState.tasks)..add(event.task);
        await repository.saveTasks(updatedTasks);
        emit(TaskLoaded(updatedTasks));
      }
    });

    on<UpdateTask>((event, emit) async {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = currentState.tasks.map((task) {
          return task.nameTask == event.task.nameTask ? event.task : task;
        }).toList();
        await repository.saveTasks(updatedTasks);
        emit(TaskLoaded(updatedTasks));
      }
    });

    on<DeleteTask>((event, emit) async {
      if (state is TaskLoaded) {
        final currentState = state as TaskLoaded;
        final updatedTasks = currentState.tasks.where((task) => task.nameTask != event.taskName).toList();
        await repository.saveTasks(updatedTasks);
        emit(TaskLoaded(updatedTasks));
      }
    });
  }
}
