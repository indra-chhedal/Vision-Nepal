import 'package:flutter/foundation.dart';

class Article {
  final int id;
  final String documentId;
  final String title;
  final String description;
  final String publishedAt;
  final String coverImageUrl;

  Article({
    required this.id,
    required this.documentId,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.coverImageUrl,
  });
}
