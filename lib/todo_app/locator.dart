import 'package:get_it/get_it.dart';
import 'package:login_firebase/api.dart';
import 'package:login_firebase/todo_app/todo_tasks.dart';
import 'package:provider/provider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('task'));
  locator.registerLazySingleton(() => TodoTasks()) ;
}