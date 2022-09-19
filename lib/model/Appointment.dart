class Appointment {
  Appointment({
    required this.id,
    required this.date,
    required this.time,
    required this.status,
    required this.availableTime,
    required this.active,
    required this.accept,
    required this.userId,
    required this.garrageId,
    required this.subServiceId,
  });
  late final int id;
  late final String date;
  late final String time;
  late final String status;
  late final String availableTime;
  late final bool active;
  late final bool accept;
  late final int userId;
  late final int garrageId;
  late final int subServiceId;

  Appointment.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    date = json['date']??'';
    time = json['time']??"";
    status = json['status']??'';
    availableTime = json['availableTime']??'';
    active = json['active'];
    accept = json['accept'];
    userId = json['userId'];
    garrageId = json['garrageId'];
    subServiceId = json['subServiceId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date;
    _data['time'] = time;
    _data['status'] = status;
    _data['availableTime'] = availableTime;
    _data['active'] = active;
    _data['accept'] = accept;
    _data['userId'] = userId;
    _data['garrageId'] = garrageId;
    _data['subServiceId'] = subServiceId;
    return _data;
  }
}