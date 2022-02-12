import 'dart:convert';

import 'package:flutter/foundation.dart';

class Movies {
  final String name;
  final List<Video> videos;
  Movies({
    required this.name,
    required this.videos,
  });

  Movies copyWith({
    String? name,
    List<Video>? videos,
  }) {
    return Movies(
      name: name ?? this.name,
      videos: videos ?? this.videos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'videos': videos.map((x) => x.toMap()).toList(),
    };
  }

  factory Movies.fromMap(Map<String, dynamic> map) {
    return Movies(
      name: map['name'] ?? '',
      videos: List<Video>.from(map['videos']?.map((x) => Video.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Movies.fromJson(String source) => Movies.fromMap(json.decode(source));

  @override
  String toString() => 'Movies(name: $name, videos: $videos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movies &&
        other.name == name &&
        listEquals(other.videos, videos);
  }

  @override
  int get hashCode => name.hashCode ^ videos.hashCode;
}

class Video {
  final String title;
  final String description;
  final String subtitle;
  final List<String> sources;
  Video({
    required this.title,
    required this.description,
    required this.subtitle,
    required this.sources,
  });

  Video copyWith({
    String? title,
    String? description,
    String? subtitle,
    List<String>? sources,
  }) {
    return Video(
      title: title ?? this.title,
      description: description ?? this.description,
      subtitle: subtitle ?? this.subtitle,
      sources: sources ?? this.sources,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'subtitle': subtitle,
      'sources': sources,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subtitle: map['subtitle'] ?? '',
      sources: List<String>.from(map['sources']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Video(title: $title, description: $description, subtitle: $subtitle, sources: $sources)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Video &&
        other.title == title &&
        other.description == description &&
        other.subtitle == subtitle &&
        listEquals(other.sources, sources);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        subtitle.hashCode ^
        sources.hashCode;
  }
}
