import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;
  double widthFactor = 0.3;
  double heightFactor = 0.3;

  Tile(
    {required this.imageURL,
    required this.alignment,
    this.widthFactor = 0.3,
    this.heightFactor = 0.3}
    );

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}
