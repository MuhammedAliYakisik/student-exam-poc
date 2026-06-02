class StudentModel{
  final int? id;
  final String fullName;
  final String number;
  final String email;
  final String gsmNumber;

  StudentModel({
    required this.id,
    required this.fullName,
    required this.number,
    required this.email,
    required this.gsmNumber,
  });

  factory StudentModel.fromMap(Map<String,dynamic> map){
    return StudentModel(
      id: map['id'] ?? 0,
      fullName: map['full_name'] ?? '',
      number: map['number'] ?? '',
      email: map['email'] ?? '',
      gsmNumber: map['gsm_number'] ?? '',
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'full_name': fullName,
      'number': number,
      'email': email,
      'gsm_number': gsmNumber,
    };
  }
}