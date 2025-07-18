import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/todo_controller.dart';
import '../widgets/todo_tile.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/error_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoController>().loadTasks();
    });
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        onAddTask: (title) => _addTask(title),
      ),
    );
  }

  Future<void> _addTask(String title) async {
    await context.read<TodoController>().addTask(title);
  }

  Future<void> _toggleTask(int index) async {
    await context.read<TodoController>().toggleTask(index);
  }

  Future<void> _deleteTask(int index) async {
    await context.read<TodoController>().deleteTask(index);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade400,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () => context.read<TodoController>().clearError(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'TODO',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: const Color(0xFF2C3E50),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer<TodoController>(
        builder: (context, controller, child) {
          // Показываем ошибку через SnackBar
          if (controller.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showErrorSnackBar(controller.errorMessage!);
            });
          }

          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2C3E50)),
              ),
            );
          }

          if (controller.tasks.isEmpty) {
            return const Center(
              child: Text(
                'No tasks yet!\nTap + to add your first task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              final task = controller.tasks[index];
              return TodoTile(
                task: task,
                onToggle: () => _toggleTask(index),
                onDelete: () => _deleteTask(index),
              );
            },
          );
        },
      ),
    );
  }
}