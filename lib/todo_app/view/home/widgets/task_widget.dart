import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/todo_app/view/home/cubit/home_cubit.dart';
import 'package:todo_hive/todo_app/view/home/cubit/home_state.dart';

import '../../../models/task.dart';
import '../../../../core/utils/colors.dart';
import '../../tasks/task_view.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (ctx) => TaskView(
                  task: task,
                ),
              ),
            );
          },

          /// Main Card
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: task.isCompleted
                    ? const Color.fromARGB(154, 119, 144, 229)
                    : Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      offset: const Offset(0, 4),
                      blurRadius: 10)
                ]),
            child: ListTile(

                /// Check icon
                leading: GestureDetector(
                  onTap: () {
                    context.read<HomeCubit>().markTaskAsDone(task);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    decoration: BoxDecoration(
                        color: task.isCompleted
                            ? MyColors.primaryColor
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: .8)),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),

                /// title of Task
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 3),
                  child: Text(
                    task.title,
                    style: TextStyle(
                        color: task.isCompleted
                            ? MyColors.primaryColor
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                ),

                /// Description of task
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.subtitle,
                      style: TextStyle(
                        color: task.isCompleted
                            ? MyColors.primaryColor
                            : const Color.fromARGB(255, 164, 164, 164),
                        fontWeight: FontWeight.w300,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),

                    /// Date & Time of Task
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('hh:mm a').format(task.createdAtTime),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: task.isCompleted
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                            Text(
                              DateFormat.yMMMEd().format(task.createdAtDate),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: task.isCompleted
                                      ? Colors.white
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
