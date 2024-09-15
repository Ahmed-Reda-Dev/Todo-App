import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_hive/todo_app/view/tasks/widgets/top_text.dart';

import '../../data/hive_data_store.dart';
import '../../models/task.dart';
import 'cubit/tasks_cubit.dart';
import 'cubit/tasks_state.dart';
import 'widgets/bottom_buttons.dart';
import 'widgets/my_appbar.dart';
import 'widgets/text_field_and_date_time.dart';

class TaskView extends StatelessWidget {
  const TaskView({
    super.key,
    required this.task,
  });
  final Task? task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskCubit(HiveDataStore())..initializeTask(task),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          var textTheme = Theme.of(context).textTheme;

          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: const MyAppBar(),
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildTopText(context, textTheme),
                        const BuildMiddleTextFieldsANDTimeAndDateSelection(),
                        buildBottomButtons(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
