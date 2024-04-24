import 'package:flutter/material.dart';
import 'package:ets_app/db/movie_database.dart';
import 'package:ets_app/model/movie.dart';
import 'package:ets_app/widget/movie_form_widget.dart';

class AddEditMoviePage extends StatefulWidget {
  final Movie? movie;

  const AddEditMoviePage({
    Key? key,
    this.movie,
  }) : super(key: key);

  @override
  State<AddEditMoviePage> createState() => _AddEditMoviePageState();
}

class _AddEditMoviePageState extends State<AddEditMoviePage> {
  final _formKey = GlobalKey<FormState>();
  late String movieTitle;
  late String urlCover;
  late String description;

  @override
  void initState() {
    super.initState();

    movieTitle = widget.movie?.movieTitle ?? '';
    urlCover = widget.movie?.urlCover ?? '';
    description = widget.movie?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [buildButton()],
    ),
    body: Form(
      key: _formKey,
      child: MovieFormWidget(
        movieTitle: movieTitle,
        urlCover: urlCover,
        description: description,
        onChangedMovieTitle: (movieTitle) => setState(() => this.movieTitle = movieTitle),
        onChangedUrlCover: (urlCover) => setState(() => this.urlCover = urlCover),
        onChangedDescription: (description) => setState(() => this.description = description),
      ),
    ),
  );

  Widget buildButton() {
    final isFormValid = movieTitle.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black87,
          backgroundColor: isFormValid ? Colors.lightGreen.shade300 : Colors.red.shade300,
        ),
        onPressed: addOrUpdateMovie,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateMovie() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.movie != null;

      if (isUpdating) {
        await updateMovie();
      } else {
        await addMovie();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateMovie() async {
    final movie = widget.movie!.copy(
      movieTitle: movieTitle,
      urlCover: urlCover,
      description: description,
    );

    await MoviesDatabase.instance.update(movie);
  }

  Future addMovie() async {
    final movie = Movie(
      movieTitle: movieTitle,
      createdTime: DateTime.now(),
      urlCover: urlCover,
      description: description,
    );

    await MoviesDatabase.instance.create(movie);
  }
}