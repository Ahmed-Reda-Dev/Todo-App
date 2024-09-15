import '../../../models/task.dart';

sealed class TaskState {
  const TaskState();
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);
}

class TaskTimeUpdated extends TaskState {
  final DateTime time;

  const TaskTimeUpdated(this.time);
}

class TaskDateUpdated extends TaskState {
  final DateTime date;

  const TaskDateUpdated(this.date);
}


