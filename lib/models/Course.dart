enum Grades { AP, A, BP, B, CP, C, DP, D, F ,None}

class Course {
  final String id = DateTime.now().toString();
  String name;
  int hours;
  Grades grade;

  Course({required this.name, required this.hours, required this.grade});
}
