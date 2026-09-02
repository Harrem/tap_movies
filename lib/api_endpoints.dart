class ApiEndPoints {
  ApiEndPoints._();

  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String language = "en";
  static const String region = "US";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  static String topRatedMovies = "/movie/top_rated";
  static String discoverMovies = "/discover/movie";
  static String movieDetails = "/movie/{movie_id}";
  static String movieTrailers = "/movie/{movie_id}/videos";
  static String similarMovies = "/movie/{movie_id}/similar";
  static String movieRecommendations = "/movie/{movie_id}/recommendations";
}
