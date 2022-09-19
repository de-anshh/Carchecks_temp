import 'city_model.dart';

class AddressModel {
  AddressModel({
    required this.message,
    required this.data,
    required this.success,
  });
  late final String message;
  late final List<AddressClass> data;
  late final bool success;

  AddressModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = List.from(json['data']).map((e)=>AddressClass.fromJson(e)).toList();
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['success'] = success;
    return _data;
  }
}

class AddressClass {
  AddressClass({
    required this.id,
    required this.created,
    required this.createdBy,
    required this.updated,
    required this.updatedBy,
    required this.active,
    required this.name,
    required this.street,
    required this.userId,
    required this.cityId,
    required this.zipCode,
    required this.landmark,
    required this.garrageAddress,
  });
  late final int id;
  late final String created;
  late final String createdBy;
  late final String updated;
  late final String updatedBy;
  late final bool active;
  late final String name;
  late final String street;
  late final int userId;
  late final int cityId;
  late final String zipCode;
  late final String landmark;
  late final bool garrageAddress;

  AddressClass.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    created = json['created']??'';
    createdBy = json['createdBy']??'';
    updated = json['updated']??'';
    updatedBy = json['updatedBy']??'';
    active = json['active']??true;
    name = json['name']??'';
    street = json['street']??'';
    userId = json['userId']??0;
    cityId = json['cityId']??0;
    zipCode = json['zipCode']??'';
    landmark = json['landmark']??'';
    garrageAddress = json['garrageAddress']??false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created'] = created;
    _data['createdBy'] = createdBy;
    _data['updated'] = updated;
    _data['updatedBy'] = updatedBy;
    _data['active'] = active;
    _data['name'] = name;
    _data['street'] = street;
    _data['userId'] = userId;
    _data['cityId'] = cityId;
    _data['zipCode'] = zipCode;
    _data['landmark'] = landmark;
    _data['garrageAddress'] = garrageAddress;
    return _data;
  }
}