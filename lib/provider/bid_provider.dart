import 'dart:convert';
import 'package:carcheck/model/bid_model.dart';
import 'package:carcheck/model/user_order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:carcheck/util/app_constants.dart';
import '../model/subservices_model.dart';


class BidProvider extends ChangeNotifier{
  List<Bid> allBidList = [];
  bool isLoading = false;

  get userOrder => userOrder;

  get subServices => subServices;

  getAllFuelType({int currentPage = 0}) async {
    isLoading = true;
    notifyListeners();
    if(currentPage == 0){
      allBidList.clear();
    }
    String myUrl = "http://carchek-loadbalancer-425503991.us-east-1.elb.amazonaws.com:8080/carcheck/api/fuelType/getAll";
    print(myUrl);
    var req = await http.get(Uri.parse(myUrl));
    isLoading = false;
    if(req.statusCode == 200) {
      var response = json.decode(req.body);
     // var type = GetAllBid.fromJson(response);
     // allBidList.addAll(type.data);
      notifyListeners();
    }
  }

  SaveBid({
   String? created,
   String? createdBy,
   String? updated,
   String? updatedBy,
   bool? active,
   UserOrder? userOrder,
   SubService? subService} ) async {
    String myUrl= AppConstants.BASE_URL + "/api/bidding/save";
    Uri uri = Uri.parse(myUrl);
    print(myUrl);
    Map<String,dynamic> data={
      "created": created,
      "createdBy":createdBy,
      "updated": updated,
      "updatedBy": updatedBy,
      "active":active,
      "UserOrder":UserOrder,
      "Subservice": SubService
    };
    var body= json.encode(data);
    print(data);
    var createResponse = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    print("${createResponse.statusCode}" +
        " --- " +
        createResponse.body.toString());
    var response = await json.decode(createResponse.body);
    allBidList.add(response.data);
    notifyListeners();
  }
}