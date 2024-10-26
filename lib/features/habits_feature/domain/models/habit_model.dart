import 'package:atomic_habits/features/habits_feature/domain/models/submission_model.dart';

class HabitModel {
  int? id;
  final String name;
  final String question;
  final List<SubmissionModel> submissions;

  HabitModel({
    this.id,
    required this.name,
    required this.question,
    required this.submissions,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    List<SubmissionModel> tmp = [];
    for (int i = 0; i < json['submissions'].length; i++) {
      tmp.add(SubmissionModel.fromJson(json['submissions'][i]));
    }
    return HabitModel(
      id: json['id'],
      name: json['name'],
      question: json['question'],
      submissions: tmp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'question': question,
      'submissions': submissions,
    };
  }
}
