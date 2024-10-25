import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/core/helpers/prefs_helper.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:dartz/dartz.dart';

abstract class HabitLocalDataSource {
  FunctionalFuture<Failure, List<HabitModel>> getHabits();

  FunctionalFuture<Failure, List<HabitModel>> addHabit(HabitModel habitModel);
}

class HabitLocalDataSourceImpl extends HabitLocalDataSource {
  final PrefsHelper _prefsHelper;

  HabitLocalDataSourceImpl(this._prefsHelper);

  @override
  FunctionalFuture<Failure, List<HabitModel>> getHabits() async {
    try {
      final habits = _prefsHelper.getHabits();
      return Right(habits);
    } catch (e) {
      return Left(DatabaseFailure('Failed to retrieve habits: $e'));
    }
  }

  @override
  FunctionalFuture<Failure, List<HabitModel>> addHabit(
      HabitModel habitModel) async {
    try {
      final habits = _prefsHelper.addHabit(habitModel);
      return Right(habits);
    } catch (e) {
      return Left(DatabaseFailure('Failed to retrieve habits: $e'));
    }
  }
}
