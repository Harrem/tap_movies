class ApiEndPoints {
  // Private constructor to prevent instantiation
  ApiEndPoints._();

  // Base URLs
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageUrl500 = "https://image.tmdb.org/t/p/w500";
  static const String imageUrl1280 = "https://image.tmdb.org/t/p/w1280";

  // Movies endpoints
  static String topRatedMovies = "/movie/top_rated";
  static String discoverMovies = "/discover/movie";
  static String upcomingMovies = "/movie/upcoming";
  static String nowPlayingMovies = "/movie/now_playing";

  // Single movie endpoints
  static String movieDetail(int movieId) => "/movie/$movieId";
  static String movieImages(int movieId) => "/movie/$movieId/images";
  static String movieTrailers(int movieId) => "/movie/$movieId/videos";
  static String similarMovies(int movieId) => "/movie/$movieId/similar";
  static String movieRecommendations(int movieId) =>
      "/movie/$movieId/recommendations";

  // Search endpoint
  static String searchMovies = "/search/movie";
}
