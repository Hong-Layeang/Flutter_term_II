import 'package:flutter/material.dart';
import 'package:firebase_practice/data/repositories/artists/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../../model/artists/artist.dart';
import '../../../utils/async_value.dart';
import 'library_song_item.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<LibrarySongItem>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.artistRepository,
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      final List<dynamic> result = await Future.wait([
        songRepository.fetchSongs(),
        artistRepository.fetchArtists(),
      ]);

      final List<Song> songs = result[0] as List<Song>;
      final List<Artist> artists = result[1] as List<Artist>;

      final Map<String, Artist> artistsById = {
        for (final artist in artists) artist.id: artist,
      };

      final List<LibrarySongItem> librarySongs = songs.map((song) {
        final Artist? artist = artistsById[song.artistId];
        return LibrarySongItem(
          song: song,
          artistName: artist?.name ?? 'Unknown artist',
          artistGenre: artist?.genre ?? 'Unknown genre',
        );
      }).toList();

      songsValue = AsyncValue.success(librarySongs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
