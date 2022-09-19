import 'dart:convert';
import 'package:carcheck/model/Appointment.dart';
import 'package:carcheck/model/services.dart';
import 'package:carcheck/model/subservices_model.dart';
import 'package:carcheck/response/add_appointment_response.dart';
import 'package:carcheck/util/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class AppointmentProvider extends ChangeNotifier {
  List<Appointment> allAppointment = [];
  List<Appointment> appointmentByGarageId = [];
  List<Appointment> AppointmentBySubServiceID = [];
  List<Appointment> AppointmentByUserId=[];
  List<Service> allServices = [];
  List<SubService> allSubServices = [];
  List<String> subServicesNameList = [];
  bool isLoading = false;

  getAllAppointment({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if (currentPage == 0) {
      allAppointment.clear();
    }
    String myUrl = AppConstants.BASE_URL + "/api/Appointment/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if (req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = AddAppointmentResponse.fromJson(response);
      allAppointment.add(type.data);
      print(allAppointment[0]);
      notifyListeners();
    }
  }

  getAppointmentByGarageId(int? garageId) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/api/Appointment/getByGarrageId";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    if (req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = AddAppointmentResponse.fromJson(response);
      appointmentByGarageId.add(type.data);
      print(appointmentByGarageId[0]);
      notifyListeners();
    }
  }


  getAppointmentByUsertableID(int? UserID) async{
    isLoading: true;
    notifyListeners();
    String myUrl= AppConstants.BASE_URL+ "/api/Appointment/getByUserTableId";
    print(myUrl);
    var req= await http.get(Uri.parse(myUrl));
    if(req.statusCode==200){
      var response = json.decode(req.body);
      var type= AddAppointmentResponse.fromJson(response);
      AppointmentByUserId.clear();
      AppointmentByUserId.add(type.data);
      print(AppointmentByUserId[0]);
      notifyListeners();
    }
  }
  getAppointmentBySubServiceID(int? SubService) async {
    isLoading = true;
    notifyListeners();
    String myUrl = AppConstants.BASE_URL + "/api/Appointment/getBySubserviceId";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    if (req.statusCode == 200) {
      var response = json.decode(req.body);
      var type = AddAppointmentResponse.fromJson(response);
      AppointmentBySubServiceID.add(type.data);
      print(AppointmentBySubServiceID[0]);
      notifyListeners();
    }
  }

  SaveAppointment(
      {bool? accept,
        bool? active,
        String? availableTime,
        String? date,
        int? garrageId,
        int? id,
        String? status,
        int? SubServiceId,
        String? time,
        int? userId}) async {
    String myUrl = AppConstants.BASE_URL + "/api/Appointment/save";
    Uri uri = Uri.parse(myUrl);
    print(myUrl);
    Map<String, dynamic> data = {
      "accept": accept,
      "active": active,
      "availableTime": availableTime,
      "date": date,
      "garrageId": garrageId,
      "status": status,
      "subServiceId": SubServiceId,
      "time": time,
      "userId": userId
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    var list = AddAppointmentResponse.fromJson(response);
    allAppointment.add(list.data);
    notifyListeners();
  }
}