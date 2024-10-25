import 'package:atomic_habits/core/abstracts/use_case.dart';
import 'package:atomic_habits/features/habits_feature/domain/models/habit_model.dart';
import 'package:atomic_habits/features/habits_feature/domain/usecases/habit_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "habit_event.dart";

part "habit_state.dart";

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final HabitUseCase habitUseCase;

  HabitBloc({required this.habitUseCase}) : super(HabitInitial()) {
    on<OnGettingHabitsEvent>(_onGettingHabitsEvent);
    on<OnAddingHabitEvent>(_onAddingHabitsEvent);
  }

  _onGettingHabitsEvent(
      OnGettingHabitsEvent event, Emitter<HabitState> emitter) async {
    final result = await habitUseCase.call(
      NoParams(),
    );
    result.fold((l) {
      emitter(ErrorGetHabitsState(l.error));
    }, (r) {
      emitter(SuccessGetHabitsState(r));
    });
  }

  _onAddingHabitsEvent(
      OnAddingHabitEvent event, Emitter<HabitState> emitter) async {
    final result = await habitUseCase.addHabit(event.habitModel);
    result.fold((l) {
      emitter(ErrorGetHabitsState(l.error));
    }, (r) {
      emitter(SuccessGetHabitsState(r));
    });
  }
}
