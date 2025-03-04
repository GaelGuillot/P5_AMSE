import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:collection';
import '../tile.dart';

class Exo7Screen extends StatefulWidget {
  @override
  _Exo7ScreenState createState() => _Exo7ScreenState();
}

class _Exo7ScreenState extends State<Exo7Screen> {
  final String title = 'Tile Puzzle';
  double _sliderSize = 0.4;
  List<int> grid;
  bool hasStarted = false;
  int nbMoves = 0;
  int timer = 0;
  Timer? _timer;
  Queue movesHistory = new Queue(); 

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

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        this.timer += 1;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int gridSize = _calculateGridSize(_sliderSize);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Tile Puzzle'),
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
                          if (_checkAdjacent(index)) {
                            movesHistory.add(grid.indexOf(grid.length - 1));
                            _swapTiles(index);
                            setState(() {
                              nbMoves += 1;
                            });
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
            Visibility(
              visible: hasStarted,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 229, 229),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: 100,
                    child: Text(
                      'Time:\n${(timer ~/ 60).toString().padLeft(2, '0')}:${(timer % 60).toString().padLeft(2, '0')}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),

                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                    setState(() {
                      if (movesHistory.isNotEmpty) {
                        _swapTiles(movesHistory.removeLast());
                        nbMoves -= 1;
                      }
                    });
                    },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: movesHistory.isNotEmpty?Color.fromARGB(255, 241, 241, 241): Color.fromARGB(255, 213, 207, 214),
                    shape: CircleBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    ),
                    child: Icon(Icons.settings_backup_restore_rounded,
                    color: movesHistory.isNotEmpty?Colors.black:Colors.grey,
                    ),
                  ),

                  SizedBox(width: 10),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 229, 229),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    width: 100,
                    child: Text(
                      'Moves:\n$nbMoves',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (!hasStarted) {
                            if (_sliderSize > 0.2) {
                              _sliderSize -= 0.1;
                            }
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (hasStarted ? Color.fromARGB(255, 243, 243, 243) : Color.fromARGB(255, 255, 196, 252)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        '-',
                        style: hasStarted ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (hasStarted) {
                            grid = List.generate(101, (index) => index);
                            hasStarted = false;
                            _stopTimer();
                          } else {
                            _swapTiles(gridSize * gridSize - gridSize);
                            nbMoves = 0;
                            timer = 0;
                            movesHistory = Queue();
                            hasStarted = true;
                            _startTimer();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (hasStarted ? Color.fromARGB(255, 255, 180, 180) : Color.fromARGB(255, 201, 255, 196)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      ),
                      child: Text(hasStarted ? 'Reset' : 'Start'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (!hasStarted) {
                            if (_sliderSize < 0.9) {
                              _sliderSize += 0.1;
                            }
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (hasStarted ? Color.fromARGB(255, 243, 243, 243) : Color.fromARGB(255, 255, 196, 252)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        '+',
                        style: hasStarted ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}