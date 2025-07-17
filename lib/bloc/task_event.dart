import 'package:equatable/equatable.dart';
import '../../Data/model/task_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
  @override
  List<Object?> get props => [];
}

//load task event
class LoadTasks extends TaskEvent {}

//add task event
class AddTask extends TaskEvent {
  final Task task;
  const AddTask(this.task);
}

//delete task event
class DeleteTask extends TaskEvent {
  final Task task;
  const DeleteTask(this.task);
}

//search task event
class SearchTask extends TaskEvent {
  final String query;
  const SearchTask(this.query);
}

//task completion event
class ToggleTaskCompletion extends TaskEvent {
  final Task task;
  ToggleTaskCompletion(this.task);
}

//update task event
class UpdateTaskEvent extends TaskEvent {
  final Task task;
  UpdateTaskEvent(this.task);
}

//delete task event
class DeleteTaskEvent extends TaskEvent {
  final Task task;
  DeleteTaskEvent(this.task);
}
