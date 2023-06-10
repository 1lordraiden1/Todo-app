

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/modules/Archive/archive_screen.dart';
import 'package:todo_list/modules/Done/done_screen.dart';
import 'package:todo_list/modules/task/task_screen.dart';
import 'package:todo_list/shared/cubit/cubit.dart';
import 'package:todo_list/shared/cubit/states.dart';

bool isBottomSheet = false;

class HomeLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  String x = "0123456789";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit,states >(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, state) {

          cubit c = cubit.get(context);


          return Scaffold(

            key: scaffoldKey,
            appBar: AppBar(
              title: Text("Todo App"),
            ),

            body: c.pages[c.currentIndex],
            floatingActionButton: FloatingActionButton(

              onPressed: (){

                if(isBottomSheet){
                  if(formKey.currentState!.validate()){
                    Navigator.pop(context);
                    isBottomSheet = false;
                  }
                }
                else{
                  scaffoldKey.currentState?.showBottomSheet(
                          (context) => Form(
                            key: formKey,
                            child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            TextFormField(
                              controller: titleController,

                              validator: (dynamic value){
                                if(value.toString().isEmpty) {
                                  return 'Enter Title';
                                }


                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(

                                label: Text('Task title'),
                                prefix: Icon(Icons.abc_outlined),

                              ),

                            ),
                            TextFormField(
                              controller: timeController,


                              keyboardType: TextInputType.datetime,
                              onTap: (){
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                ).then((dynamic value){
                                  timeController.text = value.format(context).toString();
                                  print(value.format(context));
                                });
                              },
                              validator: (dynamic value){
                                if(value.toString().isEmpty) {
                                  return 'Enter Time';
                                }


                              },


                              decoration: InputDecoration(

                                label: Text('Task Time'),
                                prefix: Icon(Icons.watch_later_outlined,size: 25,),

                              ),

                            ),
                            TextFormField(
                              controller: dateController,

                              validator: (dynamic value){
                                if(value.toString().isEmpty) {
                                  return 'Enter Date';
                                }


                              },
                              onTap: (){
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2024)).then((value){
                                      dateController.text = value.toString().substring(0,10);

                                });
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(

                                label: Text('Task Date'),
                                prefix: Icon(Icons.calendar_month_outlined),

                              ),

                            ),
                        ],
                      ),
                          )
                  );
                  isBottomSheet = true;
                }
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














