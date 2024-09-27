import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieService {
  static const String apiUrl = "https://api.tvmaze.com/search/shows?q=all";

  // Function to fetch movie data from the API
  static Future<List<dynamic>> fetchMovies() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Function to search for movies based on the query
  static Future<List<dynamic>> searchMovies(String search_term) async {
    final response =
    await http.get(Uri.parse("https://api.tvmaze.com/search/shows?q=${search_term}"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to search movies');
    }
  }
}