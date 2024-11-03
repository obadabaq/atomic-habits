import 'package:atomic_habits/features/food_feature/domain/models/food_model.dart';

class Food extends FoodModel {
  Food({
    super.id,
    required super.name,
    required super.numOfCal,
    required super.numOfPro,
  });
}
