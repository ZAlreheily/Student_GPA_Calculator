import '../models/Course.dart';

class Term {
  late String id;
  late String name;
  late double gpa;

  late List<Course> courses;

  Term(this.id, this.name,this.gpa, this.courses);

  
}
