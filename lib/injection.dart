import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:provider_value/api.dart';
import 'package:provider_value/controller.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerSingleton<Api>(Api(dio: Dio()));
  getIt.registerFactory(() => Controller(getIt<Api>()));
}
