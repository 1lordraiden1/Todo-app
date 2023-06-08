import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/shared/cubit/states.dart';

import '../../modules/Archive/archive_screen.dart';
import '../../modules/Done/done_screen.dart';
import '../../modules/task/task_screen.dart';

class cubit extends Cubit<states>{
  cubit() : super(initState());

  static cubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> pages = [
    TaskScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];

  void changeIndex(index){
    currentIndex = index;
    emit(changeNavBarButton());
  }

}