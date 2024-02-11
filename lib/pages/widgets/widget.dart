import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mh_ui/mh_ui.dart';
import 'package:to_do_list/controller/task_controller.dart';
import 'package:to_do_list/model/task_model.dart';
import 'package:to_do_list/pages/settings/controller/settings_controller.dart';

class AddTaskTitleWidget extends StatelessWidget {
  const AddTaskTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        TaskController.to.titleController.clear();
        TaskController.to.errorMsg.value = '';
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
            height: 230,
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        TaskController.to.errorMsg.value = '';
                      }
                    },
                    errorColor: Colors.pink,
                    errorMessage:
                    TaskController.to.errorMsg.value.isEmpty
                        ? null
                        : TaskController.to.errorMsg.value,
                    controller: TaskController.to.titleController,
                    hintColor:
                    SettingsController.to.isLightMode.value
                        ? Colors.white
                        : Colors.black87,
                    hintText: 'Enter your task title...',
                    maxLine: 3,
                    height: 80,
                    marginVertical: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        if (TaskController
                            .to.titleController.text.isNotEmpty) {
                          TaskController.to.addTask(TaskModel(
                              title: TaskController
                                  .to.titleController.text));
                          TaskController.to.titleController
                              .clear();
                          TaskController.to.errorMsg.value = '';
                        } else {
                          TaskController.to.errorMsg.value =
                          "Please Insert Title!!";
                        }
                      },
                      child: const Icon(Icons.done),
                    ),
                  )
                ],
              );
            })),
      ),
    );
  }
}