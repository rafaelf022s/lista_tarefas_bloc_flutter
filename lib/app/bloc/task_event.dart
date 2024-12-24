import '../model/task_model.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final TaskModel task;
  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskModel task;
  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskName; // Usando o nome como identificador
  DeleteTask(this.taskName);
}
