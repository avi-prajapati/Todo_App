import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/task_bloc.dart';
import 'package:todo_app/bloc/task_event.dart';
import 'package:todo_app/presentation/helper/helper.dart';

import '../../Data/model/task_model.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //for format date
    final formattedDate = DateFormat(
      'dd MMM yyyy',
    ).format(DateTime.parse(task.date));

    //Actual Task UI
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Completion Radio
          GestureDetector(
            onTap: () {
              context.read<TaskBloc>().add(
                UpdateTaskEvent(task.copyWith(isCompleted: !task.isCompleted)),
              );
            },
            child: Icon(
              task.isCompleted
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: task.isCompleted
                  ? Colors.deepPurpleAccent
                  : Colors.white38,
            ),
          ),

          //for adding some space
          const SizedBox(width: 12),

          // Title and Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: task.isCompleted ? Colors.white38 : Colors.white,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),

                //for adding some space
                const SizedBox(height: 4),

                //to show date
                Text(
                  formattedDate,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),

          // Category Badge
          _buildBadge(
            icon: Helper.getIconFromCategory(
              task.category.toString().toLowerCase(),
            ),
            label: task.category,
            color: Helper.getColorFromCategory(
              task.category.toString().toLowerCase(),
            ),
          ),

          //for adding some space
          const SizedBox(width: 5),

          // Priority Badge
          _buildBadge(
            icon: Icons.flag,
            label: task.priority.toString(),
            color: Colors.grey.shade800,
          ),

          //for adding some space.
          // const SizedBox(width: 1),

          // Delete Icon
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTaskEvent(task));
            },
          ),
        ],
      ),
    );
  }

  //function for building badge.
  Widget _buildBadge({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),

          //for adding some space
          const SizedBox(width: 4),

          //category label
          Text(label, style: TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}
