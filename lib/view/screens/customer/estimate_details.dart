import 'package:carcheck/dialog/animated_custom_dialog.dart';
import 'package:carcheck/dialog/my_dialog.dart';
import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/provider/appointment_provider.dart';
import 'package:carcheck/provider/bid_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/util/style.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/base_widgets/custom_textfield.dart';
import 'package:carcheck/view/screens/customer/customer_dashboard.dart';
import 'package:carcheck/view/screens/customer/wheels_tyres_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'wheels_tyres_2.dart';
import 'package:flutter/material.dart';

class EstimateDetails extends StatefulWidget {
  Garage? garage;
  String? date,time,notes;
  EstimateDetails({this.garage,this.date,this.time,this.notes});
  @override
  _EstimateDetailsState createState() => _EstimateDetailsState();
}

class _EstimateDetailsState extends State<EstimateDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(context, _scaffoldKey, "Estimate Details"),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.garage==null?"KSR Services":widget.garage!.name.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.BUTTON_COLOR),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/svg/location.svg"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.garage==null?"3185, JFK Ave, Jeresey City, \nNew Jeresey, 07325":widget.garage!.addressId.toString(),
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Date: ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.date==''?"21/08/2022":widget.date.toString(),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Time: ",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              widget.time==''?"02:00 PM":widget.time.toString(),
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.normal),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Services Requested",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.edit,
                        color: ColorResources.PRIMARY_COLOR,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Oil and filter changed - Full Synthetic Motor Oil - Flat Rate",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ColorResources.TEXTFEILD_COLOR),
                    child: TextFormField(
                      controller: noteController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add Note",
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  //   SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Type',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Text('----------',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Text('Package Price',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quantity',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Text('----------',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Text('1',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Text('----------',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Text('\$100',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Extended',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Text('----------',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                      Text('\$100',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SubTotal :',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('\$200',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Taxes :',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('\$10',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  Divider(thickness: 1),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price :',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text('\$210',
                          style: TextStyle(fontSize: 15, color: Colors.green)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.view_column_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text('------1234',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Edit",
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: ProsteBezierCurve(
                position: ClipPosition.top,
                list: [
                  BezierCurveSection(
                    start: Offset(screenWidth, 30),
                    top: Offset(screenWidth / 2, 0),
                    end: Offset(0, 30),
                  ),
                ],
              ),
              child: Container(
                color: ColorResources.PRIMARY_COLOR,
                height: 80,
              ),
            ),
          ),
          Positioned(
            bottom: 45,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Consumer<AppointmentProvider>(
                builder: (context, model, child) =>  CustomButton(
                  buttonText: "Book Appointment",
                  onTap: () {
                    model.SaveAppointment(accept: true,active: true,availableTime: 'time',date: 'widget.date',
                        garrageId: 1,status: 'New Arrival',SubServiceId: 1,time: "widget.time",userId: 1);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Your Appointement added Succesfully '),
                      backgroundColor: Colors.green,
                    ));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CustomerDashboard()));

                   /* showAnimatedDialog(
                        context,
                        *//*MyDialog(
                          icon: Icons.check,
                          title:
                          '',
                          description:
                          'Your Appointment Booked successfully',
                          isFailed: false,
                        )*//*
                        Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Stack(clipBehavior: Clip.none, children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                top: -55,
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: ColorResources.GREEN,
                                      shape: BoxShape.circle),
                                  child: Transform.rotate(
                                      angle: 45,
                                      child: Icon(Icons.check,
                                          size: 40, color: Colors.white)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 40),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Your Appointment Booked successfully",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                      SizedBox(height: 20),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.center,
                                        child: CustomButton(
                                            buttonText: 'Ok',
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        CustomerDashboard()))),
                                      ),
                                    ]),
                              ),
                            ]),
                          ),
                        ),
                        dismissible: false,
                        isFlip: false);*/
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CustomerDashboard()));*/
                  },
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }
}
