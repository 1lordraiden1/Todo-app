

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/modules/Archive/archive_screen.dart';
import 'package:todo_list/modules/Done/done_screen.dart';
import 'package:todo_list/modules/task/task_screen.dart';
import 'package:todo_list/shared/cubit/cubit.dart';
import 'package:todo_list/shared/cubit/states.dart';

Database? DB;


class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit,states >(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, state) {

          cubit c = cubit.get(context);


          return Scaffold(
            appBar: AppBar(
              title: Text("Todo App"),
            ),
            body: c.pages[c.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: (){

              },
              child: Icon(
                Icons.add,
              ),

            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: c.currentIndex,
              elevation: 0,
              onTap: (index){

                c.changeIndex(index);

              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.task_outlined), label: "Tasks"),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline_outlined), label: "Done"),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: "Archive"),
              ],
            ),
          );
        },

      ),
    );
  }


}











void createDB() async
{
  DB = await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (DB,version) {
      print("Database created");
      DB.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT,state TEXT)').then((value)
      {
        print("Table created");
      }).catchError((error)
      {
        print("Error on Creating table");
      });
    },
    onOpen:(DB) {
      print("Database opened");
    }
  );
}

void insertinDB(){
  DB?.transaction((txn)
  {
    txn.rawInsert('INSERT INTO tasks(title,date,time,state) VALUES("first task","20/10/23","10:30 pm","New")'
    ).then((value) {
      print('$value inserted successfully');
    }).catchError((error)
    {
      print('Error on Inserting new record ${error.toString()}');
    });
    return Future(()async =>await null);
  });
}
