import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL,required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

//Tile tile = Tile(
//    imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0));

class Exo5Screen extends StatelessWidget {
  final String title = 'Display grid';

  Tile tile = Tile(
    imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0));

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
          SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                child: createTileWidgetFrom(tile)
              )
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

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}