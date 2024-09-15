import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/hive_data_store.dart';
import '../../../models/task.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HiveDataStore dataStore;

  HomeCubit(this.dataStore) : super(HomeInitial());

  void loadTasks() async {
    emit(HomeLoading());
    try {
      // Fetch tasks from the data store
      List<Task> tasks = await dataStore.getTasks();
      tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));
      emit(HomeLoaded(tasks));
    } catch (e) {
      emit(const HomeError("Failed to load tasks"));
    }
  }

  int checkDoneTask(List<Task> tasks) {
    return tasks.where((task) => task.isCompleted).length;
  }

  void markTaskAsDone(Task task) {
    task.isCompleted = !task.isCompleted;
    task.save();
    loadTasks(); // Reload tasks after marking as done
  }

  dynamic valueOfTheIndicator(List<Task> tasks) {
    return tasks.isNotEmpty ? tasks.length : 3;
  }

  void deleteTask(Task task) {
    task.delete();
    loadTasks(); // Reload tasks after deleting
  }

  void deleteAllTasks() async{
    await dataStore.deleteAllTasks();
    loadTasks(); // Reload tasks after deleting all
  }
}
