
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/bloc/states.dart';
import 'package:todo_app/shared/components/components.dart';

import '../shared/bloc/cubit.dart';


class layout extends StatelessWidget {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var Scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => appCubit()..CreateDataBase(),
      child: BlocConsumer<appCubit, States>(
        listener: (context, status) {
          if (status is InsertIntoDB) {
            Navigator.pop(context);
          }
        },
        builder: (context, status) {
          appCubit cubit = appCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            key: Scaffoldkey,
            appBar: AppBar(
              leading: BackButton(
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.deepOrange,
              elevation: 0.1,
              title: Text(
                'To-do',
                style: TextStyle(color: Colors.white),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (Scaffoldkey.currentState != null &&
                      formkey.currentState != null &&
                      formkey.currentState!.validate()) {
                    cubit.InsertIntoDataBase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text);
                  }
                } else {
                  
                  cubit.isBottomSheetShown = true;
                  Scaffoldkey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defaultTextFormField(
                                    validator: ( value) {
                                      if (value!.isEmpty) {
                                        return 'Tasks Must be not  empty';
                                      }
                                      return null;
                                    },
              
                                    controller: titleController,
                                    keyboaredType: TextInputType.text,
                                    Label: 'Tasks title',
                                    prefix: Icons.title,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defaultTextFormField(

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Date Must be not empty';
                                      }
                                      return null;
                                    },
                                    controller: dateController,
                                    keyboaredType: TextInputType.datetime,
                                    Label: 'Date',
                                    prefix: Icons.calendar_month,
                                    ontap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2030-01-01'))
                                          .then((value) => {
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!),
                                              });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),


                                  child: defaultTextFormField(
                                    validator: ( value) {
                                      if (value!.isEmpty) {
                                        return 'time must be not empty';
                                      }
                                      return null;
                                    },

                                    controller: timeController,
                                    keyboaredType: TextInputType.datetime,
                                    Label: 'Date',
                                    prefix: Icons.watch,
                                    ontap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then(
                                        (value) => {
                                          print(value!.format(context)),
                                          timeController.text =
                                              value.format(context).toString(),
                                        },
                                      );
                                    }, 
                                  ),
                                ),
                                /////
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.ChangebottomSheet(isShown: false, icon: Icons.edit);
                  });
                  cubit.ChangebottomSheet(isShown: true, icon: Icons.add);
                }
              }, ////

              child: Icon(
                cubit.FloatIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 20.0,
              elevation: 15.0,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeNavBarIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.table_rows_sharp),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
            body: cubit.Screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}



