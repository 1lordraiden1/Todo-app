import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Tasks",style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,

      ),
      ),
    );
  }
}
