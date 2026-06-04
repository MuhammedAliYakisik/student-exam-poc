class CourseModel {
  final int? id;
  final String name;

  CourseModel({
    required this.id,
    required this.name,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CourseModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory CourseModel.fromMap(Map<String,dynamic> map){
    return CourseModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
    };
  }
}

