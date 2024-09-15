import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/task.dart';

class HiveDataStore {

  

  static const boxName = "tasksBox";
  final Box<Task> box = Hive.box<Task>(boxName);

  /// Add new Task
  Future<void> addTask({required Task task}) async {
    debugPrint("Task: $task");
    await box.put(task.id, task);
  }

  /// Show task
  Future<Task?> getTask({required String id}) async {
    debugPrint("Task ID: $id");
    return box.get(id);
  }

  /// Fetch all tasks
  Future<List<Task>> getTasks() async {
    debugPrint("Tasks: ${box.values.toList()}");
    return box.values.toList();
  }

  /// Update task
  Future<void> updateTask({required Task task}) async {
    debugPrint("Task: $task");
    await task.save();
  }

  /// Delete task
  Future<void> deleteTask({required Task task}) async {
    debugPrint("Task: $task");
    await task.delete();
  }

  /// Delete all tasks
  Future<void> deleteAllTasks() async {
    debugPrint("Tasks: ${box.values.toList()}");
    await box.clear();
  }

  ValueListenable<Box<Task>> listenToTask() {
    debugPrint("Tasks: ${box.listenable()}");
    return box.listenable();
  }
}
