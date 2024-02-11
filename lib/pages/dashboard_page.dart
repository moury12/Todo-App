import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constant/assets_constant.dart';
import 'package:to_do_list/controller/task_controller.dart';
import 'package:to_do_list/pages/edit_task_page.dart';
import 'package:to_do_list/pages/settings/settings_page.dart';
import 'package:to_do_list/pages/widgets/widget.dart';
import 'package:to_do_list/theme/app_colors.dart';
import 'package:to_do_list/theme/text_theme.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        await openDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(SettingsScreen.routeName);
            },
            icon: const Icon(Icons.settings),
          ),
        ]),
        body: Obx(() {
          return RefreshIndicator(
            onRefresh: () async {
              await TaskController.to.getTask();
            },
            child: ListView.builder(
              itemCount: TaskController.to.taskList.length,
              itemBuilder: (context, index) {
                var task = TaskController.to.taskList[index];
                return TaskController.to.taskList.isEmpty
                    ? const Center(
                        child: Text('There is no task...'),
                      )
                    : ListTile(
                  onTap: () {
                    if(task.description!.isEmpty||task.reminderDateTime!.isEmpty||task.dueDateTime!.isEmpty||task.priorityTitle!.isEmpty){
                      Get.toNamed(EditTaskScreen.routeName);
                 }
                  },
                        title: Text(
                          task.title,
                          style: const TextStyle(color: Colors.black),
                        ),
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            task.isCompleted=value!;
                            TaskController.to.updateTask(
                              task,
                            );
                           /* task.isCompleted=true;
                            TaskController.to.updateTask(task);*/
                          },
                        ),
                      );
              },
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                useSafeArea: true,
                builder: (context) {
                  return const AddTaskTitleWidget();
                },
              );
            },
            child: const Icon(Icons.add)),
      ),
    );
  }

  Future<void> openDialog(BuildContext context) async {
    switch (await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          surfaceTintColor: Colors.white,
          clipBehavior: Clip.hardEdge,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  children: [
                    Image.asset(
                      AssetsConstant.logoIcon,
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Obx(() {
                        return Text(
                          'Are you sure you want to exit?',
                          style: TextCustomTheme.textSemiBold14,
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0)
                  .copyWith(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton.extended(
                      backgroundColor: AppColors.kPrimaryColor,
                      onPressed: () {
                        Navigator.pop(context, 0);
                      },
                      label: const SizedBox(
                          width: 70,
                          child: Text(
                            'No',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ))),
                  FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, 1);
                      },
                      label: const SizedBox(
                          width: 70,
                          child: Text(
                            'Yes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kPrimaryColor),
                          ))),
                ],
              ),
            )
          ],
        );
      },
    )) {
      case 0:
        break;
      case 1:
        exit(0);
    }
  }
}


