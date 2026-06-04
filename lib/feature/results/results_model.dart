class ResultsModel {
  final int? id;
  final int studentId;
  final int courseId;
  final double score;

  ResultsModel({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.score,
  });

  factory ResultsModel.fromMap(Map<String, dynamic> map) {
    return ResultsModel(
      id: map['id'] ?? 0,
      studentId: map['student_id'] ?? 0,
      courseId: map['course_id'] ?? 0,
      score: (map['score'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'student_id': studentId,
      'course_id': courseId,
      'score': score,
    };
  }

}