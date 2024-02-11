import 'package:flutter/material.dart';
import 'package:mh_ui/mh_ui.dart';
import 'package:to_do_list/controller/task_controller.dart';
import 'package:to_do_list/theme/app_colors.dart';

class EditTaskScreen extends StatelessWidget {
  static const String routeName = '/edit-task';
  const EditTaskScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Task'),
      ),
      body: Column(
        children: [
          CustomTextField(
            hintText: 'Task Description',
            labelText: 'Description',
            controller: TaskController.to.taskDescriptionController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                      color: AppColors.kPrimaryColor.withOpacity(.1)),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(
                        'due date',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      Row(children: [
                        Icon(Icons.date_range_rounded),
                        Text()
                      ],)
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomButton(
            label: 'Pick Date and Time',
            onPressed: () => _pickDateTime(context),
          )
        ],
      ),
    );
  }
}
