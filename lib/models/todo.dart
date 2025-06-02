class Todo {
  final String title;
  final String description;
  

  Todo({
    required this.title,
    required this.description,
    
  });

  //create a copy with method data check uncheck garna lai
  Todo copyWith({String? title, String? description, bool? isCompleted}) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      
    );
  }
}
