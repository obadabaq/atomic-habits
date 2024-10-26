import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';

class Habit extends HabitModel {
  Habit({
    super.id,
    required super.name,
    required super.question,
    required super.submissions,
  });
}
