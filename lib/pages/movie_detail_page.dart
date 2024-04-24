import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets_app/db/movie_database.dart';
import 'package:ets_app/model/movie.dart';
import 'package:ets_app/pages/movie_edit_page.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Movie movie;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshMovie();
  }

  Future refreshMovie() async {
    setState(() => isLoading = true);

    movie = await MoviesDatabase.instance.readMovie(widget.movieId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [editButton(), deleteButton()],
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Text(
            movie.movieTitle,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMd().format(movie.createdTime),
            style: const TextStyle(color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            movie.description,
            style:
            const TextStyle(color: Colors.black87, fontSize: 18),
          )
        ],
      ),
    ),
  );

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditMoviePage(movie: movie),
        ));

        refreshMovie();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await MoviesDatabase.instance.delete(widget.movieId);

      Navigator.of(context).pop();
    },
  );
}