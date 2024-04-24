import 'package:flutter/material.dart';

class MovieFormWidget extends StatelessWidget {
  final String? movieTitle;
  final String? urlCover;
  final String? description;
  final ValueChanged<String> onChangedMovieTitle;
  final ValueChanged<String> onChangedUrlCover;
  final ValueChanged<String> onChangedDescription;

  const MovieFormWidget({
    Key? key,
    this.movieTitle = '',
    this.urlCover = '',
    this.description = '',
    required this.onChangedMovieTitle,
    required this.onChangedUrlCover,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 8),
          buildImage(),
          const SizedBox(height: 16),
          buildDescription(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: movieTitle,
    style: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.black87),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedMovieTitle,
  );

  Widget buildImage() => TextFormField(
    maxLines: 5,
    initialValue: urlCover,
    style: const TextStyle(color: Colors.black87, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Give URL Image',
      hintStyle: TextStyle(color: Colors.black87),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The URL cannot be empty'
        : null,
    onChanged: onChangedUrlCover,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: description,
    style: const TextStyle(color: Colors.black87, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Type something...',
      hintStyle: TextStyle(color: Colors.black87),
    ),
    validator: (title) => title != null && title.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedDescription,
  );
}