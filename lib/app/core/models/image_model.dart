import 'dart:convert';

import 'package:flutter/foundation.dart';

class ImageModel {
  final String? id;
  final List<String>? keywords;
  final String? url;
  ImageModel({
    this.id,
    this.keywords,
    this.url,
  });

  ImageModel copyWith({
    String? id,
    List<String>? keywords,
    String? url,
  }) {
    return ImageModel(
      id: id ?? this.id,
      keywords: keywords ?? this.keywords,
      url: url ?? url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (keywords != null) {
      result.addAll({'keywords': keywords});
    }
    if (url != null) {
      result.addAll({'image': url});
    }

    return result;
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'],
      keywords: List<String>.from(map['keywords']),
      url: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));

  @override
  String toString() => 'ImageModel(id: $id, keywords: $keywords, image: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageModel &&
        other.id == id &&
        listEquals(other.keywords, keywords) &&
        other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ keywords.hashCode ^ url.hashCode;
}
