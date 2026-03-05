import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';
import 'widgets/library_content.dart';
import 'view_model/library_view_model.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LibraryViewModel(
        songRepo: context.read<SongRepository>(),
        playerState: context.read<PlayerState>(),
      ),
      child: const LibraryContent(),
    );
  }
}
