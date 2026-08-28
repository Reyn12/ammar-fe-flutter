class HomeScheduleModel {
  const HomeScheduleModel({this.status, this.location, this.title, this.time});

  final String? status;
  final String? location;
  final String? title;
  final String? time;

  factory HomeScheduleModel.fromJson(Map<String, dynamic> json) {
    return HomeScheduleModel(
      // TODO: mapping status jadwal waiting confirm BE
      status: json['status']?.toString(),
      location: json['location']?.toString(),
      title: json['title']?.toString(),
      time: json['time']?.toString(),
    );
  }
}
