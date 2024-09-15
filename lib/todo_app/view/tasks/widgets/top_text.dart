import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/strings.dart';
import '../cubit/tasks_cubit.dart';

/// new / update Task Text
SizedBox buildTopText(BuildContext context, TextTheme textTheme) {
  return SizedBox(
    width: double.infinity,
    height: 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 70,
          child: Divider(
            thickness: 2,
          ),
        ),
        RichText(
          text: TextSpan(
              text: context.read<TaskCubit>().isTaskAlreadyExistBool(
                      context.read<TaskCubit>().titleController!.text,
                      context.read<TaskCubit>().subtitleController!.text)
                  ? MyString.updateCurrentTask
                  : MyString.addNewTask,
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: MyString.taskStrnig,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                )
              ]),
        ),
        const SizedBox(
          width: 70,
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    ),
  );
}
