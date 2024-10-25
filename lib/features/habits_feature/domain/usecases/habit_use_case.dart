import 'package:atomic_habits/core/abstracts/use_case.dart';
import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:atomic_habits/features/habits_feature/domain/repositories/abstract_habit_repository.dart';

class HabitUseCase extends UseCase<List<HabitModel>, NoParams> {
  final AbstractHabitRepository _abstractHabitRepository;

  HabitUseCase(this._abstractHabitRepository);

  @override
  FunctionalFuture<Failure, List<HabitModel>> call(params) {
    return _abstractHabitRepository.getHabits();
  }
}
