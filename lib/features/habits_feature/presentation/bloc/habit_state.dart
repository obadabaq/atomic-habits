part of 'habit_bloc.dart';

abstract class HabitState {
  const HabitState();
}

class HabitInitial extends HabitState {}

class SuccessGetHabitsState extends HabitState {
  final List<HabitModel> habits;

  SuccessGetHabitsState(this.habits);
}

class ErrorGetHabitsState extends HabitState {
  final String error;

  ErrorGetHabitsState(this.error);
}
