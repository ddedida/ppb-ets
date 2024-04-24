const String tableMovies = 'movies';

class MovieFields {
  static final List<String> values = [
    id,
    movieTitle,
    createdTime,
    urlCover,
    description,
  ];

  static const String id = '_id';
  static const String movieTitle = 'movieTitle';
  static const String createdTime = 'createdTime';
  static const String urlCover = 'urlCover';
  static const String description = 'description';
}

class Movie {
  final int? id;
  final String movieTitle;
  final DateTime createdTime;
  final String urlCover;
  final String description;

  const Movie({
    this.id,
    required this.movieTitle,
    required this.createdTime,
    required this.urlCover,
    required this.description,
  });

  Movie copy({
    int? id,
    String? movieTitle,
    DateTime? createdTime,
    String? urlCover,
    String? description,
  }) =>
      Movie(
        id: id ?? this.id,
        movieTitle: movieTitle ?? this.movieTitle,
        createdTime: createdTime ?? this.createdTime,
        urlCover: urlCover ?? this.urlCover,
        description: description ?? this.description,
      );

  static Movie fromJson(Map<String, Object?> json) => Movie(
    id: json[MovieFields.id] as int?,
    movieTitle: json[MovieFields.movieTitle] as String,
    createdTime: DateTime.parse(json[MovieFields.createdTime] as String),
    urlCover: json[MovieFields.urlCover] as String,
    description: json[MovieFields.description] as String,
  );

  Map<String, Object?> toJson() => {
    MovieFields.id: id,
    MovieFields.movieTitle: movieTitle,
    MovieFields.createdTime: createdTime.toIso8601String(),
    MovieFields.urlCover: urlCover,
    MovieFields.description: description,
  };
}