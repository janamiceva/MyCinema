import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  final searchMovies = const [
    {'name': 'Venom: Let There Be Carnage', 'image': 'images/movie1.jpg'},
    {'name': 'Fast & Furious 9', 'image': 'images/movie2.jpg'},
    {'name': 'No Time to Die', 'image': 'images/movie3.jpg'},
    {'name': 'Free Guy', 'image': 'images/movie4.jpg'},
    {'name': 'Reminiscence', 'image': 'images/movie5.jpg'},
    {'name': 'Shang-Chi', 'image': 'images/movie6.jpg'},
    {'name': 'Infinite', 'image': 'images/movie7.jpg'},
    {'name': "Don't Breathe 2", 'image': 'images/movie8.jpg'},
    {'name': 'Black Widow', 'image': 'images/movie10.jpg'},
    {'name': 'The Forever Purge', 'image': 'images/movie11.jpg'},
    {'name': 'The Tomorrow War', 'image': 'images/movie12.jpg'},
    {'name': 'The Ice Road', 'image': 'images/movie13.jpg'},
    {'name': "Hitman's Wife's Bodyguard", 'image': 'images/movie14.jpg'},
  ];
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor:
            Colors.deepPurple, // Set the app bar background color to red
      ),
    );
  }

// first overwrite to
// clear the search text
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    final matchQuery = <Map<String, String>>[];
    for (var movie in searchMovies) {
      if (movie['name'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(movie);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Card(
          child: Column(
            children: [
              Image.asset(
                result['image'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  result['name'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    final matchQuery = <Map<String, String>>[];
    for (var movie in searchMovies) {
      if (movie['name'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(movie);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Card(
          color: Colors.black,
          child: Row(
            children: [
              Image.asset(
                result['image'],
                width: 100,
                height: 100,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  result['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
