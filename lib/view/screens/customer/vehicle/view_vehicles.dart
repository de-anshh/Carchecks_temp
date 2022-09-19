import 'package:carcheck/locator.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/provider/vehicle_provider.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ViewVehicles extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VehicleProvider vehicleProvider = locator<VehicleProvider>();
  AuthProvider authProvider = locator<AuthProvider>();
  @override
  Widget build(BuildContext context) {
    vehicleProvider.getAllVehicleListByUserId(id: authProvider.userDetails!.id);
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(context,_scaffoldKey,"Vehicle Details"),
      body: Consumer<VehicleProvider>(
        builder: (context, model, child) => Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: model.vehicleListByUserId.length,
            itemBuilder: (context,index){
              return Card(
                elevation: 7,
                margin: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Icon(Icons.car_rental,size: 70,)),
                      Divider(),
                      Row(
                        children: [
                          Text("Vehicle Type: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                          Text("${model.vehicleListByUserId[index].vehicletype.name}"),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Vehicle Name: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                          Text("${model.vehicleListByUserId[index].name}"),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Vehicle Model: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                          Text(" ${model.vehicleListByUserId[index].vehicleModel}"),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Vehicle Manufacturer: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                          Text(" ${model.vehicleListByUserId[index].vehicleManufacturer.name}"),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Fuel Type: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                          Text(" ${model.vehicleListByUserId[index].fueltype.name}"),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Vehicle Registration Number: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                          Text("${model.vehicleListByUserId[index].registrationNo}",style: GoogleFonts.poppins(color: Colors.green),),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Manufacturing Year: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                          Text("${model.vehicleListByUserId[index].yearOfManufacturing}",style: GoogleFonts.poppins(color: Colors.green),),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Last Servicing date Year: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                          Text("${model.vehicleListByUserId[index].lastServiceDate}",style: GoogleFonts.poppins(color: Colors.green),),
                        ],
                      ),
                    ],
                  ),
                ),
              );
                /*Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.car_rental,size: 70,),
                      SizedBox(height: 20,),
                      Text('Car Name',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(height: 10,),
                      Text('Car Model',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),
                      SizedBox(height: 10,),
                      Text('Manufacturing Year',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),
                      SizedBox(height: 10,),
                      Text('Fuel Type',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),
                      SizedBox(height: 10,),
                      Text('Last Servicing Date',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 17),),
                    ],
                  ),
                ),
              );*/
            },
          ),
        ),
      ),
    );
  }
}
