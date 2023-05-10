class Question {

  final String difficulty;
  final int points;
  final String statement;
  final List<dynamic> options;
  final int correctOption;

  Question({
    required this.difficulty,
    required this.points,
    required this.statement,
    required this.options,
    required this.correctOption,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      difficulty: json['difficulty'],
      points: json['points'],
      statement: json['statement'],
      options: List<String>.from(json['options']),
      correctOption: json['correctOption'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'difficulty': difficulty,
      'points': points,
      'statement': statement,
      'options': options,
      'correctOption': correctOption,
    };
  }
}