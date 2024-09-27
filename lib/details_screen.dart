import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> movie;

  const DetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    // Unfocused any input field to hide the keyboard before building the new screen
    FocusScope.of(context).unfocus();

    final imageUrl = movie['image'] != null
        ? movie['image']['medium'] // Using medium-sized image
        : 'https://via.placeholder.com/150'; // Placeholder if no image is available
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(movie['name'] ?? 'Movie Details'),
      ),
      body: SingleChildScrollView(  // Add scrollable behavior
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(125),
              child: CachedNetworkImage(
                width: 250,
                height: 250,
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                errorWidget: (context, url, error) => const CircleAvatar(
                  child: Icon(CupertinoIcons.person),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              movie['name'] ?? 'No Name',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Language: ${movie['language']}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              'Genres: ${movie['genres']?.join(', ') ?? 'No genres'}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              'Premiered: ${movie['premiered']}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              'Rating: ${movie['rating'] != null ? movie['rating']['average'] : 'No Rating'}',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            // Text(
            //   'Rating: ${movie['rating']}',
            //   style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            // ),
            const SizedBox(height: 16),
            Text(textAlign: TextAlign.center,
              movie['summary'] != null
                  ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '')
                  : 'No description available',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}