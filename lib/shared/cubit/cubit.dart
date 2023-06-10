import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/shared/cubit/states.dart';

import '../../modules/Archive/archive_screen.dart';
import '../../modules/Done/done_screen.dart';
import '../../modules/task/task_screen.dart';

late Database DB;

class cubit extends Cubit<states>{
  cubit() : super(initState());

  static cubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Map> tasks = [];

  List<Widget> pages = [
    TaskScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];

  void changeIndex(index){
    currentIndex = index;
    emit(changeNavBarButton());
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
          getDB(DB).then((value){

          });
          print("Database opened");
        }
    );
  }

  void insertinDB(){
    DB.transaction((txn)
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

  Future<List<Map>> getDB(DB) async {
    DB.rawQuery(
        'SELECT * FROM tasks'
    ).then((value) => tasks = value,

    ).catchError((err){
      print('Error on Selecting The records ${err.toString()}');
    });
    return tasks;

  }

}