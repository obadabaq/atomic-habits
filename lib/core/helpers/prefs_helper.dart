import 'dart:convert';
import 'dart:math';
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
    List<HabitModel> habits = getHabits();

    habitModel.id = 10000 + Random().nextInt(90000);

    habits.add(habitModel);

    prefs.setString(
        PrefsKeys.habits, jsonEncode(habits.map((h) => h.toJson()).toList()));

    return habits;
  }

  List<HabitModel> deleteHabit(HabitModel habitModel) {
    List<HabitModel> habits = getHabits();
    habits.removeWhere((element) => element.id == habitModel.id);

    prefs.setString(
        PrefsKeys.habits, jsonEncode(habits.map((h) => h.toJson()).toList()));

    return habits;
  }

  List<HabitModel> submitHabits(List<HabitModel> submittedHabits) {
    List<HabitModel> habits = getHabits();

    for (var submitted in submittedHabits) {
      var existingHabitIndex = habits.indexWhere((h) => h.id == submitted.id);
      if (existingHabitIndex != -1) {
        habits[existingHabitIndex] = submitted;
      } else {
        habits.add(submitted);
      }
    }

    prefs.setString(
      PrefsKeys.habits,
      jsonEncode(habits.map((h) => h.toJson()).toList()),
    );

    return habits;
  }
}
