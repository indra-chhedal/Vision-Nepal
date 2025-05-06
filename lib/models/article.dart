class Article {
  final int id;
  final String documentId;
  final String title;
  final String description;
  final DateTime publishedAt;
  final String coverImageUrl;

  Article({
    required this.id,
    required this.documentId,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.coverImageUrl,
  });
  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'],
      documentId: map['documentId'],
      title: map['Title'],
      description: map['description'],
      publishedAt: DateTime.parse(map['publishedAt']),
      coverImageUrl: map['Cover']['url'],//use Cover in strapi server uppercase
    );
  }
}
