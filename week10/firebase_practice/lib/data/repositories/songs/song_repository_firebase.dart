import 'dart:convert';

import 'package:firebase_practice/config/firebase_config.dart';
import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = FirebaseConfig.baseUrl.replace(path: '/songs.json');

  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    // 1. Return cache if available and not forced
    if (_cachedSongs != null && !forceFetch) {
      return _cachedSongs!;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      // 3. Store in memory
      _cachedSongs = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<Song> likeSong(Song song) async {
    final int newLikes = song.likes + 1;

    // PUT to update only the likes field for this song
    final Uri likesUri = FirebaseConfig.baseUrl.replace(path: '/songs/${song.id}/likes.json');
    final http.Response response = await http.put(
      likesUri,
      body: json.encode(newLikes),
    );

    if (response.statusCode == 200) {
      // Return the updated song locally (no need for an extra round-trip)
      return song.copyWith(likes: newLikes);
    } else {
      throw Exception('Failed to like song');
    }
  }
}
