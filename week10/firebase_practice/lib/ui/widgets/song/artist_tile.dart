import 'package:flutter/material.dart';
import '../../../model/artist/artist.dart';
import '../../screens/artist/artist_screen.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({super.key, required this.artist});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ArtistScreen(artist: artist),
              ),
            );
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(artist.imageUrl.toString()),
          ),
          title: Text(artist.name),
          subtitle: Text(artist.genre),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
