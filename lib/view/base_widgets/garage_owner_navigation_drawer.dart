
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/screens/auth/login_page.dart';
import 'package:carcheck/view/screens/auth/profile_page.dart';
import 'package:carcheck/view/screens/customer/garage/garage_dashboard.dart';
import 'package:carcheck/view/screens/customer/service/get_all_services.dart';
import 'package:carcheck/view/screens/garage_owner/garage_services/view_services.dart';
import '../screens/garage_owner/appointment/all_appointment.dart';
import '../screens/garage_owner/garage_services/all_garage_services.dart';
import '../screens/garage_owner/garage_services/choose_services.dart';
import 'package:carcheck/view/screens/garage_owner/garage_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';

class GarageOwnerDrawerWidget extends StatelessWidget {
  GarageOwnerDrawerWidget();

  List<Appointment> allAppointmnet = [
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: ColorResources.PRIMARY_COLOR,
          ),
        ),
        ClipPath(
          clipper: ProsteBezierCurve(
            position: ClipPosition.right,
            list: [
              BezierCurveSection(
                start: Offset(screenWidth - 150, size.height),
                top: Offset(screenWidth, size.height/2),
                end: Offset(screenWidth - 150, 0),
              ),
            ],
          ),
          child: Drawer(
            backgroundColor: Colors.white,
            child: Consumer<AuthProvider>(
              builder: (context, model, child) =>ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: 50,),
                  InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.clear,color: Colors.green,size: 30,)),
                  SizedBox(height: 10,),
                  getListTile(context,"assets/svg/menu_profile.svg",'Home',0),
                  getListTile(context,"assets/svg/menu_profile.svg",'Garage Info',1),
                  getListTile(context,"assets/svg/menu_profile.svg",'Add Services',2),
                  getListTile(context,"assets/svg/menu_special_offers.svg",'View Services',3),
                  getListTile(context,"assets/svg/menu_search.svg",'Appointments',4),
                  getListTile(context,"assets/svg/menu_services.svg",'Bids',5),
                 // getListTile(context,"assets/svg/menu_special_offers.svg",'Special Offers',5),
                 // getListTile(context,"assets/svg/menu_cart.svg",'My Orders',6),
                  getListTile(context,"assets/svg/menu_logout.svg",'Logout',7),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            right: 20,
            top: 150,
            child: Container(
                alignment: Alignment.center,
                child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[100],
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/3.jpg')
                        )
                    ))
            ))
      ],
    );
  }
  getListTile(BuildContext context,String image,String title, int index){
    return ListTile(
      leading: SvgPicture.asset(image,height: 20,width: 20),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        switch(index){
          case 0 :  Navigator.push(context,
            MaterialPageRoute(builder: (context) => GarageDashboard()),
          );
          break;
          case 1 :  Navigator.push(context,
            MaterialPageRoute(builder: (context) => GarageInfo()),
          );
          break;
          case 2 :  Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChooseServices()),
          );
          break;
          case 3 :  Navigator.push(context,
            MaterialPageRoute(builder: (context) => GetAllGarageSer()),
          );
          break;
          case 4 :  Navigator.push(context,
            MaterialPageRoute(builder: (context) => AllAppointment(allAppointmnet,"All Appointments")),
          );
          break;
          case 5 :  Navigator.push(context,
            MaterialPageRoute(builder: (context) => AllAppointment (allAppointmnet,"All Appointments")),
          );
          break;
          case 6 :  Navigator.push(context,
            MaterialPageRoute(builder: (context) => AllAppointment (allAppointmnet,"All Appointments")),
          );
          break;
          case 7 :  Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          break;
        }
      },
    );
  }
}


