class BackdropModel {
  final String? aspectRatio;
  final int? height;
  final String? iso6391;
  final String? filePath;
  final double? voteAverage;
  final int? width;

  BackdropModel({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.width,
  });

  factory BackdropModel.fromJson(Map<String, dynamic> json) {
    return BackdropModel(
      aspectRatio: json['aspect_ratio'],
      height: json['height'],
      iso6391: json['iso_639_1'],
      filePath: json['file_path'],
      voteAverage: json['vote_average'],
      width: json['width'],
    );
  }
}
