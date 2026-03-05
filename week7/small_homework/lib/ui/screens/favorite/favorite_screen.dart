import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/historys/user_history_repository.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import 'view_model/home_view_model.dart';
import 'widgets/home_content.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(
        songRepo: context.read<SongRepository>(),
        historyRepo: context.read<UserHistoryRepository>(),
        playerState: context.read<PlayerState>(),
      ),
      child: const HomeContent(),
    );
  }
}
