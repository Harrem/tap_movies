import 'package:flutter/cupertino.dart';

class VideoModel {
  final String name;
  final String key;
  final String site;

  VideoModel({required this.name, required this.key, required this.site});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(name: json['name'], key: json['key'], site: json['site']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'key': key, 'site': site};
  }

  String getYoutubeThumbnail() {
    return 'https://img.youtube.com/vi/$key/hqdefault.jpg';
  }

  String getVimeoThumbnail() {
    return 'https://vimeo.com/api/oembed.json?url=https://vimeo.com/$key';
  }

  String getTrailorUrl() {
    if (site.toLowerCase() == 'youtube') {
      return 'https://www.youtube.com/watch?v=$key';
    } else if (site == 'vimeo') {
      return 'https://vimeo.com/$key';
    } else {
      return '';
    }
  }

  String getTrailorSource() {
    debugPrint('site: $site');
    if (site.toLowerCase() == 'youtube') {
      return 'youtube';
    } else if (site.toLowerCase() == 'vimeo') {
      return 'vimeo';
    } else {
      return 'other';
    }
  }
}
