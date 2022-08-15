import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/bloc/cubit.dart';
import 'package:todo_app/shared/bloc/states.dart';
import 'package:todo_app/shared/components/components.dart';

class archivedTasks extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    appCubit cubit=appCubit.get(context);
    return BlocConsumer<appCubit,States>(
      builder: (context,State){
        return tasksList(tasks: cubit.ArchivedTasks);
      },
      listener: (context,state){});
    throw UnimplementedError();
  }

}