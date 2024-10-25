import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';

abstract class AbstractHabitRepository {
  FunctionalFuture<Failure, List<HabitModel>> getHabits();
}
