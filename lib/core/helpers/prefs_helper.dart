import 'dart:convert';
import 'package:atomic_habits/core/constants/prefs_keys.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  final SharedPreferences prefs;

  const PrefsHelper({
    required this.prefs,
  });

  List<HabitModel> getHabits() {
    final String? habitsPref = prefs.getString(PrefsKeys.habits);

    if (habitsPref == null) {
      return [];
    }

    final List<dynamic> habitsList = jsonDecode(habitsPref);
    return habitsList.map((item) => HabitModel.fromJson(item)).toList();
  }

  List<HabitModel> addHabit(HabitModel habitModel) {
    habitModel.value ??= false;
    List<HabitModel> habits = getHabits();
    habits.add(habitModel);

    prefs.setString(
        PrefsKeys.habits, jsonEncode(habits.map((h) => h.toJson()).toList()));

    return habits;
  }
}
