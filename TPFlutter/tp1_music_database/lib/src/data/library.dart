 
import 'artist.dart';
import 'music.dart';
import 'genre.dart';

final libraryInstance =
    Library()
      ..addMusic(
        title: 'St. Chroma',
        artistName: 'Tyler, The Creator',
        isFavorite: false,
        genre: Genre.rap,
        album: 'Chromakopia'
      )
      ..addMusic(
        title: 'Like Him',
        artistName: 'Tyler, The Creator',
        isFavorite: false,
        genre: Genre.rap,
        album: 'Chromakopia'
      )
      ..addMusic(
        title: 'Reincarnated',
        artistName: 'Kendrick Lamar',
        isFavorite: false,
        genre: Genre.rap,
        album: 'GNX'
      )
      ..addMusic(
        title: 'King Kunta',
        artistName: 'Kendrick Lamar',
        isFavorite: false,
        genre: Genre.rap,
        album: 'To_Pimp_A_Butterfly'
      )
      ..addMusic(
        title: 'All Caps',
        artistName: 'MF DOOM',
        isFavorite: false,
        genre: Genre.rap,
        album: 'Madvillainy'
      )
      ..addMusic(
        title: 'Meat Grinder',
        artistName: 'MF DOOM',
        isFavorite: false,
        genre: Genre.rap,
        album: 'Madvillainy'
      )
      ..addMusic(
        title: 'Vincent',
        artistName: 'Car Seat Headrest',
        isFavorite: false,
        genre: Genre.rock,
        album: 'Teens_Of_Denial'
      )
      ..addMusic(
        title: 'Fill In The Blank',
        artistName: 'Car Seat Headrest',
        isFavorite: false,
        genre: Genre.rock,
        album: 'Teens_Of_Denial'
      )
      ..addMusic(
        title: 'MK Ultra',
        artistName: 'Muse',
        isFavorite: false,
        genre: Genre.rock,
        album: 'The_Resistance'
      )
      ..addMusic(
        title: 'Knights of Cydonia',
        artistName: 'Muse',
        isFavorite: false,
        genre: Genre.rock,
        album: 'Black_Holes_and_Revelations'
      )
      ..addMusic(
        title: 'Uprising',
        artistName: 'Muse',
        isFavorite: false,
        genre: Genre.rock,
        album: 'The_Resistance'
      )
      ..addMusic(
        title: 'Only Girl',
        artistName: 'Rihanna',
        isFavorite: false,
        genre: Genre.pop,
        album: 'Loud'
      )
      ..addMusic(
        title: 'Fading',
        artistName: 'Rihanna',
        isFavorite: false,
        genre: Genre.pop,
        album: 'Loud'
      )
      ..addMusic(
        title: 'Cry For Me',
        artistName: 'The Weeknd',
        isFavorite: false,
        genre: Genre.pop,
        album: 'Hurry_Up_Tomorrow'
      )
      ..addMusic(
        title: 'Timeless',
        artistName: 'The Weeknd',
        isFavorite: false,
        genre: Genre.pop,
        album: 'Hurry_Up_Tomorrow'
      )
      ..addMusic(
        title: 'Starboy',
        artistName: 'The Weeknd',
        isFavorite: false,
        genre: Genre.pop,
        album: 'Starboy'
      )
      ..addMusic(
        title: 'Focus',
        artistName: 'Shaun Martin',
        isFavorite: false,
        genre: Genre.jazz,
        album: 'Focus'
      )
      ..addMusic(
        title: 'Triad',
        artistName: 'Shaun Martin',
        isFavorite: false,
        genre: Genre.jazz,
        album: 'Focus'
      )
      ..addMusic(
        title: 'Fluffy',
        artistName: 'Himiko Kikuchi',
        isFavorite: false,
        genre: Genre.jazz,
        album: 'Flying_Beagle'
      )
      ..addMusic(
        title: 'Flying Beagle',
        artistName: 'Himiko Kikuchi',
        isFavorite: false,
        genre: Genre.jazz,
        album: 'Flying_Beagle'
      )
      ..addMusic(
        title: 'Look Your Back!',
        artistName: 'Himiko Kikuchi',
        isFavorite: false,
        genre: Genre.jazz,
        album: 'Flying_Beagle'
      );

class Library {
  final List<Music> allMusic = [];
  final List<Artist> allArtists = [];

  void addMusic({
    required String title,
    required String artistName,
    required bool isFavorite,
    required Genre genre,
    required String album,
  }) {
    var artist = allArtists.firstWhere(
      (artist) => artist.name == artistName,
      orElse: () {
        final value = Artist(allArtists.length, artistName);
        allArtists.add(value);
        return value;
      },
    );
    var music = Music(allMusic.length, title, isFavorite, genre, artist, album);

    artist.musics.add(music);
    allMusic.add(music);
  }

  Music getMusic(String id) {
    return allMusic[int.parse(id)];
  }

  List<Music> get favoriteMusics => [...allMusic.where((music) => music.isFavorite)];

  List<Music> get rapMusic => [...allMusic.where((music) => music.genre == Genre.rap)];
  List<Music> get rockMusic => [...allMusic.where((music) => music.genre == Genre.rock)];
  List<Music> get popMusic => [...allMusic.where((music) => music.genre == Genre.pop)];
  List<Music> get jazzMusic => [...allMusic.where((music) => music.genre == Genre.jazz)];

}
