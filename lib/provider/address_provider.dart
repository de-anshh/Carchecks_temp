import 'dart:convert';
import 'package:carcheck/model/address_model.dart';
import 'package:carcheck/model/city_model.dart';
import 'package:carcheck/response/add_address_response.dart';
import 'package:carcheck/response/auth/loginResponse.dart';
import 'package:carcheck/response/get_city_reasponse.dart';
import 'package:carcheck/util/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddressProvider extends ChangeNotifier{
  AddressClass? addressObj;
  bool isLoading = false;
  List<City> cityList = [];
  List<String> cityNameList=[];
  List<String> countryNameList=[];
  List<String> stateNameList=[];

  getAllCity() async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/api/city/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = CityModel.fromJson(response);
      cityList.addAll(type.data);
      cityList.forEach((element) {
        cityNameList.add(element.city);
        countryNameList.add(element.country);
        stateNameList.add(element.state);
      });
      notifyListeners();
    }
  }

  int? selectedCityId;
  getSelectedCityId(String cityName){
    cityList.forEach((element) {
      if(element.city == cityName){
        selectedCityId = element.id;
      }
    });
    return selectedCityId;
  }

  getAddressById(int id) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/api/address/getById?id=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      addressObj = null;
      var response = json.decode(req.body);
      var type = SaveAddressResponse.fromJson(response);
      addressObj = type.data;
     // getCityByCityId(addressObj!.cityId);
      notifyListeners();
      return addressObj;
    }
  }

  getAddressByUserId(int id) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/api/address/getByUserId?id=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      addressObj = null;
      var response = json.decode(req.body);
      var type = SaveAddressResponse.fromJson(response);
      addressObj = type.data;
      notifyListeners();
    }
  }

  City? city;
  getCityByCityId(int cityId) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/api/city/getById?id=${cityId}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      city = null;
      var response = json.decode(req.body);
      var type = GetCityReasponse.fromJson(response);
      city = type.data;
      notifyListeners();
    }
  }

  saveAddress({bool? active, String? created, String? created_by, String? landmark, String? name, String? street,
    String? zipcode, bool? garrageAddress, int? user_id, int? city_id, String? updated, String? updated_by
    }) async {
    String myUrl = AppConstants.BASE_URL + "/api/address/save";
    print(myUrl);
    Uri uri = Uri.parse(myUrl);

    Map<String, dynamic> data = {
        "active": active,
        "cityId": city_id,
        "created": created,
        "createdBy": created_by,
        "garrageAddress": garrageAddress,
        "landmark": landmark,
        "name": name,
        "street": street,
        "updated": updated,
        "updatedBy": updated_by,
        "userId": user_id,
        "zipCode": zipcode
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " +
        createResponse.body.toString());
    if(createResponse.statusCode == 200) {
      addressObj = null;
      var response = json.decode(createResponse.body);
      var type = SaveAddressResponse.fromJson(response);
      addressObj = type.data;

      notifyListeners();
    }
  }


  updateAddress({bool? active, String? created, String? created_by, String? landmark, String? name, String? street,
    String? zipcode, bool? garrageAddress, int? user_id, int? city_id, String? updated, String? updated_by
  }) async {
    String myUrl = AppConstants.BASE_URL + "/api/address/update";
    print(myUrl);
    Uri uri = Uri.parse(myUrl);

    Map<String, dynamic> data = {
      /*"active": active?? addressObj!.active,
      "cityId": city_id?? addressObj!.cityId,
      "id":2,
      "created": created?? addressObj!.created,
      "createdBy": created_by?? addressObj!.createdBy,
      "garrageAddress": garrageAddress?? addressObj!.garrageAddress,
      "landmark": landmark?? addressObj!.landmark,
      "name": name?? addressObj!.name,
      "street": street?? addressObj!.street,
      "updated": updated?? addressObj!.updated,
      "updatedBy": updated_by?? addressObj!.updatedBy,
      "userId": user_id?? addressObj!.userId,
      "zipCode": zipcode?? addressObj!.zipCode*/
      "active": active,
      "cityId": city_id,
      "id":4,
      "created": created,
      "createdBy": created_by,
      "garrageAddress": garrageAddress,
      "landmark": landmark,
      "name": name,
      "street": street,
      "updated": updated,
      "updatedBy": updated_by,
      "userId": user_id,
      "zipCode": zipcode
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.put(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " +
        createResponse.body.toString());
    if(createResponse.statusCode == 200) {
      addressObj = null;
      var response = json.decode(createResponse.body);
      var type = SaveAddressResponse.fromJson(response);
      addressObj = type.data;
      notifyListeners();
    }
  }



}