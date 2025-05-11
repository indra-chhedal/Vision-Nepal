class Videos {
  final int id;
  final String documentId;
  final String title;
  final DateTime publishedAt;
  final String coverUrl;
  final String youtubeUrl;

  Videos({
    required this.id,
    required this.documentId,
    required this.title,
    required this.publishedAt,
    required this.coverUrl,
    required this.youtubeUrl,
  });
  factory Videos.fromMap(Map<String, dynamic> map) {
    return Videos(
      id: map['id'],
      documentId: map['documentId'],
      title: map['title'],
      publishedAt: DateTime.parse(map['publishedAt']),
      coverUrl: map['video']['url'],
      youtubeUrl: map['video_url'],
    );
  }
}
