import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/database/db_helper.dart';
import 'package:to_do_list/model/task_model.dart';

class TaskController extends GetxController {
  @override
  void onClose() {
    titleController.dispose();
    taskDescriptionController.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    await getTask();
    taskList.refresh();
    super.onInit();
  }

  static TaskController get to => Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  RxString errorMsg = ''.obs;
  RxList<TaskPriority> taskPriorityList = <TaskPriority>[
    TaskPriority(title: 'Normal', color: Colors.greenAccent, isSelected: true),
    TaskPriority(
      title: 'Normal',
      color: Colors.greenAccent,
    ),
    TaskPriority(
      title: 'Normal',
      color: Colors.greenAccent,
    ),
  ].obs;
  RxList<TaskModel> taskList = <TaskModel>[].obs;
  Future<void> addTask(TaskModel task) async {
    try {
      var taskId = await DBHelper.insertTask(task);
      taskId = task.id!;
      taskList.add(task);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getTask() async {
    try {
      taskList.value = await DBHelper.getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await DBHelper.updateTask(task);
      final index = taskList.indexWhere((e) => e.id == task.id);
      if (index != -1) {
        taskList[index] = task;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      await DBHelper.deleteTask(id);
      taskList.removeWhere((e) => e.id == id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> pickDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (pickedTime != null) {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }
}
