import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/core/helpers/prefs_helper.dart';
import 'package:atomic_habits/features/food_feature/domain/models/food_model.dart';
import 'package:dartz/dartz.dart';

abstract class FoodLocalDataSource {
  FunctionalFuture<Failure, List<FoodModel>> getFoods();

  FunctionalFuture<Failure, List<FoodModel>> addFood(FoodModel foodModel);

  FunctionalFuture<Failure, List<FoodModel>> deleteFood(FoodModel foodModel);

// FunctionalFuture<Failure, List<FoodModel>> submitFoods(
//     List<FoodModel> submittedHabits);
}

class FoodLocalDataSourceImpl extends FoodLocalDataSource {
  final PrefsHelper _prefsHelper;

  FoodLocalDataSourceImpl(this._prefsHelper);

  @override
  FunctionalFuture<Failure, List<FoodModel>> getFoods() async {
    try {
      final foods = _prefsHelper.getFoods();
      return Right(foods);
    } catch (e) {
      return Left(DatabaseFailure('Failed to retrieve foods: $e'));
    }
  }

  @override
  FunctionalFuture<Failure, List<FoodModel>> addFood(
      FoodModel foodModel) async {
    try {
      final foods = _prefsHelper.addFood(foodModel);
      return Right(foods);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add food: $e'));
    }
  }

  @override
  FunctionalFuture<Failure, List<FoodModel>> deleteFood(
      FoodModel foodModel) async {
    try {
      final foods = _prefsHelper.deleteFood(foodModel);
      return Right(foods);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete food: $e'));
    }
  }

// @override
// FunctionalFuture<Failure, List<FoodModel>> submitFoods(
//     List<FoodModel> submittedHabits) async {
//   try {
//     final habits = _prefsHelper.submitHabits(submittedHabits);
//     return Right(habits);
//   } catch (e) {
//     return Left(DatabaseFailure('Failed to retrieve habits: $e'));
//   }
// }
}
