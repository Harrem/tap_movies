class ApiEndPoints {
  ApiEndPoints._();

  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageUrl500 = "https://image.tmdb.org/t/p/w500";
  static const String imageUrl1280 = "https://image.tmdb.org/t/p/w1280";

  static String topRatedMovies = "/movie/top_rated";
  static String discoverMovies = "/discover/movie";
  static String upcomingMovies = "/movie/upcoming";
  static String nowPlayingMovies = "/movie/now_playing";

  static String movieDetail(int movieId) => "/movie/$movieId";
  static String movieImages(int movieId) => "/movie/$movieId/images";
  static String movieTrailers(int movieId) => "/movie/$movieId/videos";
  static String similarMovies(int movieId) => "/movie/$movieId/similar";
  static String movieRecommendations(int movieId) =>
      "/movie/$movieId/recommendations";
  static String searchMovies = "/search/movie";
}
