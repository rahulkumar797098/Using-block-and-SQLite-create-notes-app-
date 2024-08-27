import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:using_bloc_notes_app/bloc/notes_bloc.dart';
import 'package:using_bloc_notes_app/database/db_helper.dart';
import 'package:using_bloc_notes_app/screen/notes_home_screen.dart';

void main() {
  final db = DBHelper.instance;
  runApp(
      BlocProvider(
        create: (context) => NotesBloc(db: db),
        child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotesHomeScreen(), // Using const here for better performance
    );
  }
}
