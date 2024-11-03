part of 'food_bloc.dart';

abstract class FoodEvent {
  const FoodEvent();
}

class OnGettingFoodsEvent extends FoodEvent {
  const OnGettingFoodsEvent();
}

class OnAddingFoodEvent extends FoodEvent {
  final FoodModel foodModel;

  const OnAddingFoodEvent(this.foodModel);
}

class OnDeletingFoodEvent extends FoodEvent {
  final FoodModel foodModel;

  const OnDeletingFoodEvent(this.foodModel);
}

class OnSubmittingFoodsEvent extends FoodEvent {
  final List<FoodModel> submittedFoods;

  const OnSubmittingFoodsEvent(this.submittedFoods);
}
