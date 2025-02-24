 
import 'package:flutter/material.dart';

import '../data.dart';

class ArtistList extends StatelessWidget {
  final List<Artist> artists;
  final ValueChanged<Artist>? onTap;

  const ArtistList({required this.artists, this.onTap, super.key});

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: artists.length,
    itemBuilder:
        (context, index) => ListTile(
          title: Text(artists[index].name),
          subtitle: Text('${artists[index].musics.length} songs'),
          onTap: onTap != null ? () => onTap!(artists[index]) : null,
        ),
  );
}
