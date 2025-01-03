import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';

abstract class AbstractHabitRepository {
  FunctionalFuture<Failure, List<HabitModel>> getHabits();

  FunctionalFuture<Failure, List<HabitModel>> addHabit(HabitModel habitModel);

  FunctionalFuture<Failure, List<HabitModel>> deleteHabit(
      HabitModel habitModel);

  FunctionalFuture<Failure, List<HabitModel>> submitHabits(
      List<HabitModel> submittedHabits);
}
