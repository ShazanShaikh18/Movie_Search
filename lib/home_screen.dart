import 'package:flutter/material.dart';
import 'movie_service.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      final movies = await MovieService.fetchMovies();
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

  // void searchMovies(String query) async {
  //   if (query.isEmpty) {
  //     fetchMovies();
  //     return;
  //   }
  //   try {
  //     final movies = await MovieService.searchMovies(query);
  //     setState(() {
  //       _movies = movies;
  //     });
  //   } catch (e) {
  //     // Handle error
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text(
      //     'Movies',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.search),
      //       onPressed: () {
      //         showSearch(
      //           context: context,
      //           delegate: MovieSearchDelegate(searchMovies),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            // Container(height: 20, color: Colors.black87,),
            Expanded(
              child: _isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 posters in a row, similar to Netflix
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6, // Adjust poster aspect ratio
                ),
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index]['show'];
                  final imageUrl = movie['image'] != null
                      ? movie['image']['medium']
                      : 'https://via.placeholder.com/150'; // Placeholder if no image

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(movie: movie),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              color: Colors.black.withOpacity(0.7),
                              child: Text(
                                movie['name'] ?? 'Unknown',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// This code is for add search button in AppBar
// class MovieSearchDelegate extends SearchDelegate {
//   final Function searchMovies;
//
//   MovieSearchDelegate(this.searchMovies);
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     searchMovies(query); // Call the search function with the query
//     return Container(); // Return empty as search results will appear in the original screen
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // You can also provide search suggestions here if you have a predefined list
//     return Container();
//   }
// }
