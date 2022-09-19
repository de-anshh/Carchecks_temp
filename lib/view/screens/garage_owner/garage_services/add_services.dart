import 'dart:ui';

import 'package:carcheck/dialog/animated_custom_dialog.dart';
import 'package:carcheck/dialog/my_dialog.dart';
import 'package:carcheck/locator.dart';
import 'package:carcheck/model/fuel_type_model.dart';
import 'package:carcheck/model/services.dart';
import 'package:carcheck/model/subservices_model.dart';
import 'package:carcheck/model/vehicle_type_model.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/provider/fuel_provider.dart';
import 'package:carcheck/provider/garage_provider.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/provider/vehicle_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/util/style.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/base_widgets/custom_dropdown_list.dart';
import 'package:carcheck/view/base_widgets/custom_textfield.dart';
import 'package:carcheck/view/screens/customer/zip_code.dart';
import 'package:carcheck/view/screens/garage_owner/garage_services/view_sub_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddServices extends StatefulWidget {
  Service allServices;
  AddServices(this.allServices);

  @override
  _AddServicesState createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  TextEditingController imgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addinfoController = TextEditingController();
  TextEditingController selectedSubServicesController = TextEditingController();

  List<String> vehicleTypeList = <String>['Car', 'Bus','Two Wheeler',];
  String selectedVehicleType = 'Bus';
  VehicleType? vehicleType;
  SubService? subService;
  FuelType? fuelType;
  String selectedFuelType = '';
  ServiceProvider serviceProvider = locator<ServiceProvider>();
  AuthProvider authProvider = locator<AuthProvider>();
  GarageProvider garageProvider = locator<GarageProvider>();

  final now = DateTime.now();
  String formatter = '';

  @override
  void initState() {
    formatter = DateFormat('yMd').format(now);
    serviceProvider.getSubServicesByServiceId(serviceId: widget.allServices.id);
    garageProvider.getGarageByUserId(authProvider.userDetails!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorResources.PRIMARY_COLOR,
          leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 30,)),
          title: Text("Services  Details",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),)
      ),
      body: SingleChildScrollView(
        child: Container(
          color: ColorResources.PRIMARY_COLOR,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height-150,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(alignment: Alignment.center, child: Text(widget.allServices.name.toString(), style: TextStyle( fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black))),
                          SizedBox(height: 10,),
                          Text("Select SubServices Type"),
                          Consumer<ServiceProvider>(
                            builder: (context, model, child) =>Container(
                                margin: EdgeInsets.all(10.0),
                                padding: EdgeInsets.only(bottom: 16.0),
                                child: FormBuilderDropdown(
                                    name: "",
                                    allowClear: true,
                                    isDense: false ,
                                    decoration: InputDecoration.collapsed(
                                      hintText: '',
                                      border:OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(color: Colors.black,width: 7)
                                      ),
                                    ),
                                    hint: Container(
                                      height: 60,
                                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                                      child: Text(
                                        "Select Service",
                                      ),
                                    ),
                                    validator: FormBuilderValidators.compose(
                                        [FormBuilderValidators.required(context)]),
                                    items: model.subServicesNameList
                                        .map((value) => DropdownMenuItem(
                                      value: value,
                                      child: Container(
                                        height: 60,
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                                        child: Text(
                                          '$value',
                                          // style: Style.dropdownValue,
                                        ),
                                      ),
                                    )
                                    )
                                        .toList(),
                                    onChanged: (String? value) {
                                        selectedSubServicesController.text = value!;
                                        subService = model.getSelectedGarageServiceId(selectedSubServicesController.text);
                                    })
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("Add Image (Optional)"),
                          SizedBox(height: 10,),
                          Container(
                            height:100,
                            padding: EdgeInsets.only(bottom: 16.0),
                            margin: EdgeInsets.all(10.0),
                            alignment: Alignment.center,
                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          border: Border.all()),
                            child: Icon(Icons.add, size: 30),
                          ),
                          SizedBox(height: 10,),
                          Text("Add Description"),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              maxLines: 5,
                              controller: addinfoController,
                              decoration: InputDecoration(
                                hintText: "Details!",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Text("Price"),
                          Container(
                            //width: 100,
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              maxLines: 1,
                              controller: priceController,
                              decoration: InputDecoration(
                                hintText: "\$\$\$",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Text("Select Vehicle Type"),
                          Consumer<VehicleProvider>(
                            builder: (context, model, child) => Container(
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: FormBuilderDropdown(
                                  name: "",
                                  allowClear: true,
                                  isDense: false ,
                                  decoration: InputDecoration.collapsed(
                                    hintText: '',
                                    border:OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(color: Colors.black,width: 7)
                                    ),
                                  ),
                                  hint: Container(
                                    height: 60,
                                    padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                                    child: Text(
                                      "Select Vehicle Type",
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose(
                                      [FormBuilderValidators.required(context)]),
                                  items: model.allVehicleTypeNameList
                                      .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Container(
                                      height: 60,
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 15),
                                      child: Text(
                                        '$value',
                                      ),
                                    ),
                                  )
                                  )
                                      .toList(),
                                  onChanged: (String? value) {
                                    selectedVehicleType = value!;
                                    vehicleType = model.getSelectedVehicleId(selectedVehicleType);
                                  })
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Consumer<GarageProvider>(
                    builder: (context, model, child) => CustomButton(
                      buttonText: "Add",
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (_) =>
                                CupertinoAlertDialog(
                                  title: const Text(
                                    'Are you sure want to add service?',
                                    // style: Style.heading,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                          "Yes",
                                          style: Style.okButton),
                                      onPressed: () {
                                        model.addGarageService(
                                            active: true,
                                            created: formatter,
                                            created_by: authProvider.userDetails!.firstName,
                                            cost: priceController.text,
                                            image_url: imgController.text,
                                            description: addinfoController.text,
                                            short_desc: addinfoController.text,
                                            subServiceId: subService!.id,
                                            garageId:model.ownGarageList[0].id,
                                            vehicletype: vehicleType,
                                            updated: formatter,
                                            updated_by: authProvider.userDetails!.firstName,
                                            )
                                            .then((value) => {
                                          print(value),
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text('You added Service Succesfully  '),
                                        backgroundColor: Colors.green,
                                        )),
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) => ViewServices()))
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                          "No",
                                          style:
                                          Style.cancelButton
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ));
                      },
                    ),
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }

  getProfile(String img, String name) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[100],
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/1.jpg')
                        )
                    )),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Card(
                    // elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white
                      ),
                      child: IconButton(
                        icon: Icon(Icons.edit,),
                        onPressed: (){},
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Text("KSR Services",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20))
        ],
      ),
    );

  }
}
