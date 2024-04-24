import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ets_app/db/movie_database.dart';
import 'package:ets_app/model/movie.dart';
import 'package:ets_app/pages/movie_edit_page.dart';
import 'package:ets_app/pages/movie_detail_page.dart';
import 'package:ets_app/widget/movie_card_widget.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late List<Movie> movies;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshMovies();
  }

  @override
  void dispose() {
    MoviesDatabase.instance.close();

    super.dispose();
  }

  Future refreshMovies() async {
    setState(() => isLoading = true);

    movies = await MoviesDatabase.instance.readAllMovies();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Movies List',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      actions: const [Icon(Icons.search), SizedBox(width: 12)],
    ),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isLoading
              ? const CircularProgressIndicator()
              : movies.isEmpty
              ? const Text(
            'No Movies',
            style: TextStyle(color: Colors.white, fontSize: 24),
          )
              : buildMovies(),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.lightGreen.shade300,
      child: const Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddEditMoviePage()),
        );

        refreshMovies();
      },
    ),
  );
  Widget buildMovies() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        movies.length,
            (index) {
          final movie = movies[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: movie.id!),
                ));

                refreshMovies();
              },
              child: MovieCardWidget(movie: movie, index: index),
            ),
          );
        },
      ));
}