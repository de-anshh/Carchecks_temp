import 'package:carcheck/locator.dart';
import 'package:carcheck/provider/garage_provider.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/provider/vehicle_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/base_widgets/custom_navigation_drawer_widget.dart';
import 'package:carcheck/view/screens/customer/garage/garage_card.dart';
import 'package:carcheck/view/screens/customer/garage/near_by_store.dart';
import 'package:carcheck/view/screens/customer/offers/offers_card.dart';
import 'package:carcheck/view/screens/customer/offers/special_offers.dart';
import 'package:carcheck/view/screens/customer/service/get_all_services.dart';
import 'package:carcheck/view/screens/customer/service/service_card.dart';
import 'package:carcheck/view/screens/customer/wheels_tyres_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:carcheck/provider/auth_provider.dart';

import '../../../provider/address_provider.dart';

class ServiceSearch extends StatefulWidget {
  @override
  _ServiceSearchState createState() => _ServiceSearchState();
}

class _ServiceSearchState extends State<ServiceSearch> {


  ServiceProvider serviceProvider = locator<ServiceProvider>();
  GarageProvider garageProvider = locator<GarageProvider>();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String selectedVehicle = 'Car';
  AddressProvider addressProvider = locator<AddressProvider>();
  AuthProvider authProvider = locator<AuthProvider>();
  VehicleProvider vehicleProvider = locator<VehicleProvider>();
  getData() async {
    await addressProvider.getAddressById(authProvider.userDetails!.id).then((value) async => {await addressProvider.getCityByCityId(value.cityId)});
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  List<String> vehicleList = <String>['Chevrolet', 'Tata Nexon','Alto','Santro','Eeco','Renault Kwid','Hyundai'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getCurrentLocation();
    serviceProvider.getAllServices();
    serviceProvider.getSubServicesByServiceId();
    vehicleProvider.getAllVehicle();
    serviceProvider.getAllGarageServices();
    serviceProvider.getAllOffer();
    garageProvider.getAllGarage();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
     /* appBar: AppBar(
        backgroundColor: ColorResources.PRIMARY_COLOR,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: ColorResources.BUTTON_COLOR,
          ),
          //SvgPicture.asset("assets/svg/hamburger.svg"),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),*/
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                    clipper: ProsteBezierCurve(
                      position: ClipPosition.bottom,
                      list: [
                        BezierCurveSection(
                          start: Offset(0, 400),
                          top: Offset(screenWidth / 2, 440),
                          end: Offset(screenWidth, 400),
                        ),
                      ],
                    ),
                    child: Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: 480,
                        color: ColorResources.PRIMARY_COLOR,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50,),
                            GestureDetector(
                              onTap: (){
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: ColorResources.BUTTON_COLOR,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Text("Service Search",style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white
                              ),),
                            ),
                            SizedBox(height: 10,),
                            Text("Please choose your car and select location and date of visit",style: TextStyle(
                                fontWeight: FontWeight.normal,fontSize: 15,color: Colors.grey
                            ),),
                            SizedBox(height: 10,),
                            Card(
                                elevation: 5,
                                color: Colors.white38,
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: FormBuilderDropdown(
                                      name: "Select your car",
                                      allowClear: true,
                                      isDense: false ,
                                      icon: Icon(Icons.directions_car,color: Colors.white,),
                                      decoration: InputDecoration.collapsed(
                                        hintText: '',
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border:OutlineInputBorder(
                                            borderRadius: new BorderRadius.circular(20.0),
                                            borderSide: BorderSide.none
                                        ),
                                      ),
                                      hint: Container(
                                        height: 60,
                                        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                                        child: Text(
                                          "Select your car",
                                           style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      validator: FormBuilderValidators.compose(
                                          [FormBuilderValidators.required(context)]),
                                      items: vehicleList
                                          .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Container(
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                                          child: Text(
                                            '$value',
                                            //  style: TextStyle(color: Colors.white)
                                          ),
                                        ),
                                      )
                                      )
                                          .toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedVehicle = value!;
                                        });
                                      }),
                                )),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width-150,
                                  child:  Card(
                                      elevation: 5,
                                      color: Colors.white38,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: TextFormField(
                                            controller: addressController,
                                            style: TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              hintText: "Search around you?",
                                              hintStyle: TextStyle(color: Colors.white),
                                              suffixIcon: Icon(Icons.location_on,color: Colors.white,),
                                              border: InputBorder.none,
                                            ),
                                            keyboardType: TextInputType.text,
                                            onTap: (){
                                              setState(() {
                                                getCurrentLocation();
                                              });
                                            },
                                          )
                                      )),
                                ),
                                Expanded(
                                  child: Card(
                                      elevation: 5,
                                      color: Colors.white38,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: TextFormField(
                                          controller: dateController,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            hintText: "Date",
                                            hintStyle: TextStyle(color: Colors.white),
                                            suffixIcon: Icon(Icons.date_range,color: Colors.white,),
                                            border: InputBorder.none,
                                          ),
                                          keyboardType: TextInputType.text,
                                          onTap: (){
                                            setState(() {
                                              _selectDate(context);
                                            });
                                          },
                                        )
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 400,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: CustomButton(
                      buttonText: "Search",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => GetAllServices()));
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Services",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>GetAllServices()));
                      },
                      child: Text("View All",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,decoration: TextDecoration.underline,color: ColorResources.PRIMARY_COLOR),)),
                ],
              ),
            ),
            SizedBox(height: 15,),
            getServices(),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Near By Stores",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>NearByStore()));
                      },
                      child: Text("View All",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,decoration: TextDecoration.underline,color: ColorResources.PRIMARY_COLOR),)),
                ],
              ),
            ),
            SizedBox(height: 15,),
            getNearByStore(),
           /* SizedBox(height: 15,),
            CustomButton(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=> NearByStore()));
            }, buttonText: "Continue To Select Garage Near By You")*/
            /*SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Special Offers",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (builder)=>SpecialOffers()));
                          },
                          child: Text("View All",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,decoration: TextDecoration.underline,color: ColorResources.PRIMARY_COLOR),)),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                getSpecialOffers(),
              ],
            ),
            )*/
          ],
        ),
      ),
    );
  }

  /*getSpecialOffers() {
    return Consumer<ServiceProvider>(
      builder: (context, model, child) => Container(
        height: 200,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.alGaragelServices.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: 170,
                  margin: EdgeInsets.all(5),
                  child: OffersCard(model.alGaragelServices[index]));
            }
        ),
      ),
    );
  }*/

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    addressController.text = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }

  getCurrentLocation() async {
    Position position = await _getGeoLocationPosition();
    GetAddressFromLatLong(position);
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String date = DateFormat("M/d").format(selectedDate);
        dateController.text = date;
      });
    }
  }

  getServices() {
    return Consumer<ServiceProvider>(
      builder: (context, model, child) => Container(
        height: 125,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.allServices.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 110,
                  width: 150,
                  margin: EdgeInsets.fromLTRB(1,5,1,5),
                  child: ServiceCard(model.allServices[index]));
            }
        ),
      ),
    );
  }

  getNearByStore() {
    return Consumer<GarageProvider>(
      builder: (context, model, child) => Container(
        height: 170,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.allGarageList.length,
            itemBuilder: (BuildContext context, int index) {
              return Expanded(

                child: Container(
                    height: 160,
                    width: 150,
                    margin: EdgeInsets.all(5),
                    child: CardStore(model.allGarageList[index])),

              );
              /*return InkWell(
                  onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>StoreDetails()));
              }
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: 100,
                    width: 140,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/2.jpg"
                                  )
                                )
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 20,
                                width: 45,
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(7)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                  //  SvgPicture.asset("assets/svg/star.svg",height: 10,width: 10,)
                                     Icon(Icons.star,size: 15,color: ColorResources.PRIMARY_COLOR,),
                                    Text("4.7",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text("KSR Services",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: ColorResources.PRIMARY_COLOR),),
                        SizedBox(height: 3,),
                        Text("3185, JFK Ave, Jeresey City, New Jeresey, 07325",style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal),)
                      ],
                    ),
                  ),
                ),
              );*/
            }
        ),
      ),
    );
  }
}
