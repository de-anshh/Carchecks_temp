import 'package:carcheck/model/user_table_model.dart';
import 'package:carcheck/model/vehicle_model.dart';

class UserOrderModel {
  UserOrderModel({
    required this.message,
    required this.data,
    required this.success,
  });
  late final String message;
  late final List<UserOrder> data;
  late final bool success;

  UserOrderModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = List.from(json['data']).map((e)=>UserOrder.fromJson(e)).toList();
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

class UserOrder {
  UserOrder({
    required this.id,
    required this.created,
    required this.createdBy,
    required this.updated,
    required this.updatedBy,
    required this.active,
    required this.userTable,
    required this.vehicle,
    required this.totalAmout,
    required this.status,
    required this.invoiceNumber,
    required this.isBid,
  });
  late final int id;
  late final String created;
  late final String createdBy;
  late final String updated;
  late final String updatedBy;
  late final bool active;
  late final User userTable;
  late final Vehicle vehicle;
  late final int totalAmout;
  late final String status;
  late final String invoiceNumber;
  late final bool isBid;

  UserOrder.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    created = json['created']??'';
    createdBy = json['createdBy']??'';
    updated = json['updated']??'';
    updatedBy = json['updatedBy']??'';
    active = json['active']??true;
    userTable = User.fromJson(json['userTable']);
    vehicle = Vehicle.fromJson(json['vehicle']);
    totalAmout = json['total_amout']??0;
    status = json['status']??'';
    invoiceNumber = json['invoiceNumber']??'';
    isBid = json['isBid']??false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created'] = created;
    _data['createdBy'] = createdBy;
    _data['updated'] = updated;
    _data['updatedBy'] = updatedBy;
    _data['active'] = active;
    _data['userTable'] = userTable.toJson();
    _data['vehicle'] = vehicle.toJson();
    _data['total_amout'] = totalAmout;
    _data['status'] = status;
    _data['invoiceNumber'] = invoiceNumber;
    _data['isBid'] = isBid;
    return _data;
  }
}

