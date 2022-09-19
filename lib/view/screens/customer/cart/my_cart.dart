import 'dart:ui';

import 'package:carcheck/locator.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/util/app_constants.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/screens/customer/wheels_tyres_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyCart extends StatefulWidget {
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final authProvider = locator<AuthProvider>();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(context, _scaffoldKey, "My Cart"),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height-200,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    )
                  ]),
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage("assets/images/1.jpg")),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    //  child: Icon(Icons.add)
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      height: 20,
                                      width: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(50),
                                      ),
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                        size: 18,
                                      )),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Basic Service",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Text(
                                    "* Every 5000 kms/3 Months",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "* Takes 4 hrs",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "* 1 Month Warrenty",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "* Include 9 services",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 9,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppConstants.money + "3,399",
                                        style: TextStyle(
                                            fontSize: 14,
                                            decoration: TextDecoration
                                                .lineThrough,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        AppConstants.money + "2,399",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight:
                                                FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black54,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_offer,
                                  size: 15,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Save \$100 compaired to other services",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  )
          ),
          Container(
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cart Value",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        AppConstants.money + "10,000",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150,
                  child: CustomButton(
                    buttonText: "Checkout",
                    onTap: () {
                     // Navigator.push(context, MaterialPageRoute(builder: (builder)=>WheelsAndTyres2()));
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
