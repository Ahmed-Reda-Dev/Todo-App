import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../data/hive_data_store.dart';
import '../../../models/task.dart';
import '../../../../core/utils/constanst.dart';
import 'tasks_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final HiveDataStore dataStore;

  TaskCubit(this.dataStore) : super(TaskInitial()) {
    titleController = TextEditingController();
    subtitleController = TextEditingController();
  }

  TextEditingController? titleController;
  TextEditingController? subtitleController;
  DateTime? time;
  DateTime? date;
  Task? task;

  @override
  Future<void> close() {
    titleController!.dispose();
    subtitleController!.dispose();
    return super.close();
  }

  void initializeTask(Task? task) {
    titleController!.text = task?.title ?? "";
    subtitleController!.text = task?.subtitle ?? "";
    this.task = task;
    time = task?.createdAtTime;
    date = task?.createdAtDate;
  }

  void loadTasks() async {
    emit(TaskLoading());
    try {
      List<Task> tasks = await dataStore.getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(const TaskError("Failed to load tasks"));
    }
  }

  void addTask(String title, String subtitle, DateTime? time, DateTime? date) {
    if (title.isNotEmpty && subtitle.isNotEmpty) {
      var task = Task.create(
        title: title,
        createdAtTime: time,
        createdAtDate: date,
        subtitle: subtitle,
      );
      dataStore.addTask(task: task);
      loadTasks(); // Reload tasks after adding a new one
    } else {
      emit(const TaskError("Title and subtitle cannot be empty"));
    }
  }

  void updateTask(Task task, String title, String subtitle, DateTime? time,
      DateTime? date) {
    if (title.isNotEmpty && subtitle.isNotEmpty) {
      task.title = title;
      task.subtitle = subtitle;
      task.createdAtTime = time!;
      task.createdAtDate = date!;
      task.save();
      loadTasks(); // Reload tasks after updating
    } else {
      emit(const TaskError("Title and subtitle cannot be empty"));
    }
  }

  void deleteTask(Task task) {
    task.delete();
    loadTasks();
  }

  String showTime(DateTime? time) {
    if (time == null) {
      return DateFormat('hh:mm a').format(DateTime.now()).toString();
    } else {
      return DateFormat('hh:mm a').format(time).toString();
    }
  }

  String showDate(DateTime? date) {
    if (date == null) {
      return DateFormat.yMMMEd().format(DateTime.now()).toString();
    } else {
      return DateFormat.yMMMEd().format(date).toString();
    }
  }

  bool isTaskAlreadyExistBool(String? title, String? subtitle) {
    return task != null;
  }

  void isTaskAlreadyExistUpdateTask(BuildContext context) {
    if (titleController!.text.isNotEmpty &&
        subtitleController!.text.isNotEmpty) {
      if (task != null) {
        try {
          updateTask(
            task!,
            titleController!.text,
            subtitleController!.text,
            time,
            date,
          );
        } catch (error) {
          nothingEnterOnUpdateTaskMode(context);
          emit(const TaskError("Failed to update task"));
        }
      } else {
        try {
          addTask(
            titleController!.text,
            subtitleController!.text,
            time,
            date,
          );
        } catch (error) {
          emptyFieldsWarning(context);
          emit(const TaskError("Failed to add task"));
        }
      }
      Navigator.of(context).pop();
    } else {
      emptyFieldsWarning(context);
      emit(const TaskError("Title and subtitle cannot be empty"));
    }
  }

  void setTime(DateTime newTime) {
    final now = DateTime.now();
    time = DateTime(now.year, now.month, now.day, newTime.hour, newTime.minute);
    emit(TaskTimeUpdated(time!));
  }

  void setDate(DateTime newDate) {
    date = newDate;
    emit(TaskDateUpdated(date!));
  }
}
