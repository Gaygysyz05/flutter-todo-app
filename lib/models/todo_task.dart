class TodoTask {
  final String title;
  final bool isCompleted;

  const TodoTask({
    required this.title,
    required this.isCompleted,
  });

  TodoTask copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return TodoTask(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  List<dynamic> toList() => [title, isCompleted];

  factory TodoTask.fromList(List<dynamic> list) {
    if (list.length < 2) {
      throw ArgumentError('Invalid list format for TodoTask');
    }
    return TodoTask(
      title: list[0]?.toString() ?? '',
      isCompleted: list[1] as bool? ?? false,
    );
  }
}