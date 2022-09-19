import 'dart:convert';
import 'package:carcheck/model/address_model.dart';
import 'package:carcheck/model/user_order_model.dart';
import 'package:carcheck/model/user_table_model.dart';
import 'package:carcheck/response/auth/loginResponse.dart';
import 'package:carcheck/util/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName{
    final nameRegExp = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword{
    final passwordRegExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this!=null;
  }

  bool get isValidPhone{
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}

class  AuthProvider extends ChangeNotifier {
  User? userDetails;
  var response;
  bool isLoading = false;
  String dropdownValue = 'English';

  loginUsingMobileNumber(String mobileNumber, String password) async {
    String myUrl = AppConstants.LOGIN + 'mobileNumber?mobilenumber=${mobileNumber}&password=${password}';
    print(myUrl);
    var req = await http.post(Uri.parse(myUrl));
    response = json.decode(req.body);
    var res = LoginResponseResponse.fromJson(response);
    userDetails = null;
    userDetails = res.data;
    notifyListeners();
    return response;
  }

  getUserDetails(int id) async {
    String myUrl = AppConstants.BASE_URL + '/UserTable/UserTable/getById?id=${id}';
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    response = await json.decode(req.body);
    var res = LoginResponseResponse.fromJson(response);
    userDetails = null;
    userDetails = res.data;
    notifyListeners();
    return userDetails;
  }

  setVisitingFlag(bool flag) async {
    if (flag == false) {
      userDetails = null;
      notifyListeners();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("Already Visited", flag);
    notifyListeners();
  }

  setUserId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("id", id);
  }

  setUserName(String uName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("userName", uName);
  }

  Future<bool?> getVisitingFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? alreadyVisited = await preferences.getBool("Already Visited") ??
        false;
    return alreadyVisited;
  }

  Future<int?> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? id = await preferences.getInt("id")!;
    return id;
  }


  late String image = '';

  Future setImage(img) async {
    this.image = img;
    this.notifyListeners();
  }

  /* postProfilePicture(String userId,{String? imageFilePath,
    Uint8List? imageBytes,PlatformFile? objectFile}) async {

    String myUrl = "https://api.tkdost.com/tkd2/api/profilePicture";

    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("POST", postUri);

    Map<String,String> headers = {"Content-Type": "multipart/form-data"};

    request.files.add(new http.MultipartFile(
        "profilePicture", objectFile!.readStream!, objectFile.size,
        filename: objectFile.name));

    request.fields['userId'] = userId;

    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      notifyListeners();
    });
  }

  updateProfilePicture(String userId,{String? imageFilePath,
    Uint8List? imageBytes,PlatformFile? objectFile,}) async {

    String myUrl = "https://api.tkdost.com/tkd2/api/profilePicture";

    var postUri = Uri.parse(myUrl);
    var request = new http.MultipartRequest("PUT", postUri);

    Map<String,String> headers = {"Content-Type": "multipart/form-data"};

    request.files.add(new http.MultipartFile(
        "profilePicture", objectFile!.readStream!, objectFile.size,
        filename: objectFile.name));

    request.fields['userId'] = userId;
    print(request);

    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      var response = await json.decode(value);
      var list = AuthApi.fromJson(response);
      userDetailList.clear();
      userDetailList = list.content!;
      print(userDetailList[0].profilePicture);
      notifyListeners();
    });
  }*/

  saveUser({bool? active, String? created, String? created_by, String? device_id, String? emailid, String? first_name,
        String? last_name, bool? garrage_Owner, String? image_url, String? mobilenumber, String? operating_system, int? id, bool? payment_mode, bool? verified,
        String? updated, String? updated_by,String? password,}) async {
    String myUrl = AppConstants.REGISTRATION;
    print(myUrl);
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
      "active": active,
      "created": created,
      "createdBy": created_by,
      "device_id": device_id,
      "emailid": emailid,
      "firstName": first_name,
      "garrage_Owner": garrage_Owner,
      "image_url": image_url,
      "lastName": last_name,
      "mobilenumber": mobilenumber,
      "operating_system": operating_system,
      "otp": "00000",
      "password": password,
      "payment_mode": payment_mode,
      "updated": updated,
      "updatedBy": updated_by,
      "verified": verified
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " +
        createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    var res = LoginResponseResponse.fromJson(response);
    userDetails = res.data;
    notifyListeners();
    return userDetails!.id;
  }

 updateUser(
      {bool? active, String? created, String? created_by, String? device_id, String? emailid, String? first_name,
        String? last_name, bool? garrage_Owner, String? image_url, String? mobilenumber, String? operating_system, int? id, bool? payment_mode, bool? verified,
        String? updated, String? updated_by,
      }) async {
    String myUrl = AppConstants.UPDATE_USER_PROFILE;
    Uri uri = Uri.parse(myUrl);
    Map<String, dynamic> data = {
        "active": active ?? userDetails!.active ,
        "created": created ?? userDetails!.created,
        "createdBy": created_by ?? userDetails!.createdBy,
        "device_id": device_id ?? userDetails!.deviceId,
        "emailid": emailid ?? userDetails!.emailid,
        "firstName": first_name?? userDetails!.firstName,
        "garrage_Owner": garrage_Owner ?? userDetails!.garrageOwner,
        "id": userDetails!.id ,
        "image_url": image_url ?? userDetails!.imageUrl,
        "lastName": last_name?? userDetails!.lastName,
        "mobilenumber": mobilenumber ?? userDetails!.mobilenumber,
        "operating_system": operating_system ?? userDetails!.operatingSystem ,
        "payment_mode": payment_mode ?? userDetails!.paymentMode,
        "password": userDetails!.password,
        "updated": updated ?? userDetails!.updatedBy,
        "updatedBy": updated_by ?? userDetails!.updatedBy ,
        "verified": verified ?? userDetails!.verified
    };
    var body = json.encode(data);
    print(data);
    var createResponse = await http.put(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" + " --- " +
        createResponse.body.toString());
    print(createResponse.body);
    var response = await json.decode(createResponse.body);
    var res = LoginResponseResponse.fromJson(response);
    userDetails=null;
    userDetails = res.data;
    notifyListeners();
  }

  deleteUser(User user) async {
    String myUrl = AppConstants.DELETE_USER + 'deleteById?id=${user.id}';
    var req = await http.delete(Uri.parse(myUrl));
    response = json.decode(req.body);
    notifyListeners();
  }
}