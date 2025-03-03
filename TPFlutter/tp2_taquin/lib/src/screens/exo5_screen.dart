import 'package:flutter/material.dart';

class Exo5Screen extends StatefulWidget {
  @override
  _Exo5ScreenState createState() => _Exo5ScreenState();
}

class _Exo5ScreenState extends State<Exo5Screen> {
  final String title = 'Display grid';
  double _sliderSize = 0.5;

  int _calculateGridSize(double sliderValue) {
    return (sliderValue * 10).toInt() + 1; 
  }

  @override
  Widget build(BuildContext context) {
    int gridSize = _calculateGridSize(_sliderSize);
    double cellSize = 512 / gridSize;

    return Scaffold(
      appBar: AppBar(
        title: Text('Display grid'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                int row = index ~/ gridSize;
                int col = index % gridSize;
                return Container(
                  width: cellSize,
                  height: cellSize,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://picsum.photos/512/1024'),
                      fit: BoxFit.cover,
                      alignment: Alignment(
                        -1 + 2 * col / (gridSize - 1),
                        -1 + 2 * row / (gridSize - 1),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Size: '),
              Slider(
                value: _sliderSize,
                onChanged: (double value) {
                  setState(() {
                    _sliderSize = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}