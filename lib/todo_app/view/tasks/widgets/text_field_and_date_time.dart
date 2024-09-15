import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/strings.dart';
import '../cubit/tasks_cubit.dart';
import '../cubit/tasks_state.dart';
import 'custom_text_form_field.dart';
import 'date_picker_widget.dart';
import 'time_picker_widget.dart';

class BuildMiddleTextFieldsANDTimeAndDateSelection extends StatelessWidget {
  const BuildMiddleTextFieldsANDTimeAndDateSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCubit = context.read<TaskCubit>();
    return SizedBox(
      width: double.infinity,
      height: 535,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(MyString.titleOfTitleTextField,
                style: const TextTheme().headlineMedium),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: CustomTextFormField(
                controller: taskCubit.titleController!,
                hintText: '',
                maxLines: 6,
                cursorHeight: 60,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              title: TextFormField(
                controller: taskCubit.subtitleController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.bookmark_border, color: Colors.grey),
                  border: InputBorder.none,
                  counter: Container(),
                  hintText: MyString.addNote,
                ),
                onFieldSubmitted: (value) {
                  taskCubit.subtitleController!.text = value;
                },
                onChanged: (value) {
                  taskCubit.subtitleController!.text = value;
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return timePickerWidget(taskCubit, context);
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(MyString.timeString,
                        style: const TextTheme().headlineSmall),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade100),
                    child: Center(
                      child: BlocBuilder<TaskCubit, TaskState>(
                        builder: (context, state) {
                          return Text(
                            taskCubit.showTime(taskCubit.time),
                            style: Theme.of(context).textTheme.titleSmall,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final selectedDate = await showCupertinoModalPopup<DateTime>(
                context: context,
                builder: (BuildContext context) {
                  DateTime tempPickedDate = DateTime.now();
                  return datePickerWidget(tempPickedDate, context);
                },
              );

              if (selectedDate != null) {
                taskCubit.setDate(selectedDate);
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(MyString.dateString,
                        style: const TextTheme().headlineSmall),
                  ),
                  Expanded(child: Container()),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 140,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade100),
                    child: Center(
                      child: BlocBuilder<TaskCubit, TaskState>(
                        builder: (context, state) {
                          return Text(
                            taskCubit.showDate(taskCubit.date),
                            style: Theme.of(context).textTheme.titleSmall,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
