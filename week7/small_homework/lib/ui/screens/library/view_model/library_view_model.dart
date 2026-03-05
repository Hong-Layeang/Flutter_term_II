import 'package:flutter/widgets.dart';
import 'package:small_homework/data/repositories/songs/song_repository.dart';
import 'package:small_homework/model/songs/song.dart';
import 'package:small_homework/ui/states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepo;
  final PlayerState playerState;

  List<Song> _songs = [];
  List<Song> get songs => _songs;

  LibraryViewModel({required this.songRepo, required this.playerState}) {
    playerState.addListener(notifyListeners);
    init();
  }

  void init() {
    _songs = songRepo.fetchSongs();
    notifyListeners();
  }

  void play(Song song) => playerState.start(song);
  void stop() => playerState.stop();

  bool isPlaying(Song song) => playerState.currentSong == song;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }
}