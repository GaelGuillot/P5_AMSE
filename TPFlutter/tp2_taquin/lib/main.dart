import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tp2_taquin/src/library.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          for (int i = 0; i < libraryInstance.allExercises.length; i++) 
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(
                    libraryInstance.getExercise(i).title,
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    libraryInstance.getExercise(i).description,
                    style: TextStyle(
                      fontSize: 14, 
                      color: Colors.grey, 
                    ),
                  ),
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
      ),
    );
  }
}


