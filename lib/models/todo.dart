class Todo {
  final String title;
  final String description;
  final bool isCompleted;

  Todo({
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  //create a copy with method data check uncheck garna lai
  Todo copyWith({String? title, String? description, bool? isCompleted}) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
