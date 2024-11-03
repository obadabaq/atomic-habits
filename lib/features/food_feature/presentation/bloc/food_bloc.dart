import 'package:atomic_habits/core/abstracts/use_case.dart';
import 'package:atomic_habits/features/food_feature/domain/models/food_model.dart';
import 'package:atomic_habits/features/food_feature/domain/usecases/food_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "food_event.dart";

part "food_state.dart";

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodUseCase foodUseCase;

  FoodBloc({required this.foodUseCase}) : super(FoodInitial()) {
    on<OnGettingFoodsEvent>(_onGettingFoodsEvent);
    on<OnAddingFoodEvent>(_onAddingFoodsEvent);
    on<OnDeletingFoodEvent>(_onDeletingFoodsEvent);
    on<OnSubmittingFoodsEvent>(_onSubmittingFoodsEvent);
  }

  _onGettingFoodsEvent(
      OnGettingFoodsEvent event, Emitter<FoodState> emitter) async {
    final result = await foodUseCase.call(
      NoParams(),
    );
    result.fold((l) {
      emitter(ErrorGetFoodsState(l.error));
    }, (r) {
      emitter(SuccessGetFoodsState(r));
    });
  }

  _onAddingFoodsEvent(
      OnAddingFoodEvent event, Emitter<FoodState> emitter) async {
    final result = await foodUseCase.addFood(event.foodModel);
    result.fold((l) {
      emitter(ErrorGetFoodsState(l.error));
    }, (r) {
      emitter(SuccessGetFoodsState(r));
    });
  }

  _onDeletingFoodsEvent(
      OnDeletingFoodEvent event, Emitter<FoodState> emitter) async {
    final result = await foodUseCase.deleteFood(event.foodModel);
    result.fold((l) {
      emitter(ErrorGetFoodsState(l.error));
    }, (r) {
      emitter(SuccessGetFoodsState(r));
    });
  }

  _onSubmittingFoodsEvent(
      OnSubmittingFoodsEvent event, Emitter<FoodState> emitter) async {
    // final result = await foodUseCase.submitHabits(event.submittedFoods);
    emitter(SuccessSubmitFoodsState());
    // result.fold((l) {
    //   emitter(ErrorSubmitHabitsState(l.error));
    // }, (r) {
    //   emitter(SuccessSubmitHabitsState(r));
    // });
  }
}
