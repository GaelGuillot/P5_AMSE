import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data.dart';
import 'artist_details.dart';

class MusicDetailsScreen extends StatelessWidget {
  final Music? music;

  const MusicDetailsScreen({super.key, this.music});

  @override
  Widget build(BuildContext context) {
    if (music == null) {
      return const Scaffold(body: Center(child: Text('No music found.')));
    }
    return Scaffold(
      appBar: AppBar(title: Text(music!.title)),
      body: Center(
        child: Column(
          children: [
            Text(
              music!.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            
            Row(
              mainAxisSize: MainAxisSize.min, 
              children: [
                Icon(Icons.person), 
                SizedBox(width: 5),
                Text(
                  music!.artist.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisSize: MainAxisSize.min, 
              children: [
                Icon(Icons.album), 
                SizedBox(width: 5), 
                Text(
                  music!.getAlbum(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            
            SizedBox(height: 10),
            
            Image.asset(
              'lib/src/data/covers/'+ music!.album +'.jpg',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 15),
            TextButton(
              child: const Text('View artist'),
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder:
                        (context) => ArtistDetailsScreen(
                          artist: music!.artist,
                          onMusicTapped: (music) {
                            GoRouter.of(
                              context,
                            ).go('/musics/all/music/${music.id}');
                          },
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
