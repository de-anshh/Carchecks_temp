import 'dart:io';
import 'dart:typed_data';

import 'package:carcheck/dialog/animated_custom_dialog.dart';
import 'package:carcheck/dialog/my_dialog.dart';
import 'package:carcheck/locator.dart';
import 'package:carcheck/model/fuel_type_model.dart';
import 'package:carcheck/model/user_table_model.dart';
import 'package:carcheck/model/vehicle_manufacturer_model.dart';
import 'package:carcheck/model/vehicle_model.dart';
import 'package:carcheck/model/vehicle_type_model.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/provider/fuel_provider.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/provider/vehicle_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/util/style.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/base_widgets/custom_dropdown_list.dart';
import 'package:carcheck/view/base_widgets/custom_textfield.dart';
import 'package:carcheck/view/base_widgets/registration_text_field.dart';
import 'package:carcheck/view/screens/customer/customer_dashboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddVehicleInfo extends StatefulWidget {
  @override
  _AddVehicleInfoState createState() => _AddVehicleInfoState();
}

class _AddVehicleInfoState extends State<AddVehicleInfo> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController rnoController = TextEditingController();
  TextEditingController noOfServicingController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController kmRunController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  Vehicle? vehicle;
  VehicleType? vehicleType;
  VehicleManufacturer? vehicleManufacturer;
  FuelType? fuelType;
  String selectedFuelType = '';
  User? user;
  List<String> yearList = <String>[
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012',
    '2011',
    '2010',
    '2009',
    '2008',
    '2007',
    '2006',
    '2005',
    '2004',
    '2003',
    '2002',
    '2001',
    '2000',
  ];

  List<String> vehicleCompanyList = <String>[
    'Chevrolet',
    'Tata Nexon',
    'Alto',
    'Santro',
    'Eeco',
    'Renault Kwid',
    'Hyundai'
  ];
  List<String> modelList = <String>[
    '2.0L I4 16v',
    'HR 13 DDT',
    'mStallion',
    'Revotron'
  ];

  List<String> sList = <String>['2.0L I4 16v', 'Part Load'];
  String selectedYear = '';
  String selectedVehicleType = 'Bus';
  String selectedVehicleCompany = 'string';
  String selectedModel = 'string';
  FuelProvider fuelTypeProvider = locator<FuelProvider>();
  VehicleProvider vehicleProvider = locator<VehicleProvider>();
  final now = DateTime.now();
  String formatter = '';

  @override
  void initState() {
    // TODO: implement initState
    formatter = DateFormat('yMd').format(now);
    user = authProvider.userDetails;
    fuelTypeProvider.getAllFuelType();
    vehicleProvider.getAllVehicle();
    vehicleProvider.getAllVehicleManufacture();
    vehicleProvider.getAllVehicleType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(
          context, _scaffoldKey, "Tell Us About Your Vehicle"),
      body: Consumer<VehicleProvider>(
        builder: (context, model, child) => Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Vehicle Manufacturing Year",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDropdownList(
                  hintText: "Select Manufacturing Year",
                  items: yearList,
                  selectedType: selectedYear,
                  onChange: (String value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Select Your Vehicle Type",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDropdownList(
                  hintText: "Select Vehicle Type",
                  items: model.allVehicleTypeNameList,
                  selectedType: selectedVehicleType,
                  onChange: (String value) {
                    setState(() {
                      selectedVehicleType = value;
                      vehicleType =
                          model.getSelectedVehicleTypeId(selectedVehicleType);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Select Your Vehicle Company",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDropdownList(
                  hintText: "Select Vehicle",
                  items: model.allVehicleManufacturerNameList,
                  selectedType: selectedVehicleCompany,
                  onChange: (String value) {
                    setState(() {
                      selectedVehicleCompany = value;
                      vehicleManufacturer =
                          model.getSelectedVehicleManufacturerId(
                              selectedVehicleCompany)!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Select Your Vehicle Model",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomDropdownList(
                  hintText: "Select Vehicle Model",
                  items: modelList,
                  selectedType: selectedModel,
                  onChange: (String value) {
                    setState(() {
                      selectedModel = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
            Text(
              "Vehicle Name",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                height: 50,
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: vehicleNameController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Vehicle Name',
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,),
                Text(
                  "Vehicle Registration Number",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: rnoController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Registration Number',
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Kilometer Run",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: kmRunController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Kilometer Run',
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Vehicle Average",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: avgController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Average Run',
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Number of Serving Done",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: noOfServicingController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Number Of Servicing',
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Add Vehicle Photo",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: TextFormField(
                      onTap: () {
                        pickFile(model);
                      },
                      controller: photoController,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Click here to add vehicle photo',
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),

                /*Text("Select Vehicle Fuel Type",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                CustomDropdownList(
                  hintText: "Select Vehicle Fuel Type",
                  items: engineList,
                  selectedType: selectedEngine,
                  onChange: (String value){
                    setState(() {
                      selectedEngine = value;
                    });
                  },
                ),
                SizedBox(height: 30,),
                Text("Select Your Vehicle Engine",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                CustomDropdownList(
                  hintText: "Select Vehicle Engine",
                  items: engineList,
                  selectedType: selectedEngine,
                  onChange: (String value){
                    setState(() {
                      selectedEngine = value;
                    });
                  },
                ),*/
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: CustomButton(
                    buttonText: 'Continue',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) => CupertinoAlertDialog(
                                title: const Text(
                                  'Are you sure want to add vehicle?',
                                  // style: Style.heading,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("Yes", style: Style.okButton),
                                    onPressed: () async {
                                      var result = await model
                                          .addVehicle(
                                            userId: user!.id,
                                            active: true,
                                            created: formatter,
                                            created_by: authProvider
                                                .userDetails!.firstName,
                                            name: vehicleNameController.text,
                                            image_url: photoController.text,
                                            last_servecing_date: selectedModel,
                                            year: selectedYear,
                                            vehicle_model: selectedModel,
                                            regNumber: rnoController.text,
                                            avgRun: avgController.text,
                                            kiloMeterRun: kmRunController.text,
                                            no_Of_servecing:
                                                noOfServicingController.text,
                                            fuelType: fuelTypeProvider
                                                .allFuelTypeList[0],
                                            vehicleType: vehicleType,
                                            vehicleManufacturer:
                                                vehicleManufacturer,
                                            updated: formatter,
                                            updated_by: authProvider
                                                .userDetails!.firstName,
                                          )
                                          .then((value) => {
                                                print(value),
                                                /* model
                                         .addUserVehicle(
                                     active: true,
                                     created: formatter,
                                     created_by: authProvider
                                         .userDetails!
                                         .firstName,
                                     name: selectedModel,
                                     image_url:
                                     photoController.text,
                                     last_servecing_date:
                                     selectedModel,
                                     year: selectedYear,
                                     vehicle_model:
                                     selectedModel,
                                       userId: user!.id,
                                     regNumber:
                                     rnoController.text,
                                     avgRun:
                                     avgController.text,
                                     kiloMeterRun:
                                     kmRunController.text,
                                     no_Of_servecing:
                                     noOfServicingController
                                         .text,
                                     vehicle: value,
                                     updated: formatter,
                                     updated_by: authProvider
                                         .userDetails!
                                         .firstName,
                                     )
                                         .then((value) => {*/
                                                showAnimatedDialog(
                                                    context,
                                                    MyDialog(
                                                      icon: Icons.check,
                                                      title: 'Vehicle',
                                                      description:
                                                          'Successfully added vehicle',
                                                      isFailed: false,
                                                    ),
                                                    dismissible: false,
                                                    isFlip: false),
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            CustomerDashboard()))
                                              });

                                    //  Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child:
                                        Text("No", style: Style.cancelButton),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ));
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>CustomerDashboard()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PlatformFile? objFile;
  TextEditingController photoController = TextEditingController();
  final authProvider = locator<AuthProvider>();
  File? imagefile;
  Uint8List? imageBytes;
  String? fileName;
  final _formKey = GlobalKey<FormState>();

  pickFile(VehicleProvider model) async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
      });
      try {
        fileName = result.files.first.name;
        print(result.files.first.toString());
        imagefile = File(result.files.first.name);
        imageBytes = result.files.first.bytes;
        print(fileName);
        photoController.text = fileName!;
        model.setImage(fileName);
      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
  }
}
