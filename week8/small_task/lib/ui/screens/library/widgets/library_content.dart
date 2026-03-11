import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/theme.dart';
import '../../../widgets/song/song_tile.dart';
import '../view_model/library_view_model.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    LibraryViewModel mv = context.watch<LibraryViewModel>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text("Library", style: AppTextStyles.heading),
          const SizedBox(height: 50),
          
          Expanded(
            child: _buildBody(mv),
          ),
        ],
      ),
    );
  }

  // Helper method to handle the 3 states 
  Widget _buildBody(LibraryViewModel mv) {
    switch (mv.status) {
      case LibraryStatus.loading:
        // Handle loading state
        return const Center(
          child: CircularProgressIndicator(),
        );

      case LibraryStatus.error:
        // Handle error state 
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(mv.errorMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => mv.refreshSongs(),
                child: const Text("Retry"),
              )
            ],
          ),
        );

      case LibraryStatus.success:
        // Handle success state 
        return ListView.builder(
          itemCount: mv.songs.length,
          itemBuilder: (context, index) {
            final song = mv.songs[index];
            return SongTile(
              song: song,
              isPlaying: mv.isSongPlaying(song),
              onTap: () => mv.start(song),
            );
          },
        );
    }
  }
}