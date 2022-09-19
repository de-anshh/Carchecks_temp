import 'package:carcheck/model/fuel_type_model.dart';
import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/model/subservices_model.dart';
import 'package:carcheck/model/vehicle_type_model.dart';

class GarageServiceModel {
  GarageServiceModel({
    required this.message,
    required this.data,
    required this.success,
  });
  late final String message;
  late final List<GarageService> data;
  late final bool success;

  GarageServiceModel.fromJson(Map<String, dynamic> json){
    message = json['message'];
    data = List.from(json['data']).map((e)=>GarageService.fromJson(e)).toList();
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

class GarageService {
  GarageService({
    required this.id,
    required this.created,
    required this.createdBy,
    required this.updated,
    required this.updatedBy,
    required this.active,
    required this.garageId,
    required this.subServiceId,
    required this.fuelTypeGs,
    required this.vechicletypeid,
    required this.cost,
    required this.discribtion,
    required this.shortDiscribtion,
    required this.photosUrl,
  });
  late final int id;
  late final String created;
  late final String createdBy;
  late final String updated;
  late final String updatedBy;
  late final bool active;
  late final int garageId;
  late final int subServiceId;
  late final FuelType fuelTypeGs;
  late final VehicleType vechicletypeid;
  late final int cost;
  late final String discribtion;
  late final String shortDiscribtion;
  late final String photosUrl;
  bool isServiceSelected=false;

  GarageService.fromJson(Map<String, dynamic> json){
    id = json['id']??0;
    created = json['created']??'';
    createdBy = json['createdBy']??'';
    updated = json['updated']??'';
    updatedBy = json['updatedBy']??'';
    active = json['active']??true;
    garageId = json['garageId'];
    subServiceId = json['subServiceId'];
    fuelTypeGs = FuelType.fromJson(json['fuelTypeGs']);
    vechicletypeid = VehicleType.fromJson(json['vechicletypeid']);
    cost = json['cost']??'';
    discribtion = json['discribtion']??'';
    shortDiscribtion = json['short_discribtion']??'';
    photosUrl = json['photos_url']??'';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created'] = created;
    _data['createdBy'] = createdBy;
    _data['updated'] = updated;
    _data['updatedBy'] = updatedBy;
    _data['active'] = active;
    _data['garrageGs'] = garageId;
    _data['subserviceGs'] = subServiceId;
    _data['fuelTypeGs'] = fuelTypeGs.toJson();
    _data['vechicletypeid'] = vechicletypeid.toJson();
    _data['cost'] = cost;
    _data['discribtion'] = discribtion;
    _data['short_discribtion'] = shortDiscribtion;
    _data['photos_url'] = photosUrl;
    return _data;
  }
}

