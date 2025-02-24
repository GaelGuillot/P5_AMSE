import 'package:flutter/material.dart';
import 'dart:math' as math;

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
<<<<<<< HEAD

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      Text("e"),
=======
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Taquin'),
>>>>>>> fd9a0f1eda11112bbdf12a13727762938fd14058
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
  double _sliderX = 0.5;
  double _sliderZ = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
               title: Text(widget.title),
      ),
      body: Center(
        child: 
        Column(
          children: [
            SafeArea(
              child: Transform(
                transform: Matrix4.identity()..rotateZ(_sliderZ/2*math.pi)..rotateX(_sliderX/2*math.pi),
                child: const Image(
                    height: 300,
                    image: NetworkImage('https://picsum.photos/512/1024'),
                  ),
              ),
            ),
            Slider(value: _sliderX, onChanged: (double value) {
              setState(() {
                _sliderX = value;
              });
            }),
            Slider(value: _sliderZ, onChanged: (double value) {
              setState(() {
                _sliderZ = value;
              });
            })
          ],
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
