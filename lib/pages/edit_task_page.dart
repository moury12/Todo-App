import 'package:flutter/material.dart';
import 'package:mh_ui/mh_ui.dart';

class EditTaskScreen extends StatelessWidget {
static const String routeName ='/edit-task';
  const EditTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: [
CustomTextField(hintText: 'Task Description',)
      ],),
    );
  }
}
