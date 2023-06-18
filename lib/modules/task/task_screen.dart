import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {


  List<Map> Tasks = [];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) =>ListTile(
        title:Text("Go to gym"),
        subtitle: Text("12/12/2012"),
        trailing: Text("02:00 AM"),
      ),

    );
  }


}


