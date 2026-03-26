import 'package:firebase_practice/model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtists();

  Future<Artist?> fetchArtistsById(String id);
}