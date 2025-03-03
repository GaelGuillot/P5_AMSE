import 'package:flutter/material.dart';
import '../tile.dart';

class Exo5Screen extends StatefulWidget {
  @override
  _Exo5ScreenState createState() => _Exo5ScreenState();
}

class _Exo5ScreenState extends State<Exo5Screen> {
  final String title = 'Display grid';
  double _sliderSize = 0.2;

  int _calculateGridSize(double sliderValue) {
    return (sliderValue * 10).toInt() + 1; 
  }

  @override
  Widget build(BuildContext context) {
    int gridSize = _calculateGridSize(_sliderSize);
    // double cellSize = 512 / gridSize;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, 
        icon: Icon(Icons.arrow_back)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Display grid'),
      ),
      body: Center(
        child: Column(
          children: <Widget>
          [
            Expanded(
              child: Container(
                height:500,
                child: GridView.count(
                  padding: const EdgeInsets.all(10), 
                  crossAxisCount: gridSize,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int index = 0; index < gridSize * gridSize; index++)
                    Tile(
                      imageURL: 'https://picsum.photos/512', 
                      alignment: Alignment(
                        -1 + 2 * (index % gridSize) / (gridSize - 1),
                        -1 + 2 * (index ~/ gridSize) / (gridSize - 1),),
                      widthFactor: 1 / gridSize,
                      heightFactor: 1 / gridSize,
                    ).croppedImageTile(),
                  ],
                  ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Size: '),
                Slider(
                  value: _sliderSize,
                  min: 0.2,
                  max: 0.9,
                  divisions: 7,
                  label: '${_calculateGridSize(_sliderSize)}',
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
      ),
    );
  }
}