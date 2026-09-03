import 'dart:convert';

class MovieModel {
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path'] as String?,
      genreIds: List<int>.from(json['genre_ids'] ?? []),
      id: json['id'] as int,
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] ?? '',
      title: json['title'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );
  }
  factory MovieModel.fromJsonSql(Map<String, dynamic> json) {
    return MovieModel(
      backdropPath: json['backdrop_path'] as String?,
      genreIds: json['genre_ids'] != null
          ? List<int>.from(jsonDecode(json['genre_ids']) as List)
          : [],
      id: json['id'] as int,
      originalTitle: json['original_title'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num).toDouble(),
      posterPath: json['poster_path'] as String?,
      releaseDate: json['release_date'] ?? '',
      title: json['title'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  Map<String, dynamic> toJsonForSql() {
    return {
      'backdrop_path': backdropPath,
      'genre_ids': jsonEncode(genreIds),
      'id': id,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
