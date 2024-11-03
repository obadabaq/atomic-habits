import 'package:atomic_habits/core/abstracts/use_case.dart';
import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';
import 'package:atomic_habits/features/food_feature/domain/models/food_model.dart';
import 'package:atomic_habits/features/food_feature/domain/repositories/abstract_food_repository.dart';

class FoodUseCase extends UseCase<List<FoodModel>, NoParams> {
  final AbstractFoodRepository _abstractFoodRepository;

  FoodUseCase(this._abstractFoodRepository);

  @override
  FunctionalFuture<Failure, List<FoodModel>> call(params) {
    return _abstractFoodRepository.getFoods();
  }

  FunctionalFuture<Failure, List<FoodModel>> addFood(FoodModel foodModel) {
    return _abstractFoodRepository.addFood(foodModel);
  }

  FunctionalFuture<Failure, List<FoodModel>> deleteFood(FoodModel foodModel) {
    return _abstractFoodRepository.deleteFood(foodModel);
  }

// FunctionalFuture<Failure, List<HabitModel>> submitFoods(
//     List<HabitModel> submittedHabits) {
//   return _abstractHabitRepository.submitHabits(submittedHabits);
// }
}
