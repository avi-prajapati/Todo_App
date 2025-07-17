import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/presentation/screen/splash_screen.dart';

import 'Data/data_provider/task_db_provider.dart';
import 'Data/repository/task_repository.dart';

import 'bloc/task_bloc.dart';
import 'bloc/task_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbProvider = TaskDbProvider();
  await dbProvider.init();
  final repository = TaskRepository(dbProvider);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final TaskRepository repository;
  const MyApp({required this.repository, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //providing bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc(repository)..add(LoadTasks())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: SplashScreen(),
      ),
    );
  }
}
