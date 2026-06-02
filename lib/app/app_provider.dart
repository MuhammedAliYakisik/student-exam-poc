import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:studen_exam_poc/feature/student/student_view_model.dart';

class ApplicationProvider {
  static final ApplicationProvider instance = ApplicationProvider._init();
  ApplicationProvider._init();

  List<SingleChildWidget> providers = [

    //student
    ChangeNotifierProvider(create: (context) => StudentViewModel()),
  ];




}