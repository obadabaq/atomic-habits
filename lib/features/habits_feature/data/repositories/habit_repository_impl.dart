import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/features/habits_feature/data/sources/local_data_source.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:atomic_habits/features/habits_feature/domain/repositories/abstract_habit_repository.dart';

class HabitRepositoryImpl extends AbstractHabitRepository {
  final HabitLocalDataSourceImpl _habitLocalDataSourceImpl;

  HabitRepositoryImpl(this._habitLocalDataSourceImpl);

  @override
  FunctionalFuture<Failure, List<HabitModel>> getHabits() async {
    return await _habitLocalDataSourceImpl.getHabits();
  }
}
