part of 'habit_bloc.dart';

abstract class HabitEvent {
  const HabitEvent();
}

class OnGettingHabitsEvent extends HabitEvent {
  const OnGettingHabitsEvent();
}
