import 'package:firebase_practice/data/repositories/artists/artist_repository.dart';
import 'package:firebase_practice/model/artists/artist.dart';
import 'package:firebase_practice/ui/states/player_state.dart';
import 'package:firebase_practice/ui/utils/async_value.dart';
import 'package:flutter/widgets.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  ArtistViewModel({required this.artistRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);

    _init();
  }

  void _init() async {
    fetchArtists();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void fetchArtists() async {
    // 1- Loading state
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      List<Artist> artists = await artistRepository.fetchArtists();
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      // 3- Fetch is unsucessfull
      artistsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}