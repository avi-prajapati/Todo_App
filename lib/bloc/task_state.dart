import 'package:equatable/equatable.dart';
import '../../Data/model/task_model.dart';

abstract class TaskState extends Equatable {
  const TaskState();
  @override
  List<Object?> get props => [];
}

//for task loading
class TaskLoading extends TaskState {}

//after task loaded
class TaskLoaded extends TaskState {
  final List<Task> tasks;
  const TaskLoaded(this.tasks);
  @override
  List<Object?> get props => [tasks];
}
