import 'dart:convert';

import 'package:carcheck/model/address_model.dart';
import 'package:carcheck/model/bid_model.dart';
import 'package:carcheck/model/fuel_model.dart';
import 'package:carcheck/model/fuel_type_model.dart';
import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/model/garage_services_model.dart';
import 'package:carcheck/model/services.dart';
import 'package:carcheck/model/subservices_model.dart';
import 'package:carcheck/model/vehicle_type_model.dart';
import 'package:carcheck/util/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GarageProvider extends ChangeNotifier {
  List<Garage> allGarageList = [];
  List<Garage> ownGarageList = [];
  List<Garage> isPopularGarageList = [];
  List<Garage> isNotPopularGarageList = [];
  Garage? garage;
  List<GarageService> allGarageServiceList = [];
  List<GarageService> allGarageServiceListByGarageId = [];
  bool isLoading = false;

  getAllGarage({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if (currentPage == 0) {
      allGarageList.clear();
    }
    String myUrl =
        AppConstants.BASE_URL + "/api/garrage/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if (req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = GarageModel.fromJson(response);
      allGarageList.addAll(type.data);
      allGarageList.forEach((element) {
        if(element.populer == true){
          isPopularGarageList.add(element);
        }
        else{
          isNotPopularGarageList.add(element);
        }
      });
      notifyListeners();
    }
  }

  getGarageByUserId(int userId) async {
    isLoading = true;
    notifyListeners();

    String myUrl =
        AppConstants.BASE_URL + "/api/Garrages/getByuserId?id=${userId}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if (req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = GarageModel.fromJson(response);
      ownGarageList.clear();
      ownGarageList.addAll(type.data);
      notifyListeners();
    }
  }


  getAllGarageServices({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if (currentPage == 0) {
      allGarageServiceList.clear();
    }
    String myUrl = AppConstants.BASE_URL +
        "/garrage_services/GarageServices/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if (req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = GarageServiceModel.fromJson(response);
      allGarageServiceList.addAll(type.data);
      notifyListeners();
    }
  }

  getAllGarageServicesByGarageId({int currentPage = 0,int? garageId }) async {
    isLoading = true;
    notifyListeners();
    if (currentPage == 0) {
      allGarageServiceListByGarageId.clear();
    }
    String myUrl = AppConstants.BASE_URL +
        "/garrage_services/GarageServices/getbygarageid?id=${garageId}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if (req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = GarageServiceModel.fromJson(response);
      allGarageServiceListByGarageId.addAll(type.data);
      notifyListeners();
    }
  }

  addGarage({bool? isActive,
    String? created,
    String? created_by,
    String? closingTime,
    String? openingTime,
    String? lat,
    String? long,
    String? image_url,
    String? photo,
    String? emailId,
    int? mobile,
    int? addressId,
    int? userId,
    bool? isPopular,
    String? updated,
    String? updated_by,
    String? name,
    String? password,
    String? website,
    String? verificationId,
    bool? isVerified,
    int? rating,
    String? description,
    int? noOfratings,
    }) async {
    String myUrl = AppConstants.SAVE_GARAGE;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "active": true,
      "addressId": addressId,
      "closingTime": closingTime,
      "contactNumber": mobile,
      "created": created,
      "createdBy": created_by,
      "discription": description,
      "emailId": emailId,
      "imageUrl": image_url,
      "latitude": lat,
      "location": 0,
      "longitude": long,
      "name": name,
      "noOfRating": noOfratings,
      "openingTime": openingTime,
      "password": password,
      "photos": photo,
      "populer": isPopular,
      "rating": rating,
      "updated": updated,
      "updatedBy": updated_by,
      "userId": userId,
      "verificatiionId": verificationId,
      "verified": isVerified,
      "websiteUrl": website,

      };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    var list = GarageModel.fromJson(response);
    allGarageList.addAll(list.data);
    notifyListeners();
  }

  addGarageService(
      {bool? active,
      String? created,
      String? created_by,
      String? cost,
      String? image_url,
      String? description,
      int? subServiceId,
        int? garageId,
      String? updated,
      String? updated_by,
      String? short_desc,
      VehicleType? vehicletype}) async {
    String myUrl = AppConstants.BASE_URL + "/garrage_services/GarageServices/save";
    Uri uri = Uri.parse(myUrl);

    Map<String, dynamic> data = {
        "active": active,
        "cost": cost,
        "created": created,
        "createdBy": created_by,
        "discribtion": description,
        "fuelTypeGs": {
          "active": true,
          "created": "string",
          "createdBy": "string",
          "id": 1,
          "name": "string"
        },
        "garageId": garageId,
        "photos_url": image_url??'',
        "short_discribtion": description,
        "subServiceId": subServiceId,
        "updated": updated,
        "updatedBy": updated_by,
        "vechicletypeid": {
          "active": true,
          "created": "string",
          "createdBy": "string",
          "id": 1,
          "name": "string"
        }

    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    var list = GarageServiceModel.fromJson(response);
    allGarageServiceList.addAll(list.data);
    notifyListeners();
  }

  deleteGarageService(GarageService gs) async {
    String myUrl = AppConstants.BASE_URL +
        '/garrage_services/GarageServices/deleteById?id=${gs.id}';
    var req = await http.delete(Uri.parse(myUrl));
    var deleteResponse = json.decode(req.body);
    allGarageServiceList.remove(gs);
    notifyListeners();
  }
}
