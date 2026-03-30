import 'dart:convert';

import 'package:firebase_practice/config/firebase_config.dart';
import 'package:http/http.dart' as http;
 
import '../../../model/artist/artist.dart';
import '../../../model/comment/comment.dart';
import '../../dtos/artist_dto.dart';
import '../../dtos/comment_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase implements ArtistRepository {

  final artistsUri = FirebaseConfig.baseUrl.replace(path: '/artists.json');

  List<Artist>? _cachedArtists;

  @override
  Future<List<Artist>> fetchArtists({bool forceFetch = false}) async {
    // 1. Return cache if available and not forced
    if (_cachedArtists != null && !forceFetch) {
      return _cachedArtists!;
    }

    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Artist> result = [];
      for (final entry in songJson.entries) {
        result.add(ArtistDto.fromJson(entry.key, entry.value));
      }
      // 3. Store in memory
      _cachedArtists = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {}

  @override
  Future<List<Comment>> fetchArtistComments(String artistId) async {
    final Uri commentsUri = FirebaseConfig.baseUrl.replace(path: '/comments/$artistId.json');
    final http.Response response = await http.get(commentsUri);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      // Return empty list if no comments yet
      if (body == null) return [];

      Map<String, dynamic> commentsJson = body;
      return commentsJson.entries
          .map((entry) => CommentDto.fromJson(entry.key, entry.value))
          .toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  Future<Comment> postComment(String artistId, String text) async {
    final Uri commentsUri = FirebaseConfig.baseUrl.replace(path: '/comments/$artistId.json');
    final http.Response response = await http.post(
      commentsUri,
      body: json.encode(CommentDto.toJson(text)),
    );

    if (response.statusCode == 200) {
      final String newId = json.decode(response.body)['name'];
      return Comment(
        id: newId,
        text: text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
    } else {
      throw Exception('Failed to post comment');
    }
  }
}
