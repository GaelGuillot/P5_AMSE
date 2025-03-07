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
  int gridSize = 4;
  List<int> grid;
  bool hasStarted = false;
  bool hasWon = false;
  bool showNumbers = false;
  int nbMoves = 0;
  double nbShuffles = 50;
  int timer = 0;
  Timer? _timer;
  Queue<int> movesHistory = Queue<int>();
  String imageURL = 'https://picsum.photos/512';
  List<int>? initialGrid;

  _Exo7ScreenState() : grid = List.generate(101, (index) => index);

  bool win() {
    for (int i = 0; i < grid.length - 1; i++) {
      if ((grid[i] != grid.length - 1) && (i != grid[i])) {
        return false;
      }
    }
    return true;
  }

  void shuffle(int moves, int _gridSize, int blank_index) {
    for (int i = 0; i < moves; i++) {
      if (blank_index == 0) {
        if (Random().nextInt(2) == 0) {
          _swapTiles(1);
          blank_index = 1;
        } else {
          _swapTiles(_gridSize);
          blank_index = _gridSize;
        }
      } else if (blank_index == _gridSize - 1) {
        if (Random().nextInt(2) == 0) {
          _swapTiles(2 * _gridSize - 1);
          blank_index = 2 * _gridSize - 1;
        } else {
          _swapTiles(_gridSize - 2);
          blank_index = _gridSize - 2;
        }
      } else if (blank_index == _gridSize * _gridSize - _gridSize) {
        if (Random().nextInt(2) == 0) {
          _swapTiles(_gridSize * _gridSize - 2 * _gridSize);
          blank_index = _gridSize * _gridSize - 2 * _gridSize;
        } else {
          _swapTiles(_gridSize * _gridSize - _gridSize + 1);
          blank_index = _gridSize * _gridSize - _gridSize + 1;
        }
      } else if (blank_index == _gridSize * _gridSize - 1) {
        if (Random().nextInt(2) == 0) {
          _swapTiles(_gridSize * _gridSize - 2);
          blank_index = _gridSize * _gridSize - 2;
        } else {
          _swapTiles(_gridSize * _gridSize - _gridSize - 1);
          blank_index = _gridSize * _gridSize - _gridSize - 1;
        }
      } else if (blank_index < _gridSize) {
        int rand = Random().nextInt(3);
        if (rand == 0) {
          _swapTiles(blank_index + _gridSize);
          blank_index = blank_index + _gridSize;
        } else if (rand == 1) {
          _swapTiles(blank_index + 1);
          blank_index = blank_index + 1;
        } else {
          _swapTiles(blank_index - 1);
          blank_index = blank_index - 1;
        }
      } else if (blank_index % _gridSize == 0) {
        int rand = Random().nextInt(3);
        if (rand == 0) {
          _swapTiles(blank_index + _gridSize);
          blank_index = blank_index + _gridSize;
        } else if (rand == 1) {
          _swapTiles(blank_index + 1);
          blank_index = blank_index + 1;
        } else {
          _swapTiles(blank_index - _gridSize);
          blank_index = blank_index - _gridSize;
        }
      } else if (blank_index % _gridSize == _gridSize - 1) {
        int rand = Random().nextInt(3);
        if (rand == 0) {
          _swapTiles(blank_index + _gridSize);
          blank_index = blank_index + _gridSize;
        } else if (rand == 1) {
          _swapTiles(blank_index - 1);
          blank_index = blank_index - 1;
        } else {
          _swapTiles(blank_index - _gridSize);
          blank_index = blank_index - _gridSize;
        }
      } else if (blank_index > _gridSize * _gridSize - _gridSize) {
        int rand = Random().nextInt(3);
        if (rand == 0) {
          _swapTiles(blank_index - _gridSize);
          blank_index = blank_index - _gridSize;
        } else if (rand == 1) {
          _swapTiles(blank_index + 1);
          blank_index = blank_index + 1;
        } else {
          _swapTiles(blank_index - 1);
          blank_index = blank_index - 1;
        }
      } else {
        int rand = Random().nextInt(4);
        if (rand == 0) {
          _swapTiles(blank_index - _gridSize);
          blank_index = blank_index - _gridSize;
        } else if (rand == 1) {
          _swapTiles(blank_index + _gridSize);
          blank_index = blank_index + _gridSize;
        } else if (rand == 2) {
          _swapTiles(blank_index + 1);
          blank_index = blank_index + 1;
        } else {
          _swapTiles(blank_index - 1);
          blank_index = blank_index - 1;
        }
      }
    }
  }

  void _swapTiles(int index) {
    int blankIndex = grid.indexOf(grid.length - 1);
    setState(() {
      grid[blankIndex] = grid[index];
      grid[index] = grid.length - 1;
    });
  }

  bool _checkAdjacent(int index) {
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

  void _replayMoves() {
    if (initialGrid != null) {
      int initNbMoves = nbMoves;
      setState(() {
        grid = List.from(initialGrid!);
        nbMoves = 0;
      });

      Timer.periodic(Duration(milliseconds: min(500, 5000~/initNbMoves) ), (timer) {
        if (movesHistory.isEmpty) {
          timer.cancel();
        } else {
          setState(() {
            _swapTiles(movesHistory.removeFirst());
            nbMoves += 1;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                width: 500,
                child: GridView.count(
                  padding: const EdgeInsets.all(10),
                  crossAxisCount: gridSize,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int index = 0; index < gridSize * gridSize; index++)
                      GestureDetector(
                        onTap: (hasStarted && !hasWon) ? () {
                          if (_checkAdjacent(index)) {
                            movesHistory.add(grid.indexOf(grid.length - 1));
                            print(movesHistory.length);
                            _swapTiles(index);
                            setState(() {
                              nbMoves += 1;
                            });
                          }
                          if (win()) {
                            _stopTimer();
                            hasWon = true;
                            movesHistory.add(grid.indexOf(grid.length - 1));
                            movesHistory.removeFirst();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("You win!"),
                                  content: Text('You solved this puzzle in${(timer ~/ 60 == 0) ? '' : ' ${(timer ~/ 60).toString()} minute${timer ~/ 60 <= 1 ? '' : 's'} and'} ${(timer % 60).toString()} second${timer % 60 == 1 ? '' : 's'}, using $nbMoves move${nbMoves <= 1 ? '' : 's'}!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } : null,
                        child: Tile(
                          id: grid[index],
                          imageURL: showNumbers ? null : imageURL,
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
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
                        Column(
                          children: [
                            Text(
                              hasWon?'Replay':'Undo',
                              style: TextStyle(color: movesHistory.isEmpty? Colors.grey : Colors.black),),
                            ElevatedButton(
                              onPressed: movesHistory.isNotEmpty ? () {
                                setState(() {
                                  if (!hasWon) {
                                    _swapTiles(movesHistory.removeLast());
                                    nbMoves -= 1;
                                  } else {
                                    _replayMoves();
                                  }
                                });
                              } : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: movesHistory.isNotEmpty ? ( hasWon? Color.fromARGB(255, 83, 132, 255) : Color.fromARGB(255, 241, 241, 241)) : Color.fromARGB(255, 213, 207, 214),
                                shape: CircleBorder(),
                                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                              ),
                              child: Icon(hasWon?Icons.play_arrow : Icons.undo,
                                color: movesHistory.isNotEmpty ? (hasWon? Colors.white : Colors.black) : Colors.grey,
                              ),
                            ),
                          ],
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Show numbers:'),
                      Checkbox(
                        tristate: false,
                        value: showNumbers, 
                        onChanged: (bool? value) {
                        setState(() {
                          showNumbers = value!;
                        });
                      })
                  ],)
                ],
              ),
            ),
            Visibility(
              visible: !hasStarted,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Shuffles: '),
                  Slider(
                    value: nbShuffles,
                    min: 10,
                    max: 100,
                    divisions: 4,
                    label: '${(nbShuffles * gridSize).toInt()}',
                    onChanged: (double value) {
                      setState(() {
                        nbShuffles = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: !(hasStarted || gridSize == 2) ? () {
                            setState(() {
                              if (gridSize > 2) {
                                gridSize -= 1;
                              }
                            });
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (hasStarted || gridSize == 2 ? Color.fromARGB(255, 243, 243, 243) : Color.fromARGB(255, 255, 196, 252)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            '-',
                            style: hasStarted || gridSize == 2 ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.black),
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
                                    hasWon = false;
                                    showNumbers = false;
                                    _stopTimer();
                                  } else {
                                    int blank_index = Random().nextInt(gridSize * gridSize);
                                    _swapTiles(blank_index);
                                    while (win()) {
                                      shuffle((nbShuffles * gridSize).toInt(), gridSize, blank_index);
                                    };
                                    initialGrid = List.from(grid);
                                    nbMoves = 0;
                                    timer = 0;
                                    movesHistory = Queue();
                                    hasStarted = true;
                                    hasWon = false;
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
                              onPressed: hasStarted ? null : _reloadImage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (hasStarted ? Color.fromARGB(255, 243, 243, 243) : Color.fromARGB(255, 255, 196, 252)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                              ),
                              child: Text(
                                'New image',
                                style: TextStyle(color: hasStarted ? Colors.grey : Colors.black),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: !(hasStarted || gridSize == 10) ? () {
                            setState(() {
                              if (gridSize < 10) {
                                gridSize += 1;
                              }
                              print((gridSize, gridSize));
                            });
                          } : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: (hasStarted || gridSize == 10 ? Color.fromARGB(255, 243, 243, 243) : Color.fromARGB(255, 255, 196, 252)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            '+',
                            style: hasStarted || gridSize == 10 ? TextStyle(color: Colors.grey) : TextStyle(color: Colors.black),
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