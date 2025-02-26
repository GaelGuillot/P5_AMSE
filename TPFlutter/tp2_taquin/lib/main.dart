//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:tp2_taquin/src/library.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Rotate/Resize image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: 
          ListView(
            children: [
              for (int i = 0; i < libraryInstance.allExercises.length; i++) 
                ListTile(
                  title: Column(
                    children: [
                      Text(libraryInstance.getExercise(i).title),
                      Icon(Icons.hive),
                    ],
                  ),
                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => libraryInstance.getExercise(i).widget,
                      ),
                    );
                  }
                )
            ],
          )

      ),
    );
  }
}
