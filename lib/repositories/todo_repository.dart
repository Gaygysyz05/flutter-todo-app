import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo_task.dart';

abstract class TodoRepository {
  Future<List<TodoTask>> getTasks();
  Future<void> saveTasks(List<TodoTask> tasks);
  Future<void> addTask(TodoTask task);
  Future<void> updateTask(int index, TodoTask task);
  Future<void> deleteTask(int index);
}

class HiveTodoRepository implements TodoRepository {
  static const String _boxName = 'todo_box';
  static const String _tasksKey = 'tasks';
  
  Box? _box;

  Future<void> initialize() async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox(_boxName);
    }
  }

  Box get box {
    if (_box == null || !_box!.isOpen) {
      throw StateError('Repository not initialized. Call initialize() first.');
    }
    return _box!;
  }

  @override
  Future<List<TodoTask>> getTasks() async {
    try {
      await initialize();
      final List<dynamic>? rawTasks = box.get(_tasksKey);
      
      if (rawTasks == null) {
        return _getDefaultTasks();
      }

      return rawTasks
          .map((item) => TodoTask.fromList(item as List<dynamic>))
          .toList();
    } catch (e) {
      throw TodoRepositoryException('Failed to load tasks: $e');
    }
  }

  @override
  Future<void> saveTasks(List<TodoTask> tasks) async {
    try {
      await initialize();
      final List<List<dynamic>> rawTasks = tasks
          .map((task) => task.toList())
          .toList();
      
      await box.put(_tasksKey, rawTasks);
    } catch (e) {
      throw TodoRepositoryException('Failed to save tasks: $e');
    }
  }

  @override
  Future<void> addTask(TodoTask task) async {
    final tasks = await getTasks();
    tasks.add(task);
    await saveTasks(tasks);
  }

  @override
  Future<void> updateTask(int index, TodoTask task) async {
    final tasks = await getTasks();
    if (index < 0 || index >= tasks.length) {
      throw ArgumentError('Invalid task index: $index');
    }
    tasks[index] = task;
    await saveTasks(tasks);
  }

  @override
  Future<void> deleteTask(int index) async {
    final tasks = await getTasks();
    if (index < 0 || index >= tasks.length) {
      throw ArgumentError('Invalid task index: $index');
    }
    tasks.removeAt(index);
    await saveTasks(tasks);
  }

  List<TodoTask> _getDefaultTasks() {
    return [
      const TodoTask(title: 'Write your task here.', isCompleted: false),
      const TodoTask(title: 'Let\'s enjoy!', isCompleted: false),
    ];
  }
}

class TodoRepositoryException implements Exception {
  final String message;
  const TodoRepositoryException(this.message);
  
  @override
  String toString() => 'TodoRepositoryException: $message';
}