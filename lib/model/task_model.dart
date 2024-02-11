import 'dart:ui';

class TaskModel {
   int? id;
   String title;
   String? description;
   String? dueDateTime;
   String? priorityTitle;
   Color? color;
/*   Color? priorityColor;*/
   String? reminderDateTime;
   bool isCompleted;
   bool isRunning;
   bool isExpired;

  TaskModel(
      {  this.id,
      this.color,
      this.priorityTitle,
    /*  this.priorityColor,*/
      this.dueDateTime,
      this.reminderDateTime,
      this.isRunning=false,
      this.isExpired=false,
      required this.title,
      this.description,
      this.isCompleted=false});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description??'',
      'due_date_time': dueDateTime??'',
      'priority_title': priorityTitle??'',
      /*'priority_color': priorityColor??0x00000000,*/ // Store color as integer
      'reminder_date_time': reminderDateTime??'',
      'is_completed': isCompleted ? 1 : 0,
      'is_running': isRunning ? 1 : 0,
      'is_expired': isExpired ? 1 : 0,
    };
  }
}

class TaskPriority {
  final String title;
  final Color color;
  final bool? isSelected;

  TaskPriority({required this.title, required this.color, this.isSelected});
}
