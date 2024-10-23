import 'package:atomic_habits/core/helpers/prefs_helper.dart';
import 'package:atomic_habits/core/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencyInjection() async {
  /// Features (Blocs, Repos and Data Sources)

  /// Core (Any part of Core that needs initialization)
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );
  getIt.registerLazySingleton<PrefsHelper>(
    () => PrefsHelper(
      prefs: getIt<SharedPreferences>(),
    ),
  );

  /// External (Shared Preferences, Connectivity, ...)
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(
    () => prefs,
  );
}
