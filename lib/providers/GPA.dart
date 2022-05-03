import 'package:flutter/foundation.dart';

import '../models/Course.dart';
import '../models/Term.dart';

class GPA extends ChangeNotifier {
  double currentgpa = 0;
  int hours = 0;
  double points = 0;
  bool isOutOfFive;
  List<Term> terms;

  GPA(this.currentgpa, this.hours, this.isOutOfFive, this.terms) {
    points = currentgpa * hours;
    notifyListeners();
  }

  void clear() {
    currentgpa = 0;
    hours = 0;
    points = 0;
    terms = [];
    notifyListeners();
  }

  void toggleisOutOfFive() {
    isOutOfFive = !isOutOfFive;
    currentgpa = 0;
    hours = 0;
    points = 0;
    terms.forEach((element) {
      element.gpa = calculategpaForTerm(element.courses);
    });
    calculategpaForAllTerms();
  }

  void calculategpa(List<Course> courseList) {
    points = currentgpa * hours;
    int tmpHours = 0;
    double tmppoints = 0;
    for (var element in courseList) {
      tmpHours += element.hours;
      Grades grade = element.grade;
      if (grade == Grades.AP) {
        tmppoints += (isOutOfFive ? 5 : 4) * (element.hours);
      } else if (grade == Grades.A) {
        tmppoints += (isOutOfFive ? 4.75 : 3.75) * (element.hours);
      } else if (grade == Grades.BP) {
        tmppoints += (isOutOfFive ? 4.5 : 3.5) * (element.hours);
      } else if (grade == Grades.B) {
        tmppoints += (isOutOfFive ? 4 : 3) * (element.hours);
      } else if (grade == Grades.CP) {
        tmppoints += (isOutOfFive ? 3.5 : 2.5) * (element.hours);
      } else if (grade == Grades.C) {
        tmppoints += (isOutOfFive ? 3 : 2) * (element.hours);
      } else if (grade == Grades.DP) {
        tmppoints += (isOutOfFive ? 2.5 : 1.5) * (element.hours);
      } else if (grade == Grades.D) {
        tmppoints += (isOutOfFive ? 2 : 1) * (element.hours);
      } else if (grade == Grades.F) {
        tmppoints += (isOutOfFive ? 1 : 0) * (element.hours);
      }
    }
    hours += tmpHours;
    points += tmppoints;
    if (hours == 0) {
      currentgpa = 0;
    } else {
      currentgpa = points / hours;
    }

    notifyListeners();
  }

  double calculategpaForTerm(List<Course> courseList) {
    int tmpHours = 0;
    double tmppoints = 0;
    for (var element in courseList) {
      tmpHours += element.hours;
      Grades grade = element.grade;
      if (grade == Grades.AP) {
        tmppoints += (isOutOfFive ? 5 : 4) * (element.hours);
      } else if (grade == Grades.A) {
        tmppoints += (isOutOfFive ? 4.75 : 3.75) * (element.hours);
      } else if (grade == Grades.BP) {
        tmppoints += (isOutOfFive ? 4.5 : 3.5) * (element.hours);
      } else if (grade == Grades.B) {
        tmppoints += (isOutOfFive ? 4 : 3) * (element.hours);
      } else if (grade == Grades.CP) {
        tmppoints += (isOutOfFive ? 3.5 : 2.5) * (element.hours);
      } else if (grade == Grades.C) {
        tmppoints += (isOutOfFive ? 3 : 2) * (element.hours);
      } else if (grade == Grades.DP) {
        tmppoints += (isOutOfFive ? 2.5 : 1.5) * (element.hours);
      } else if (grade == Grades.D) {
        tmppoints += (isOutOfFive ? 2 : 1) * (element.hours);
      } else if (grade == Grades.F) {
        tmppoints += (isOutOfFive ? 1 : 0) * (element.hours);
      }
    }
    if (tmpHours == 0) {
      return 0;
    } else {
      return tmppoints / tmpHours;
    }
  }

  void calculategpaForAllTerms() {
    List<Course> courseList = [];
    terms.forEach((element) {
      courseList.addAll(element.courses);
    });
    int tmpHours = 0;
    double tmppoints = 0;
    for (var element in courseList) {
      tmpHours += element.hours;
      Grades grade = element.grade;
      if (grade == Grades.AP) {
        tmppoints += (isOutOfFive ? 5 : 4) * (element.hours);
      } else if (grade == Grades.A) {
        tmppoints += (isOutOfFive ? 4.75 : 3.75) * (element.hours);
      } else if (grade == Grades.BP) {
        tmppoints += (isOutOfFive ? 4.5 : 3.5) * (element.hours);
      } else if (grade == Grades.B) {
        tmppoints += (isOutOfFive ? 4 : 3) * (element.hours);
      } else if (grade == Grades.CP) {
        tmppoints += (isOutOfFive ? 3.5 : 2.5) * (element.hours);
      } else if (grade == Grades.C) {
        tmppoints += (isOutOfFive ? 3 : 2) * (element.hours);
      } else if (grade == Grades.DP) {
        tmppoints += (isOutOfFive ? 2.5 : 1.5) * (element.hours);
      } else if (grade == Grades.D) {
        tmppoints += (isOutOfFive ? 2 : 1) * (element.hours);
      } else if (grade == Grades.F) {
        tmppoints += (isOutOfFive ? 1 : 0) * (element.hours);
      }
    }

    if (tmpHours == 0) {
      currentgpa = 0;
    } else {
      currentgpa = tmppoints / tmpHours;
    }

    notifyListeners();
  }

  addTerm(Term term) {
    terms.add(term);
    notifyListeners();
  }
}
