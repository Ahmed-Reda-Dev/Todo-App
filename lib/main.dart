import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/core/utils/theme.dart';
import 'package:todo_hive/todo_app/view/home/cubit/home_cubit.dart';

import 'todo_app/data/hive_data_store.dart';
import 'todo_app/models/task.dart';
import 'todo_app/view/home/home_view.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  /// Initial Hive DB
  await Hive.initFlutter();

  /// Register Hive Adapter
  Hive.registerAdapter<Task>(TaskAdapter());

  /// Open box
  var box = await Hive.openBox<Task>("tasksBox");

  /// Delete data from previous day
  for (var task in box.values) {
    if (task.createdAtTime.day != DateTime.now().day) {
      task.delete();
    } else {}
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hive Todo App',
      theme: themeData,
      navigatorObservers: [routeObserver],
      home: BlocProvider(
        create: (context) => HomeCubit(HiveDataStore())..loadTasks(),
        child: const HomeView(),
      ),
    );
  }
}
