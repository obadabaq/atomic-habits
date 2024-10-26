class SubmissionModel {
  bool value;
  final String date;

  SubmissionModel({
    required this.value,
    required this.date,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      value: json['value'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'date': date,
    };
  }
}
