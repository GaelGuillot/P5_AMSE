 
import 'package:flutter/material.dart';

import '../data/artist.dart';
import '../data/library.dart';
import '../widgets/artist_list.dart';

class ArtistsScreen extends StatelessWidget {
  final String title;
  final ValueChanged<Artist> onTap;

  const ArtistsScreen({required this.onTap, this.title = 'Artists', super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: ArtistList(artists: libraryInstance.allArtists, onTap: onTap),
  );
}
