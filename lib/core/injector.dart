import 'package:cab_zing/Data/local_storage.dart';
import 'package:cab_zing/core/api_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());
  getIt.registerLazySingleton<ApiHelper>(() => ApiHelper(getIt<LocalStorage>()));
}
