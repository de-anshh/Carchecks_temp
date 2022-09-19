
import 'package:carcheck/model/fuel_type_model.dart';
import 'package:carcheck/model/vehicle_manufacturer_model.dart';
import 'package:carcheck/model/vehicle_type_model.dart';


class VehicleModel {
  VehicleModel({
    required this.message,
    required this.data,
    required this.success,
  });
  late final String message;
  late final List<Vehicle> data;
  late final bool success;

  VehicleModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = List.from(json['data']).map((e)=>Vehicle.fromJson(e)).toList();
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

class Vehicle {
  Vehicle({
    required this.id,
    required this.created,
    required this.createdBy,
    required this.updated,
    required this.updatedBy,
    required this.active,
    required this.userId,
    required this.vehicleManufacturer,
    required this.vehicleModel,
    required this.fueltype,
    required this.photosUrl,
    required this.vehicletype,
    required this.yearOfManufacturing,
    required this.registrationNo,
    required this.lastServiceDate,
    required this.name,
  });
  late final int id;
  late final String created;
  late final String createdBy;
  late final String updated;
  late final String updatedBy;
  late final bool active;
  late final int userId;
  late final VehicleManufacturer vehicleManufacturer;
  late final String vehicleModel;
  late final FuelType fueltype;
  late final String photosUrl;
  late final VehicleType vehicletype;
  late final String yearOfManufacturing;
  late final String registrationNo;
  late final String lastServiceDate;
  late final String name;

  Vehicle.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    created = json['created']??'';
    createdBy = json['createdBy']??'';
    updated = json['updated']??'';
    updatedBy = json['updatedBy']??'';
    active = json['active']??true;
    userId = json['userId'];
    vehicleManufacturer = VehicleManufacturer.fromJson(json['vehicleManufacturer']);
    vehicleModel = json['vehicle_model']??'';
    fueltype = FuelType.fromJson(json['fueltype']);
    photosUrl = json['photos_url']??'';
    vehicletype = VehicleType.fromJson(json['vehicletype']);
    yearOfManufacturing = json['year_of_manufacturing']??'';
    registrationNo = json['registrationNo']??'';
    lastServiceDate = json['lastServiceDate']??'';
    name = json['name']??"";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created'] = created;
    _data['createdBy'] = createdBy;
    _data['updated'] = updated;
    _data['updatedBy'] = updatedBy;
    _data['active'] = active;
    _data['userId'] = userId;
    _data['vehicleManufacturer'] = vehicleManufacturer.toJson();
    _data['vehicle_model'] = vehicleModel;
    _data['fueltype'] = fueltype.toJson();
    _data['photos_url'] = photosUrl;
    _data['vehicletype'] = vehicletype.toJson();
    _data['year_of_manufacturing'] = yearOfManufacturing;
    _data['registrationNo'] = registrationNo;
    _data['lastServiceDate'] = lastServiceDate;
    _data['name'] = name;
    return _data;
  }
}

