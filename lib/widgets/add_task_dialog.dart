import 'package:flutter/material.dart';
import 'custom_button.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(String) onAddTask;

  const AddTaskDialog({
    super.key,
    required this.onAddTask,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSave() {
    final String title = _controller.text.trim();
    
    if (title.isEmpty) {
      setState(() {
        _errorMessage = 'Task title cannot be empty';
      });
      return;
    }

    if (title.length > 200) {
      setState(() {
        _errorMessage = 'Task title is too long (max 200 characters)';
      });
      return;
    }

    widget.onAddTask(title);
    Navigator.of(context).pop();
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF34495E),
      title: const Text(
        'Add New Task',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            maxLength: 200,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: 'Enter task title...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              errorText: _errorMessage,
              errorStyle: const TextStyle(color: Colors.red),
            ),
            onChanged: (_) {
              if (_errorMessage != null) {
                setState(() {
                  _errorMessage = null;
                });
              }
            },
            onSubmitted: (_) => _handleSave(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: 'Cancel',
                onPressed: _handleCancel,
                backgroundColor: Colors.grey.shade600,
              ),
              CustomButton(
                text: 'Save',
                onPressed: _handleSave,
                backgroundColor: Colors.green.shade600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}