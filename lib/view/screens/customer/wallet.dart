import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/screens/customer/estimate_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'wheels_tyres_2.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  Garage? garage;
  String? date,time,notes;
  Wallet({this.garage,this.date,this.time,this.notes});

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


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
      appBar: CustomAppBarWidget(context,_scaffoldKey,"Wallet"),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Send a gift",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text("You can now send an instant gift card.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueGrey[100]
                        ),
                        child: Text("Send gift card",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Text("Payment Methods",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                InkWell(
                  onTap: (){

                  },
                  child: Row(
                    children: [
                      Icon(Icons.add,size: 25,),
                      SizedBox(width: 10,),
                      Text("Add Payment Method Or \nRedeem Gift Card",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,),maxLines: 2,),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Text("Vouchers",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                SizedBox(height: 15,),
                InkWell(
                  onTap: (){

                  },
                  child: Row(
                    children: [
                      Icon(Icons.add,size: 25,),
                      SizedBox(width: 10,),
                      Text("Add Voucher Code",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
              ],
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
              child: CustomButton(
                buttonText: "Continue",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => EstimateDetails(garage: widget.garage,date: widget.date.toString(),time:widget.time,notes: widget.notes,)));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

