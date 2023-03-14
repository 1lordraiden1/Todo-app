import 'package:flutter/material.dart';
import 'package:todo_list/modules/Archive/archive_screen.dart';
import 'package:todo_list/modules/Done/done_screen.dart';
import 'package:todo_list/modules/task/task_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  int currentIndex = 0;

  List<Widget> pages = [
    TaskScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
          Icons.add,
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        elevation: 0,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.task_outlined), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline_outlined), label: "Done"),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: "Archive"),
        ],
      ),
    );
  }
}
