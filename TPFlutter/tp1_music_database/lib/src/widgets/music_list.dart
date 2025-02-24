 
import 'package:flutter/material.dart';

import '../data.dart';

class MusicList extends StatefulWidget {
  final List<Music> musics;
  final ValueChanged<Music>? onTap;

  const MusicList({required this.musics, this.onTap, super.key});

  @override
  State<MusicList> createState() =>
    _musiclist(musics: this.musics, onTap: this.onTap);
}

class _musiclist extends State<MusicList> {
  final List<Music> musics;
  final ValueChanged<Music>? onTap;

  _musiclist({required this.musics, this.onTap});

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: musics.length,
    itemBuilder:
        (context, index) => ListTile(
          title: Text(musics[index].title),
          subtitle: Text(musics[index].artist.name),
          onTap: onTap != null ? () => onTap!(musics[index]) : null,
          trailing: IconButton(
            key: Key(musics[index].title),
            icon: musics[index].isFavorite == true
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              setState(() {
              musics[index].toggleFavorite();
              });
            },
          ),
        ),
        
  );
}
