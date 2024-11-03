import 'package:atomic_habits/features/habits_feature/domain/models/submission_model.dart';

class FoodModel {
  int? id;
  final String name;
  final int numOfCal;
  final int numOfPro;

  FoodModel({
    this.id,
    required this.name,
    required this.numOfCal,
    required this.numOfPro,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      numOfCal: json['numOfCal'],
      numOfPro: json['numOfPro'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'numOfCal': numOfCal,
      'numOfPro': numOfPro,
    };
  }
}
