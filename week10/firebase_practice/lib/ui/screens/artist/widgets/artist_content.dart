import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/comment/comment.dart';
import '../../../../model/songs/song.dart';
import '../../../../ui/theme/theme.dart';
import '../../../../ui/utils/async_value.dart';
import '../../../../ui/widgets/song/song_tile.dart';
import '../view_model/artist_view_model.dart';
import 'comment_tile.dart';

class ArtistContent extends StatefulWidget {
  const ArtistContent({super.key});

  @override
  State<ArtistContent> createState() => _ArtistContentState();
}

class _ArtistContentState extends State<ArtistContent> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment(ArtistViewModel mv) {
    // Validate empty comment before posting
    final String text = _commentController.text.trim();
    if (text.isEmpty) return;

    mv.addComment(text);

    // Clear the input after submitting
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ArtistViewModel mv = context.watch<ArtistViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(mv.artist.name, style: AppTextStyles.heading),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // --- Songs section ---
                Text('Songs', style: AppTextStyles.title),
                SizedBox(height: 8),
                _buildSongsSection(mv.songsValue),

                SizedBox(height: 24),

                // --- Comments section ---
                Text('Comments', style: AppTextStyles.title),
                SizedBox(height: 8),
                _buildCommentsSection(mv.commentsValue),
              ],
            ),
          ),

          // --- Comment input form at the bottom ---
          _buildCommentForm(mv),
        ],
      ),
    );
  }

  Widget _buildSongsSection(AsyncValue<List<Song>> songsValue) {
    switch (songsValue.state) {
      case AsyncValueState.loading:
        return Center(child: CircularProgressIndicator());
      case AsyncValueState.error:
        return Center(
          child: Text(
            'error = ${songsValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );
      case AsyncValueState.success:
        final List<Song> songs = songsValue.data!;
        if (songs.isEmpty) {
          return Center(child: Text('No songs for this artist'));
        }
        return Column(
          children: songs.map((song) => SongTile(song: song)).toList(),
        );
    }
  }

  Widget _buildCommentsSection(AsyncValue<List<Comment>> commentsValue) {
    switch (commentsValue.state) {
      case AsyncValueState.loading:
        return Center(child: CircularProgressIndicator());
      case AsyncValueState.error:
        return Center(
          child: Text(
            'error = ${commentsValue.error!}',
            style: TextStyle(color: Colors.red),
          ),
        );
      case AsyncValueState.success:
        final List<Comment> comments = commentsValue.data!;
        if (comments.isEmpty) {
          return Center(child: Text('No comments yet'));
        }
        return Column(
          children: comments.map((c) => CommentTile(comment: c)).toList(),
        );
    }
  }

  Widget _buildCommentForm(ArtistViewModel mv) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _submitComment(mv),
            child: Text('Post'),
          ),
        ],
      ),
    );
  }
}
