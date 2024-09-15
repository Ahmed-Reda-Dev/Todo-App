import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';
import '../cubit/tasks_cubit.dart';

Widget timePickerWidget(TaskCubit taskCubit, BuildContext context) {
  return Container(
    height: 270,
    color: Colors.white,
    child: Column(
      children: [
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: taskCubit.time ?? DateTime.now(),
            onDateTimeChanged: (DateTime newTime) {
              taskCubit.setTime(newTime);
            },
          ),
        ),
        CupertinoButton(
          child: const Text(
            'Done',
            style: TextStyle(
              color: MyColors.primaryColor,
              fontSize: 20,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
