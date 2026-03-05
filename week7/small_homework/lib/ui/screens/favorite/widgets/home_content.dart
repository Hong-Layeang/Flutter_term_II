import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_homework/model/songs/song.dart';
import 'package:small_homework/ui/screens/favorite/view_model/home_view_model.dart';
import 'package:small_homework/ui/states/settings_state.dart';
import 'package:small_homework/ui/theme/theme.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final settings = context.watch<AppSettingsState>();

    return Container(
      color: settings.theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Home", style: AppTextStyles.heading),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recent Songs Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Your recent songs",
                      style: AppTextStyles.heading.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (viewModel.recentSongs.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("No recent songs yet"),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.recentSongs.length,
                      itemBuilder: (context, index) {
                        final song = viewModel.recentSongs[index];
                        return SongTile(
                          song: song,
                          isPlaying: viewModel.isPlaying(song),
                          onTap: () => viewModel.isPlaying(song)
                              ? viewModel.stop()
                              : viewModel.play(song),
                        );
                      },
                    ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "You might also like",
                      style: AppTextStyles.heading.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (viewModel.recommendedSongs.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text("No recommended songs"),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.recommendedSongs.length,
                      itemBuilder: (context, index) {
                        final song = viewModel.recommendedSongs[index];
                        return SongTile(
                          song: song,
                          isPlaying: viewModel.isPlaying(song),
                          onTap: () => viewModel.isPlaying(song)
                              ? viewModel.stop()
                              : viewModel.play(song),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(song.title),
      trailing: Text(
        isPlaying ? "Playing" : "",
        style: const TextStyle(color: Colors.amber),
      ),
    );
  }
}
