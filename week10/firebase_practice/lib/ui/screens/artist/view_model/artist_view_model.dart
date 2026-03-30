import 'package:flutter/material.dart';
import '../../../../data/repositories/artist/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artist/artist.dart';
import '../../../../model/comment/comment.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class ArtistViewModel extends ChangeNotifier {
  final Artist artist;
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  AsyncValue<List<Comment>> commentsValue = AsyncValue.loading();

  ArtistViewModel({
    required this.artist,
    required this.songRepository,
    required this.artistRepository,
  }) {
    // init
    _init();
  }

  void _init() async {
    fetchData();
  }

  void fetchData() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    commentsValue = AsyncValue.loading();
    notifyListeners();

    // 2- Fetch songs filtered by artistId
    try {
      List<Song> allSongs = await songRepository.fetchSongs();
      songsValue = AsyncValue.success(
        allSongs.where((song) => song.artistId == artist.id).toList(),
      );
    } catch (e) {
      songsValue = AsyncValue.error(e);
    }

    // 3- Fetch comments for this artist
    try {
      List<Comment> comments = await artistRepository.fetchArtistComments(artist.id);
      commentsValue = AsyncValue.success(comments);
    } catch (e) {
      commentsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

  void addComment(String text) async {
    try {
      final Comment newComment = await artistRepository.postComment(artist.id, text);

      // Update local state - append new comment to the list
      if (commentsValue.data != null) {
        commentsValue = AsyncValue.success([...commentsValue.data!, newComment]);
        notifyListeners();
      }
    } catch (e) {
      // Keep current state on error
    }
  }
}
