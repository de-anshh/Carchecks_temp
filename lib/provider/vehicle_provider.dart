import 'dart:convert';

import 'package:carcheck/model/fuel_model.dart';
import 'package:carcheck/model/fuel_type_model.dart';
import 'package:carcheck/model/services.dart';
import 'package:carcheck/model/user_table_model.dart';
import 'package:carcheck/model/user_vehicle_model.dart';
import 'package:carcheck/model/vehicle_manufacturer_model.dart';
import 'package:carcheck/model/vehicle_model.dart';
import 'package:carcheck/model/vehicle_type_model.dart';
import 'package:carcheck/response/vehicle/add_vehicle_response.dart';

import 'package:carcheck/util/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class VehicleProvider extends ChangeNotifier{
  List<Vehicle> allVehicleList = [];
  List<Vehicle> vehicleListByUserId = [];
  List<UserVehicle> allUserVehicleList = [];
  List<VehicleType> allVehicleTypeList = [];
  List<String> allVehicleNameList = [];
  List<VehicleManufacturer> allVehicleManufacturerList = [];
  List<String> allVehicleTypeNameList = [];
  List<String> allVehicleManufacturerNameList = [];
  Vehicle? vehicleObj;
  bool isLoading = false;

  String? image;
  Future setImage(img) async{
    this.image = img;
    this.notifyListeners();
  }

  getAllVehicle({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      allVehicleList.clear();
    }
    String myUrl = AppConstants.BASE_URL +"/Vehicle/Vehicle/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = VehicleModel.fromJson(response);
      allVehicleNameList.clear();
      allVehicleList.clear();
      allVehicleList.addAll(type.data);
      allVehicleList.forEach((element) {
        allVehicleNameList.add(element.name);
      });
      notifyListeners();
    }
  }

  getAllVehicleType({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      allVehicleTypeList.clear();
    }
    String myUrl = AppConstants.BASE_URL +"/VehicleType/VehicleType/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = VehicleTypeModel.fromJson(response);
      allVehicleTypeList.clear();
      allVehicleTypeNameList.clear();
      allVehicleTypeList.addAll(type.data);
      allVehicleTypeList.forEach((element) {
        allVehicleTypeNameList.add(element.name);
      });
      notifyListeners();
    }
  }

  getAllVehicleManufacture({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      allVehicleManufacturerList.clear();
    }
    String myUrl = AppConstants.BASE_URL +"/VehicleManufacturer/GarageServices/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = VehicleManufacturerModel.fromJson(response);
      allVehicleManufacturerList.clear();
      allVehicleManufacturerNameList.clear();
      allVehicleManufacturerList.addAll(type.data);
      allVehicleManufacturerList.forEach((element) {
        allVehicleManufacturerNameList.add(element.name);
      });
      notifyListeners();
    }
  }

  getAllVehicleListByUserId({int currentPage = 0,int? id}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      vehicleListByUserId.clear();
    }
    String myUrl = AppConstants.BASE_URL +"/Vehicle/user/getbyuserid?id=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = VehicleModel.fromJson(response);
      vehicleListByUserId.addAll(type.data);
      notifyListeners();
    }
  }

  int? selectedVehicleTypeId;
  VehicleType? vehicleType;
  getSelectedVehicleTypeId(String vehicleName){
    allVehicleTypeList.forEach((element) {
      if(element.name == vehicleName){
        selectedVehicleTypeId = element.id;
        vehicleType = element;
      }
    });
    return vehicleType;
  }

  int? selectedVehicleId;
  Vehicle? vehicle;
  getSelectedVehicleId(String vehicleName){
    allVehicleList.forEach((element) {
      if(element.name == vehicleName){
        selectedVehicleId = element.id;
        vehicle = element;
      }
    });
    return vehicle;
  }

  int? selectedVehicleManufacturerId;
  VehicleManufacturer? vehicleManufacturer;
  getSelectedVehicleManufacturerId(String vehicleManufacturerName){
    allVehicleManufacturerList.forEach((element) {
      if(element.name == vehicleManufacturerName){
        selectedVehicleManufacturerId = element.id;
        vehicleManufacturer = element;
      }
    });
    return vehicleManufacturer;
  }

  addVehicle({bool? active, String? created, String? created_by, String? last_servecing_date, String? name, String? vehicle_model,
    String? year,String? image_url, String? regNumber, int? userId, FuelType? fuelType, VehicleType? vehicleType, VehicleManufacturer? vehicleManufacturer,
    String? updated, String? updated_by,String? avgRun, String? kiloMeterRun,String? no_Of_servecing
    }) async {
    String myUrl = AppConstants.ADD_VEHICLE;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "active": active,
      "created": created,
      "createdBy": created_by,
      "fueltype": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": fuelType!.id,
        "name": "string"
      },
      "lastServiceDate": last_servecing_date,
      "name": name,
      "photos_url": image_url,
      "registrationNo": regNumber,
      "updated": updated,
      "updatedBy": updated_by,
      "userId": userId,
      "vehicleManufacturer": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": vehicleManufacturer!.id,
        "name": "string",
        "updated": "string",
        "updatedBy": "string"
      },
      "vehicle_model": vehicle_model,
      "vehicletype": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": vehicleType!.id,
        "name": "string"
      },
      "year_of_manufacturing": year
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " +
        createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    var list = AddVehicleResponse.fromJson(response);
     allVehicleList.add(list.data);
     vehicleObj = null;
     vehicleObj = list.data;
    notifyListeners();
    return vehicleObj;
  }

  updateVehicle(
      {bool? active, String? created, String? created_by, String? last_servecing_date, String? name, String? vehicle_model,
        String? year,String? image_url, String? regNumber, int? userId, FuelType? fuelType, VehicleType? vehicleType, VehicleManufacturer? vehicleManufacturer,
        String? updated, String? updated_by,String? avgRun, String? kiloMeterRun,String? no_Of_servecing

      }) async {
    String myUrl = AppConstants.BASE_URL = "";
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "active": active,
      "created": created,
      "createdBy": created_by,
      "fueltype": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": fuelType!.id,
        "name": "string"
      },
      "lastServiceDate": last_servecing_date,
      "name": name,
      "photos_url": image_url,
      "registrationNo": regNumber,
      "updated": updated,
      "updatedBy": updated_by,
      "userId": userId,
      "vehicleManufacturer": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": vehicleManufacturer!.id,
        "name": "string",
        "updated": "string",
        "updatedBy": "string"
      },
      "vehicle_model": vehicle_model,
      "vehicletype": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": vehicleType!.id,
        "name": "string"
      },
      "year_of_manufacturing": year
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.put(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " +
        createResponse.body.toString());
    print(createResponse.body);
    var response = await json.decode(createResponse.body);
    var res = AddVehicleResponse.fromJson(response);
    vehicleObj = res.data;
    notifyListeners();
  }


  addUserVehicle({bool? active, String? created, String? created_by, String? last_servecing_date, String? name, String? vehicle_model,
    String? year,String? image_url, String? regNumber, int? userId, FuelType? fuelType, VehicleType? vehicleType, VehicleManufacturer? vehicleManufacturer,
    String? updated, String? updated_by,String? avgRun, String? kiloMeterRun,String? no_Of_servecing,Vehicle? vehicle
  }) async {
    String myUrl = AppConstants.ADD_VEHICLE;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "active": active,
      "created": created,
      "createdBy": created_by,
      "fueltype": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": fuelType!.id,
        "name": "string"
      },
      "lastServiceDate": last_servecing_date,
      "name": name,
      "photos_url": image_url,
      "registrationNo": regNumber,
      "updated": updated,
      "updatedBy": updated_by,
      "userId": userId,
      "vehicleManufacturer": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": vehicleManufacturer!.id,
        "name": "string",
        "updated": "string",
        "updatedBy": "string"
      },
      "vehicle_model": vehicle_model,
      "vehicletype": {
        "active": true,
        "created": "string",
        "createdBy": "string",
        "id": vehicleType!.id,
        "name": "string"
      },
      "year_of_manufacturing": year
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " +
        createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    var list = UserVehicleModel.fromJson(response);
    allUserVehicleList = list.data;
    notifyListeners();
  }

}