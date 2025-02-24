 
import 'artist.dart';
import 'genre.dart';

class Music {
  final int id;
  final String title;
  final Artist artist;
  final String album;
  bool isFavorite;
  final Genre genre;

  Music(this.id, this.title, this.isFavorite, this.genre, this.artist, this.album);

  void toggleFavorite() {
    this.isFavorite = !(this.isFavorite);
  }

  String getAlbum() {
    return this.album.replaceAll('_', ' ');
  } 
}
