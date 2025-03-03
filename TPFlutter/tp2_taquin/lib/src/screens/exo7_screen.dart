import 'package:flutter/material.dart';
import '../tile.dart';

class Exo7Screen extends StatefulWidget {
  @override
  _Exo7ScreenState createState() => _Exo7ScreenState();
}

class _Exo7ScreenState extends State<Exo7Screen> {
  final String title = 'Display grid';
  double _sliderSize = 0.4;
  List<int> grid;
  bool hasStarted = false;

  _Exo7ScreenState() : grid = List.generate(101, (index) => index);

  int _calculateGridSize(double sliderValue) {
    return (sliderValue * 10).toInt() + 1;
  }

  void _swapTiles(int index) {
    int blankIndex = grid.indexOf(grid.length - 1);
    setState(() {
      grid[blankIndex] = grid[index];
      grid[index] = grid.length - 1;
    });
  }

  bool _checkAdjacent(int index) {
    int gridSize = _calculateGridSize(_sliderSize);
    if (index + gridSize == grid.indexOf(grid.length - 1) ||
        index - gridSize == grid.indexOf(grid.length - 1) ||
        (index + 1) % gridSize != 0 && index + 1 == grid.indexOf(grid.length - 1) ||
        index % gridSize != 0 && index - 1 == grid.indexOf(grid.length - 1)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    int gridSize = _calculateGridSize(_sliderSize);

    return Scaffold(
      appBar: AppBar(
        title: Text('Display grid'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 500,
                child: GridView.count(
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: gridSize,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int index = 0; index < gridSize * gridSize; index++)
                      GestureDetector(
                        onTap: () {
                          if (!hasStarted) {
                            _swapTiles(gridSize * gridSize - gridSize);
                            hasStarted = true;
                          }
                          else if (_checkAdjacent(index)) {
                            _swapTiles(index);
                          }
                        },
                        child: Tile(
                          imageURL: 'https://picsum.photos/512',
                          alignment: Alignment(
                            -1 + 2 * (grid[index] % gridSize) / (gridSize - 1),
                            -1 + 2 * (grid[index] ~/ gridSize) / (gridSize - 1),
                          ),
                          widthFactor: 1 / gridSize,
                          heightFactor: 1 / gridSize,
                        ).croppedImageTile(),
                      ),
                  ],
                ),
              ),
            ),
            Center(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (!hasStarted){
                        if (_sliderSize > 0.2) {
                          _sliderSize -= 0.1;
                        }
                      }
                  });
                  },
                  child: Text(
                    '-',
                    style: hasStarted?TextStyle(color: Colors.grey):TextStyle(color: Colors.black),
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (hasStarted? Color.fromARGB(255, 243, 243, 243):Color.fromARGB(255, 255, 196, 252)),
                  ),
                  ),
                  ElevatedButton(
                  onPressed: () {
                    setState(() {
                    _swapTiles(gridSize * gridSize - gridSize);
                      hasStarted = true;
                    });
                  },
                  child: Text(hasStarted?'Reset':'Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (hasStarted? Color.fromARGB(255, 255, 180, 180):Color.fromARGB(255, 201, 255, 196)),
                  ),
                  ),
                  ElevatedButton(
                  onPressed: () {
                    setState(() {
                    if (!hasStarted){
                      if (_sliderSize < 0.9) {
                      _sliderSize += 0.1;
                      }
                    }
                    });
                  },
                  child: Text(
                    '+',
                    style: hasStarted?TextStyle(color: Colors.grey):TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (hasStarted? Color.fromARGB(255, 243, 243, 243):Color.fromARGB(255, 255, 196, 252)),
                  ),
                  ),
                ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}