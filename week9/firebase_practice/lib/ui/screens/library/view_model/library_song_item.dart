import '../../../../model/songs/song.dart';

class LibrarySongItem {
  final Song song;
  final String artistName;
  final String artistGenre;

  const LibrarySongItem({
    required this.song,
    required this.artistName,
    required this.artistGenre,
  });
}
