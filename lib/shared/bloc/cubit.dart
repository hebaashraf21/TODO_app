import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/ArchivedTasks/archivedTasks.dart';
import 'package:todo_app/modules/DoneTasks/doneTasks.dart';
import 'package:todo_app/modules/NewTasks/newTasks.dart';
import 'package:todo_app/shared/bloc/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/bloc/states.dart';
import 'package:flutter/material.dart';

class appCubit extends Cubit<States>
{
  appCubit():super(InitialState());
  static appCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  bool isBottomSheetShown=false;
  IconData FloatIcon=Icons.edit;
  late Database db;
  List<Map>NewTasks=[];
  List<Map>DoneTasks=[];
  List<Map>ArchivedTasks=[];

  List<Widget>Screens=[newTasks(),doneTasks(),archivedTasks()];
  List<String>titles=['New tasks','Done tasks','Archived tasks'];

  void ChangeNavBarIndex(int index)
  {
    currentIndex=index;
    emit(ChangeNavBar());
  }

void ChangebottomSheet(
  {
    required bool isShown,
    required IconData icon,
  }
)
{
  isBottomSheetShown=isShown;
  FloatIcon=icon;
}

void CreateDataBase()
{
   openDatabase('todoDB', version: 1,
    onCreate: (Database db, int version) async {
      print("DB created");
  await db.execute(
      'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)').then((value) {
        print("table created");
      }).catchError((err){print("error ${err}");});
},
onOpen:(db){
  GetData(db);
  print("db opened");

}).then((value){
  db=value;
  emit(CreateDB());
});
}


void GetData(Database db)
{
  NewTasks=[];
  DoneTasks=[];
  ArchivedTasks=[];
  db.rawQuery('SELECT * FROM tasks').then((value) {
    emit(GetDatafromDB());
    value.forEach((element) {
      if(element['status']=='new')
      {
        NewTasks.add(element);
      }
      else if(element['status']=='done')
      {
        DoneTasks.add(element);
      }
      else 
      {
        ArchivedTasks.add(element);
      }
    });
  });
}

Future InsertIntoDataBase(
  {
    required String title,
    required String date,
    required String time
  }
)async
{
  return await db.transaction((txn)async {
    return await txn.rawInsert(
      'INSERT INTO tasks(title, time, date, status) VALUES("$title", "$time", "$date","new")').then((value) {
        print("raw inserted");
        emit(InsertIntoDB());
        GetData(db);
        emit(GetDatafromDB());
      }).catchError((err){print("error when insertion $err");});

  });
  
}

void DeleteFromDataBase({required int id})async
{
   db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      emit(DeleteFromDB());
      print("db deleted");
      GetData(db);
    });
}


void UpdateDataBase({
  required int id,
  required String status,
})
{
  db.rawUpdate('UPDATE tasks Set status= ? WHERE id= ?',['$status',id]).then((value){
    print("db updated");
    emit(UpdateDB());
    GetData(db);
    emit(GetDatafromDB());
  });

}

}