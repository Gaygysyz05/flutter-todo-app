import 'package:flutter/material.dart';
import '../../models/todo_task.dart';
import '../../services/todo_service.dart';

class TodoController extends ChangeNotifier {
  final TodoService _todoService;
  
  List<TodoTask> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;

  TodoController(this._todoService);

  List<TodoTask> get tasks => List.unmodifiable(_tasks);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  Future<void> loadTasks() async {
    await _performAsyncOperation(() async {
      _tasks = await _todoService.getAllTasks();
    });
  }

  Future<void> addTask(String title) async {
    await _performAsyncOperation(() async {
      await _todoService.createTask(title);
      await loadTasks();
    });
  }

  Future<void> toggleTask(int index) async {
    if (index < 0 || index >= _tasks.length) {
      _setError('Invalid task index');
      return;
    }

    await _performAsyncOperation(() async {
      final task = _tasks[index];
      await _todoService.toggleTaskCompletion(index, !task.isCompleted);
      await loadTasks();
    });
  }

  Future<void> deleteTask(int index) async {
    if (index < 0 || index >= _tasks.length) {
      _setError('Invalid task index');
      return;
    }

    await _performAsyncOperation(() async {
      await _todoService.removeTask(index);
      await loadTasks();
    });
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> _performAsyncOperation(Future<void> Function() operation) async {
    _setLoading(true);
    _clearError();
    
    try {
      await operation();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}