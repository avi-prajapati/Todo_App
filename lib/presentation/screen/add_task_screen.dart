import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/task_bloc.dart';

import '../../Data/model/task_model.dart';
import '../../bloc/task_event.dart';
import '../helper/helper.dart';
import '../widget/caategory_picker_dialog.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'University';
  int _priority = 1;

  //for picking date
  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  //for picking category
  void _pickCategory() async {
    final category = await showDialog<String>(
      context: context,
      builder: (_) => CategoryPickerDialog(selected: _selectedCategory),
    );
    if (category != null) setState(() => _selectedCategory = category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      //body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text("Title", style: TextStyle(color: Colors.white70)),

            //for adding some space
            SizedBox(height: 8),

            //title text field
            TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter Task Title',
                hintStyle: TextStyle(color: Colors.white38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey[900],
              ),
            ),

            //for adding some space.
            SizedBox(height: 20),

            //for date
            _buildFieldRow(
              icon: Icons.access_time,
              label: 'Task Date :',
              child: _buildInfoBox(
                text: DateFormat('dd - MMM - yyyy').format(_selectedDate),
                onTap: _pickDate,
              ),
            ),

            //for category
            _buildFieldRow(
              icon: Icons.category,
              label: 'Task Category :',
              child: _buildInfoBox(
                icon: Icons.school,
                text: _selectedCategory,
                onTap: _pickCategory,
              ),
            ),

            //for priority
            _buildFieldRow(
              icon: Icons.flag,
              label: 'Task Priority :',
              child: _buildInfoBox(
                icon: Icons.flag,
                text: _priority.toString(),
                onTap: () {
                  setState(
                    () => _priority = _priority == 10 ? 1 : _priority + 1,
                  );
                },
              ),
            ),

            //for placing add task button at bottom
            Spacer(),

            //add task button.
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String user_title = _titleController.text;
                  if (user_title.length != 0) {
                    final task = Task(
                      title: _titleController.text,
                      date: _selectedDate.toIso8601String(),
                      category: _selectedCategory,
                      priority: _priority,
                      isCompleted: false,
                    );
                    context.read<TaskBloc>().add(AddTask(task));
                    Navigator.pop(context);
                  } else {
                    Helper.showCustomSnackbar(
                      context,
                      message: 'Please Provide Title',
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text("Add Task", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //build field row function
  Widget _buildFieldRow({
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          SizedBox(width: 12),
          Expanded(
            child: Text(label, style: TextStyle(color: Colors.white70)),
          ),
          child,
        ],
      ),
    );
  }

  //build information Box function
  Widget _buildInfoBox({
    required String text,
    IconData? icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white70, size: 18),
              SizedBox(width: 6),
            ],
            Text(text, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
