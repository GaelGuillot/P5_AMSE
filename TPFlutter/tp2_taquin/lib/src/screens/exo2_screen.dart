import 'package:flutter/material.dart';
import 'dart:math' as math;

class Exo2Screen extends StatefulWidget {
  const Exo2Screen({super.key});

  @override
  State<Exo2Screen> createState() => _Exo2ScreenState();
}

class _Exo2ScreenState extends State<Exo2Screen> {
  double _sliderX = 0.5;
  double _sliderZ = 0.5;
  double _sliderS = 0.5;
  bool? _mirrorBool = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Rotate/Scale image'),
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

