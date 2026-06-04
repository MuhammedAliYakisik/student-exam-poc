class CourseModel {
  final int? id;
  final String name;

  CourseModel({
    required this.id,
    required this.name,
  });

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