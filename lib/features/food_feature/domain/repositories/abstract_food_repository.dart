import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/features/food_feature/domain/models/food_model.dart';

abstract class AbstractFoodRepository {
  FunctionalFuture<Failure, List<FoodModel>> getFoods();

  FunctionalFuture<Failure, List<FoodModel>> addFood(FoodModel foodModel);

  FunctionalFuture<Failure, List<FoodModel>> deleteFood(FoodModel foodModel);

// FunctionalFuture<Failure, List<HabitModel>> submitHabits(
//     List<HabitModel> submittedHabits);
}
