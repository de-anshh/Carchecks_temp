import 'package:carcheck/model/user_table_model.dart';

class LoginResponseResponse {
  LoginResponseResponse({
    required this.message,
    required this.data,
    required this.success,
  });
  late final String message;
  late final User data;
  late final bool success;

  LoginResponseResponse.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = User.fromJson(json['data']);
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    _data['success'] = success;
    return _data;
  }
}

