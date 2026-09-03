import 'package:tap_movies/core/service/api_endpoints.dart';

class BackdropModel {
  final double? aspectRatio;
  final int? height;
  final String? filePath;
  final double? voteAverage;
  final int? width;

  BackdropModel({
    this.aspectRatio,
    this.height,
    this.filePath,
    this.voteAverage,
    this.width,
  });

  factory BackdropModel.fromJson(Map<String, dynamic> json) {
    return BackdropModel(
      aspectRatio: json['aspect_ratio'],
      height: json['height'],
      filePath: json['file_path'],
      voteAverage: json['vote_average'],
      width: json['width'],
    );
  }

  String getBackdropUrl() {
    return '${ApiEndPoints.imageUrl1280}$filePath';
  }
}
