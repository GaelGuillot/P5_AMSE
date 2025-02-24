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
  double _sliderX = 0.5;
  double _sliderZ = 0.5;
  double _sliderS = 0.5;
  bool? _mirrorBool = false;

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
            
            ClipRect(
              child: Container(
                height:300,
                width:300,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                  ..rotateZ(2*math.pi*_sliderZ)
                  ..rotateX(2*math.pi*_sliderX)
                  ..scale(2*_sliderS),
              
                  child: Transform.flip(
                    flipX: _mirrorBool == true,
                    child: const Image(
                      height: 300,
                      image: NetworkImage('https://picsum.photos/512/1024'),
                    ),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Rotate X'),
                Slider(value: _sliderX, onChanged: (double value) {
                  setState(() {
                    _sliderX = value;
                  });
                }),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Rotate Z'),
                Slider(value: _sliderZ, onChanged: (double value) {
                  setState(() {
                    _sliderZ = value;
                  });
                }),
              ],
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Scale'),
                Slider(value: _sliderS, onChanged: (double value) {
                  setState(() {
                    _sliderS = value;
                  });
                }),
              ],
            ),

           Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Mirror'),
              Checkbox(
                tristate: false,
                value: _mirrorBool, 
                onChanged: (bool? value) {
                setState(() {
                  _mirrorBool = value;
                });
              })
           ],)
          ],
        )
      ),
    );
  }
}
