class HabitModel {
  final String name;
  final String question;
  bool value;

  HabitModel({
    required this.name,
    required this.question,
    required this.value,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      name: json['name'],
      question: json['question'],
      value: json['value'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'question': question,
      'value': value,
    };
  }
}
