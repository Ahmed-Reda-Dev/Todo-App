import '../../../models/task.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Task> tasks;

  const HomeLoaded(this.tasks);
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
