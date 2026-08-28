class UserAcademicModel {
  const UserAcademicModel({
    this.gpa,
    this.latestSemesterGpa,
    this.creditsPassed,
    this.programName,
    this.facultyName,
    this.studentStatus,
    this.advisorName,
    this.entryPeriod,
    this.studySemester,
    this.degreeLevel,
    this.campus,
  });

  final double? gpa;
  final double? latestSemesterGpa;
  final int? creditsPassed;
  final String? programName;
  final String? facultyName;
  final String? studentStatus;
  final String? advisorName;
  final String? entryPeriod;
  final int? studySemester;
  final String? degreeLevel;
  final String? campus;

  factory UserAcademicModel.fromJson(Map<String, dynamic> json) {
    return UserAcademicModel(
      gpa: (json['gpa'] as num?)?.toDouble(),
      latestSemesterGpa: (json['latest_semester_gpa'] as num?)?.toDouble(),
      creditsPassed: (json['credits_passed'] as num?)?.toInt(),
      programName: json['program_name']?.toString(),
      facultyName: json['faculty_name']?.toString(),
      studentStatus: json['student_status']?.toString(),
      advisorName: json['advisor_name']?.toString(),
      entryPeriod: json['entry_period']?.toString(),
      studySemester: (json['study_semester'] as num?)?.toInt(),
      degreeLevel: json['degree_level']?.toString(),
      campus: json['campus']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gpa': gpa,
      'latest_semester_gpa': latestSemesterGpa,
      'credits_passed': creditsPassed,
      'program_name': programName,
      'faculty_name': facultyName,
      'student_status': studentStatus,
      'advisor_name': advisorName,
      'entry_period': entryPeriod,
      'study_semester': studySemester,
      'degree_level': degreeLevel,
      'campus': campus,
    };
  }
}
