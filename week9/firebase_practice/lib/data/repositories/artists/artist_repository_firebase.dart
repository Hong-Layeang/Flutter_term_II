import 'dart:convert';

import 'package:firebase_practice/data/dtos/artist_dto.dart';
import 'package:firebase_practice/data/repositories/artists/artist_repository.dart';
import 'package:firebase_practice/model/artists/artist.dart';
import 'package:http/http.dart' as http;

class ArtistRepositoryFirebase implements ArtistRepository {
  final Uri artistUri = Uri.http(
    'flutter-cd067-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/artists.json',
  );

  @override
  Future<List<Artist>> fetchArtists() async {
    // TODO: implement fetchSongs
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of artists
      Map<String, dynamic> artistJson = json.decode(response.body);
      return artistJson.entries.map(
        (entry) => ArtistDto.fromJson(entry.key, entry.value)
      ).toList();
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load Artists');
    }
  }

  @override
  Future<Artist?> fetchArtistsById(String id) {
    // TODO: implement fetchSongById
    throw UnimplementedError();
  }
}
