import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/strings.dart';
import '../cubit/tasks_cubit.dart';

Padding buildBottomButtons(BuildContext context) {
  final taskCubit = context.read<TaskCubit>();
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: !taskCubit.isTaskAlreadyExistBool(
              taskCubit.task?.title, taskCubit.task?.subtitle)
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceEvenly,
      children: [
        !taskCubit.isTaskAlreadyExistBool(taskCubit.titleController!.text,
                taskCubit.subtitleController!.text)
            ? Container()
            : Container(
                width: 150,
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minWidth: 150,
                  height: 55,
                  onPressed: () async {
                    taskCubit.deleteTask(taskCubit.task!);
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  child: const Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: MyColors.primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        MyString.deleteTask,
                        style: TextStyle(
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          minWidth: 150,
          height: 55,
          onPressed: () async {
            taskCubit.isTaskAlreadyExistUpdateTask(context);
          },
          color: MyColors.primaryColor,
          child: Text(
            !taskCubit.isTaskAlreadyExistBool(taskCubit.titleController!.text,
                    taskCubit.subtitleController!.text)
                ? MyString.addTaskString
                : MyString.updateTaskString,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
