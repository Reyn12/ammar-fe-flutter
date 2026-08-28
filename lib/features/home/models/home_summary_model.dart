class HomeSummaryModel {
  const HomeSummaryModel({
    this.name,
    this.subtitle,
    this.cumulativeGpa,
    this.semesterGpa,
    this.semesterBill,
    this.paymentStatus,
    this.avatar,
  });

  final String? name;
  final String? subtitle;
  final String? cumulativeGpa;
  final String? semesterGpa;
  final String? semesterBill;
  final String? paymentStatus;
  final String? avatar;

  factory HomeSummaryModel.fromJson(Map<String, dynamic> json) {
    return HomeSummaryModel(
      name: json['name']?.toString(),
      subtitle: json['subtitle']?.toString(),
      cumulativeGpa: json['cumulative_gpa']?.toString(),
      semesterGpa: json['semester_gpa']?.toString(),
      semesterBill: json['semester_bill']?.toString(),
      paymentStatus: json['payment_status']?.toString(),
      avatar: json['avatar']?.toString(),
    );
  }
}
