import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Layout/WelcomeScreen.dart';
import 'package:todo_app/Layout/layout.dart';
import 'package:todo_app/shared/bloc/cubit.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch:Colors.deepOrange ,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (context) => appCubit(),
        child: WelcomeScreen(),
      ),
    );
  }
}


