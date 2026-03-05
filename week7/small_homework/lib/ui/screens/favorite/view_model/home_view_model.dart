import 'package:flutter/widgets.dart';
import 'package:small_homework/data/repositories/historys/user_history_repository.dart';
import 'package:small_homework/data/repositories/songs/song_repository.dart';
import 'package:small_homework/model/songs/song.dart';
import 'package:small_homework/ui/states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepo;
  final UserHistoryRepository historyRepo;
  final PlayerState playerState;

  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  List<Song> get recentSongs => _recentSongs;
  List<Song> get recommendedSongs => _recommendedSongs;

  HomeViewModel({
    required this.songRepo,
    required this.historyRepo,
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);
    init();
  }

  Future<void> init() async {
    await _fetchRecentSongs();
    _generateRecommendedSongs();
    notifyListeners();
  }

  Future<void> _fetchRecentSongs() async {
    final recentIds = await historyRepo.fetchRecentSongIds();
    final allSongs = songRepo.fetchSongs();
    _recentSongs = allSongs
        .where((song) => recentIds.contains(song.id))
        .toList();
  }

  void _generateRecommendedSongs() {
    final allSongs = songRepo.fetchSongs();
    _recommendedSongs = allSongs
        .where((song) => !_recentSongs.contains(song))
        .toList();
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
