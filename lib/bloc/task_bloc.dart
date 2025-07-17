import 'package:flutter_bloc/flutter_bloc.dart';
import '../Data/model/task_model.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../../Data/repository/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
  List<Task> _allTasks = [];

  TaskBloc(this.repository) : super(TaskLoading()) {
    //for task loading
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      _allTasks = await repository.getTasks();
      emit(TaskLoaded(_allTasks));
    });

    //for searching
    on<SearchTask>((event, emit) {
      final filtered = _allTasks
          .where(
            (task) =>
                task.title.toLowerCase().contains(event.query.toLowerCase()),
          )
          .toList();
      emit(TaskLoaded(filtered));
    });

    //for inserting task
    on<AddTask>((event, emit) async {
      await repository.insertTask(event.task);
      add(LoadTasks());
    });

    //for deleting task
    on<DeleteTask>((event, emit) async {
      await repository.deleteTask(event.task.id!);
      add(LoadTasks());
    });

    //for complete status
    on<ToggleTaskCompletion>((event, emit) async {
      Task updatedTask = Task(
        id: event.task.id,
        title: event.task.title,
        category: event.task.category,
        date: event.task.date,
        priority: event.task.priority,
        isCompleted: !event.task.isCompleted,
      );
      await repository.updateTask(updatedTask);
      _allTasks = await repository.getTasks();
      _sortTasks();
      emit(TaskLoaded(_allTasks));
    });

    //for update task status
    on<UpdateTaskEvent>((event, emit) async {
      await repository.updateTask(event.task);
      final tasks = await repository.getTasks();
      // Sort: incomplete tasks first, by priority
      tasks.sort((a, b) {
        int completedCompare =
            (a.isCompleted ? 1 : 0) - (b.isCompleted ? 1 : 0);
        if (completedCompare != 0) return completedCompare;
        return a.priority.compareTo(b.priority);
      });

      emit(TaskLoaded(tasks));
    });

    on<DeleteTaskEvent>((event, emit) async {
      await repository.deleteTask(event.task.id!);
      final tasks = await repository.getTasks();
      emit(TaskLoaded(tasks));
    });
  }

  //function to sort task
  void _sortTasks() {
    _allTasks.sort((a, b) {
      if (a.isCompleted == b.isCompleted) return 0;
      return a.isCompleted ? 1 : -1;
    });
  }
}
