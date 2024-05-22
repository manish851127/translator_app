import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:translator_app/langauge_tranlation.dart';

void main() async{
  // Initialize hive
  await Hive.initFlutter();

  //create a box

  var box = await Hive.openBox('testBox');



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Translator(),
    );
  }
}




