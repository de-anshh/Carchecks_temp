import 'dart:convert';
import 'package:carcheck/model/address_model.dart';
import 'package:carcheck/model/garage_services_model.dart';
import 'package:carcheck/model/offer_model.dart';
import 'package:carcheck/model/services.dart';
import 'package:carcheck/model/subservices_model.dart';
import 'package:carcheck/response/add_address_response.dart';
import 'package:carcheck/util/app_constants.dart';import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../view/screens/customer/customer_dashboard.dart';

class ServiceProvider extends ChangeNotifier{
  List<Service> allServices = [];
  List<Service> serviceListByGarageId = [];
  List<SubService> subServiceListByServiceId = [];

  List<GarageService> allGarageServices = [];
  List<GarageService> garageServiceListByGarageId = [];
  List<SubService> subServiceListByGarageServiceId = [];

  List<String> subServicesNameList = [];
  List<Offer> offerList = [];
  bool isLoading = false;
  int count = 0;
  int totalAmt = 0;

  AddressClass? addressClass;
  getAddressByAddressId(int id) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/api/address/getById?id=${id}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      addressClass = null;
      var response = json.decode(req.body);
      var type = SaveAddressResponse.fromJson(response);
      addressClass = type.data;
      notifyListeners();
    }
  }

  getAllOffer() async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/api/offer/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = OfferModel.fromJson(response);
      offerList.clear();
      offerList.addAll(type.data);
      print(offerList[0]);
      notifyListeners();
    }
  }

  getAllGarageServices({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      allGarageServices.clear();
    }
    String myUrl = AppConstants.BASE_URL + "/garrage_services/GarageServices/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = GarageServiceModel.fromJson(response);
      allGarageServices.clear();
      allGarageServices.addAll(type.data);
      print(allGarageServices[0]);
      notifyListeners();
    }
  }

  getServicesByGarageId(int garageId) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/Services/service/getbygarages?garrage_id=${garageId}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = ServiceModel.fromJson(response);
      serviceListByGarageId.clear();
      serviceListByGarageId.addAll(type.data);
      print(serviceListByGarageId[0]);
      notifyListeners();
    }
  }

  getGarageServicesByGarageId(int garageId) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/garrage_services/GarageServices/getbygarageid?id=${garageId}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = GarageServiceModel.fromJson(response);
      garageServiceListByGarageId.clear();
      garageServiceListByGarageId.addAll(type.data);
      print(garageServiceListByGarageId[0]);
      notifyListeners();
    }
  }

  getAllServices({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      allServices.clear();
    }
    String myUrl = AppConstants.BASE_URL +"/Services/Services/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = ServiceModel.fromJson(response);
      allServices.clear();
      allServices.addAll(type.data);
      print(allServices[0]);
      notifyListeners();
    }
  }

  getSubServicesByServiceId({int currentPage = 0,int? serviceId}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      subServiceListByServiceId.clear();
    }
    String myUrl = AppConstants.BASE_URL +"/Subservice/Subservice/getbyparentService?id=${serviceId}";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = SubServiceModel.fromJson(response);
      subServiceListByServiceId.clear();
      subServiceListByServiceId.addAll(type.data);
      subServiceListByServiceId.forEach((element) {
        subServicesNameList.add(element.name);
      });
      print(subServiceListByServiceId[0]);
      notifyListeners();
    }
  }

  int? selectedSubServiceId;
  SubService? subService;
  getSelectedGarageServiceId(String serviceName){
    subServiceListByServiceId.forEach((element) {
      if(element.name == serviceName){
        selectedSubServiceId = element.id;
        subService = element;
      }
    });
    return subService;
  }

  getSelectedServiceCount(){
    allServices.forEach((element) {
      if(element.isServiceSelected == true){
        count++;
      }
    });
    return count;
  }

  setSelectedService(Service service){
    service.isServiceSelected = !service.isServiceSelected;
  }
}