part of 'food_bloc.dart';

abstract class FoodState {
  const FoodState();
}

class FoodInitial extends FoodState {}

class SuccessGetFoodsState extends FoodState {
  final List<FoodModel> foods;

  SuccessGetFoodsState(this.foods);
}

class ErrorGetFoodsState extends FoodState {
  final String error;

  ErrorGetFoodsState(this.error);
}

class SuccessSubmitFoodsState extends FoodState {}

class ErrorSubmitFoodsState extends FoodState {
  final String error;

  ErrorSubmitFoodsState(this.error);
}
