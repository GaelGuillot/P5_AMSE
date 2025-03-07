import 'package:flutter/material.dart';

class Tile {
  String? imageURL;
  int id;
  Alignment alignment;
  double widthFactor = 0.3;
  double heightFactor = 0.3;

  Tile(
    {this.imageURL,
    required this.id,
    required this.alignment,
    this.widthFactor = 0.3,
    this.heightFactor = 0.3}
    );

  Widget croppedImageTile() {
    return imageURL == null
      ? Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: this.id==100 ? Colors.white : Color.fromARGB(255, 255, 212, 254)
        ),
        child: Center(child: Text(id == 100 ? '' : (this.id+1).toString())),
        )
      : FittedBox(
        fit: BoxFit.fill,
        child: ClipRect(
          child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            child: Image.network(this.imageURL!),
          ),
          ),
        ),
        );
  }
}
