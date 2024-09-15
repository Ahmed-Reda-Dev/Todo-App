import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/colors.dart';

Widget datePickerWidget(DateTime tempPickedDate, BuildContext context) {
  return Container(
    height: 270,
    color: Colors.white,
    child: Column(
      children: [
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now().add(
              const Duration(minutes: 30),
            ),
            minimumDate: DateTime.now(),
            maximumDate: DateTime(2030, 3, 5),
            onDateTimeChanged: (DateTime newDate) {
              tempPickedDate = newDate;
            },
          ),
        ),
        CupertinoButton(
          child: const Text('Done',
              style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 20,
              )),
          onPressed: () {
            Navigator.of(context).pop(tempPickedDate);
          },
        ),
      ],
    ),
  );
}
