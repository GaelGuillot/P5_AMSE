 
import 'package:flutter/material.dart';

import '../data.dart';
import '../widgets/music_list.dart';

class ArtistDetailsScreen extends StatelessWidget {
  final Artist artist;
  final ValueChanged<Music> onMusicTapped;

  const ArtistDetailsScreen({
    super.key,
    required this.artist,
    required this.onMusicTapped,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(artist.name)),
    body: Center(
      child: Column(
        children: [
          Expanded(
            child: MusicList(
              musics: artist.musics,
              onTap: (music) {
                onMusicTapped(music);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
