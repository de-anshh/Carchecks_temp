import 'package:carcheck/dialog/animated_custom_dialog.dart';
import 'package:carcheck/dialog/my_dialog.dart';
import 'package:carcheck/main.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/util/style.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/base_widgets/custom_textfield.dart';
import 'package:carcheck/view/base_widgets/getImage.dart';
import 'package:carcheck/view/base_widgets/star_display.dart';
import 'package:carcheck/view/screens/customer/customer_dashboard.dart';
import 'package:carcheck/view/screens/customer/garage/garage_dashboard.dart';
import 'package:carcheck/view/screens/customer/wheels_tyres_1.dart';
import 'package:carcheck/view/screens/garage_owner/garage_services/choose_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carcheck/locator.dart';
import '../../../../provider/appointment_provider.dart';

class AppointmentDetails extends StatefulWidget {
  Appointment appointment;

  AppointmentDetails(this.appointment);

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final appointmentProvider = locator<AppointmentProvider>();

  String chatText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
  TextEditingController noteController = TextEditingController();
  int _current = 0;
  bool isCarSelected = true;
  bool isGSelected = false;
  TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    appointmentProvider.getAppointmentByGarageId(1);

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(context, _scaffoldKey, "Appointment Details"),
      body: Consumer<AuthProvider>(
        builder: (context, model, child) => Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView (
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: model.image==''?
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                          /*image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/images/1.jpg')*/
                        ),
                        child: Icon(Icons.account_circle_outlined,size: 100,),
                      ):
                      Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[100],
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(model.image)
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Ashish Mishra",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.BUTTON_COLOR),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                "assets/svg/menu_profile.svg",
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),

                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                "assets/svg/menu_search.svg",
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/svg/location.svg"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "3185, JFK Ave, Jeresey City, \nNew Jeresey, 07325",
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
                              "widget.date",
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
                              "widget.time",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Details :",
                          style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('\$210',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.green
                                )),
                            Row(
                              children: [
                                Icon(Icons.view_column_rounded),
                                SizedBox(width: 10,),
                                Text('------1234',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Card Details :",
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Revertron XE",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Services Requested :",
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Oil and filter changed - Full Synthetic Motor Oil - Flat Rate",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Note :",
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Add note",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reviews With",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isCarSelected = !isCarSelected;
                              isGSelected = !isGSelected;
                            });
                          },
                          child: Text(
                            "Car Owner",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                color: isCarSelected
                                    ? ColorResources.BUTTON_COLOR
                                    : Colors.grey),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isCarSelected = !isCarSelected;
                              isGSelected = !isGSelected;
                            });
                          },
                          child: Text(
                            "Garage Owner",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                color: isGSelected
                                    ? ColorResources.PRIMARY_COLOR
                                    : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    getChatList(),
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
                child: CustomButton(
                  buttonText: "Accept",
                  onTap: () {
                   /* showAnimatedDialog(
                        context,
                        MyDialog(
                          icon: Icons.check,
                          title:
                          '',
                          description:
                          'Your Appointment Booked successfully',
                          isFailed: false,
                        ),
                        dismissible: false,
                        isFlip: false);*/
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ChooseServices()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getChatList() {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      getImage(''),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Gaurav",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))
                    ],
                  ),
                  Row(
                    children: [
                      StarDisplay(value: 4),
                      SizedBox(
                        width: 10,
                      ),
                      Text("2 days ago",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 12))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(chatText,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 12))
                ],
              ),
            );
          }),
    );
  }
}
