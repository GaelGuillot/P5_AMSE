import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:collection';
import '../tile.dart';
import 'dart:math';

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
  String imageURL = 'https://picsum.photos/512'; // New state variable for image URL

  _Exo7ScreenState() : grid = List.generate(101, (index) => index);

  bool win(List<int> plateau){
    for (int i =0; i > plateau.length;){
      if ((i != 101) && (i != plateau[i])){
        return false;
      } 
    }
    return true;
  }

  void shuffle(int moves){
    for (int i =0; i < moves;){
      List<int> adjacent = [];
      for (int j =0; j < grid.length;){
        if (_checkAdjacent(j)){
          adjacent.add(j);
        }
      }
      int n = Random().nextInt(adjacent.length);
      _swapTiles(adjacent[n]);
    }
  }

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

  void _reloadImage() {
    setState(() {
      imageURL = 'https://picsum.photos/512?random=${DateTime.now().millisecondsSinceEpoch}';
    });
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
                          if (win(grid)){
                            AlertDialog(
                              title: const Text("Gagné !"),
                            );
                          }
                        },
                        child: Tile(
                          imageURL: imageURL, // Use the new image URL
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
                padding: const EdgeInsets.only(bottom: 70.0),
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
                    onPressed: movesHistory.isNotEmpty?() {
                    setState(() {
                      _swapTiles(movesHistory.removeLast());
                      nbMoves -= 1;
                    });
                    }:null,
                    style: ElevatedButton.styleFrom(
                    backgroundColor: movesHistory.isNotEmpty?Color.fromARGB(255, 241, 241, 241): Color.fromARGB(255, 213, 207, 214),
                    shape: CircleBorder(),
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    ),
                    child: Icon(Icons.undo,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: !hasStarted? () {
                            setState(() {
                              if (_sliderSize > 0.2) {
                                _sliderSize -= 0.1;
                              }
                            });
                          }:null,
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
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (hasStarted) {
                                    grid = List.generate(101, (index) => index);
                                    hasStarted = false;
                                    _stopTimer();
                                  } else {
                                    shuffle(100);
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
                                backgroundColor: (hasStarted ? Color.fromARGB(255, 255, 148, 148) : Color.fromARGB(255, 201, 255, 196)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              ),
                              child: Text(hasStarted ? 'Reset' : 'Start',
                              style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: hasStarted?null:_reloadImage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (hasStarted ? Color.fromARGB(255, 243, 243, 243) : Color.fromARGB(255, 255, 196, 252)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                              ),
                              child: Text(
                                'New image',
                                style: TextStyle(color: hasStarted?Colors.grey:Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: !hasStarted? () {
                            setState(() {
                              if (_sliderSize < 0.9) {
                                _sliderSize += 0.1;
                              }
                            });
                          }:null,
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