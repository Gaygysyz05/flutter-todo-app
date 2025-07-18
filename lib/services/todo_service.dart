import '../models/todo_task.dart';
import '../repositories/todo_repository.dart';

class TodoService {
  final TodoRepository _repository;
  
  TodoService(this._repository);

  Future<List<TodoTask>> getAllTasks() async {
    return await _repository.getTasks();
  }

  Future<void> createTask(String title) async {
    final String trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      throw ValidationException('Task title cannot be empty');
    }
    
    if (trimmedTitle.length > 200) {
      throw ValidationException('Task title is too long (max 200 characters)');
    }

    final task = TodoTask(title: trimmedTitle, isCompleted: false);
    await _repository.addTask(task);
  }

  Future<void> toggleTaskCompletion(int index, bool isCompleted) async {
    final tasks = await _repository.getTasks();
    if (index < 0 || index >= tasks.length) {
      throw ValidationException('Invalid task index');
    }
    
    final updatedTask = tasks[index].copyWith(isCompleted: isCompleted);
    await _repository.updateTask(index, updatedTask);
  }

  Future<void> removeTask(int index) async {
    final tasks = await _repository.getTasks();
    if (index < 0 || index >= tasks.length) {
      throw ValidationException('Invalid task index');
    }
    
    await _repository.deleteTask(index);
  }
}

class ValidationException implements Exception {
  final String message;
  const ValidationException(this.message);
  
  @override
  String toString() => 'ValidationException: $message';
}