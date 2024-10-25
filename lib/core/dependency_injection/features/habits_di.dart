import 'package:atomic_habits/features/habits_feature/data/repositories/habit_repository_impl.dart';
import 'package:atomic_habits/features/habits_feature/data/sources/local_data_source.dart';
import 'package:atomic_habits/features/habits_feature/domain/repositories/abstract_habit_repository.dart';
import 'package:atomic_habits/features/habits_feature/domain/usecases/habit_use_case.dart';
import 'package:atomic_habits/features/habits_feature/presentation/bloc/habit_bloc.dart';
import 'package:get_it/get_it.dart';

void initHabitFeature(GetIt getIt) {
  getIt.registerSingleton(HabitLocalDataSourceImpl(getIt()));
  getIt.registerSingleton(HabitRepositoryImpl(getIt()));
  getIt
      .registerSingleton<AbstractHabitRepository>(HabitRepositoryImpl(getIt()));
  getIt.registerSingleton(HabitUseCase(getIt()));
  getIt.registerSingleton(HabitBloc(habitUseCase: getIt()));
}
