import 'package:flutter/material.dart';

class Exo5Screen extends StatelessWidget {
  final String title = 'Display grid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display grid'),
        centerTitle: true,
      ),
      body: GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: const Text("He'd have you all unravel at the"),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[200],
          child: const Text('Heed not the rabble'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[300],
          child: const Text('Sound of screams but the'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[400],
          child: const Text('Who scream'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[500],
          child: const Text('Revolution is coming...'),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[600],
          child: const Text('Revolution, they...'),
        ),
                Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[700],
          child: const Text('Revolution, they...'),
        ),
                Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[800],
          child: const Text('Revolution, they...'),
        ),
                Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[900],
          child: const Text('Revolution, they...'),
        ),
      ],
    )
    );
  }

  /*Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      onTap: () {
        print("tapped on tile");
      },
    );
  }*/
}