import 'package:flutter/material.dart';
import 'movie_service.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> _movies = [];
  bool _isLoading = false;

  void searchMovies(String query) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final movies = await MovieService.searchMovies(query);
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Movies', labelStyle: TextStyle(color: Colors.white60),
                border: OutlineInputBorder(),
              ),
              onChanged: searchMovies, style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index]['show'];
                final imageUrl = movie['image'] != null
                       ? movie['image']['medium'] // Using medium-sized image
                       : 'https://via.placeholder.com/150'; // Placeholder if no image is available
                return ListTile(
                    leading: Image.network(imageUrl, width: 80, height: 200, fit: BoxFit.cover,),
                  title: Text(movie['name'] ?? 'Unknown', style: TextStyle(color: Colors.white),),
                  subtitle: Text(movie['genres']?.join(', ') ?? 'No genres', style: TextStyle(color: Colors.white70),),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}