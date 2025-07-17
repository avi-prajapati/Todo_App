class Task {
  final int? id;
  final String title;
  final String category;
  final String date;
  final int priority;
  final bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.priority,
    required this.isCompleted,
  });

  Task copyWith({
    int? id,
    String? title,
    String? category,
    String? date,
    int? priority,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Add isCompleted in fromMap and toMap
  factory Task.fromMap(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    category: json['category'],
    date: json['date'],
    priority: json['priority'],
    isCompleted: json['isCompleted'] == 1,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'category': category,
    'date': date,
    'priority': priority,
    'isCompleted': isCompleted ? 1 : 0,
  };
}
