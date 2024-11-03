import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/features/food_feature/data/sources/local_data_source.dart';
import 'package:atomic_habits/features/food_feature/domain/models/food_model.dart';
import 'package:atomic_habits/features/food_feature/domain/repositories/abstract_food_repository.dart';

class FoodRepositoryImpl extends AbstractFoodRepository {
  final FoodLocalDataSourceImpl _foodLocalDataSourceImpl;

  FoodRepositoryImpl(this._foodLocalDataSourceImpl);

  @override
  FunctionalFuture<Failure, List<FoodModel>> getFoods() async {
    return await _foodLocalDataSourceImpl.getFoods();
  }

  @override
  FunctionalFuture<Failure, List<FoodModel>> addFood(
      FoodModel foodModel) async {
    return await _foodLocalDataSourceImpl.addFood(foodModel);
  }

  @override
  FunctionalFuture<Failure, List<FoodModel>> deleteFood(
      FoodModel foodModel) async {
    return await _foodLocalDataSourceImpl.deleteFood(foodModel);
  }

// @override
// FunctionalFuture<Failure, List<HabitModel>> submitHabits(
//     List<HabitModel> submittedHabits) async {
//   return await _habitLocalDataSourceImpl.submitHabits(submittedHabits);
// }
}
