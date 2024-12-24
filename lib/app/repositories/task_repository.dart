import 'package:shared_preferences/shared_preferences.dart';

import '../model/task_model.dart';

class TaskRepository {
  static const _tasksKey = 'tasks';

  Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey) ?? [];
    return tasksJson.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    await prefs.setStringList(_tasksKey, tasksJson);
  }

  Future<void> cleanTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
