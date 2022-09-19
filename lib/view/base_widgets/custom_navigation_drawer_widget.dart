
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/screens/auth/address_page.dart';
import 'package:carcheck/view/screens/auth/login_page.dart';
import 'package:carcheck/view/screens/auth/profile_page.dart';
import 'package:carcheck/view/screens/customer/cart/my_cart.dart';
import 'package:carcheck/view/screens/customer/customer_dashboard.dart';
import 'package:carcheck/view/screens/customer/offers/special_offers.dart';
import 'package:carcheck/view/screens/customer/service/get_all_services.dart';
import 'package:carcheck/view/screens/customer/service_search.dart';
import 'package:carcheck/view/screens/customer/vehicle/add_vehicle_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget();

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
                  getListTile(context,Icons.home,'Dashboard',0),
                  getListTile(context,Icons.account_circle,'My Profile',1),
                  getListTile(context,Icons.car_rental,'Add Vehicle',2),
                  getListTile(context,Icons.location_on,'Change Location',3),
                  getListTile(context,Icons.search,'Search',4),
                  getListTile(context,Icons.miscellaneous_services,'Services',5),
                  getListTile(context,Icons.local_offer,'Special Offers',6),
               //   getListTile(context,Icons.home,'My Cart',6),
                 // getListTile(context,Icons.home,'My Order',7),
                  getListTile(context,Icons.home,'Logout',7),
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
}

getListTile(BuildContext context,IconData iconData,String title, int index){
  return ListTile(
    leading: Icon(iconData,size: 20,color: Colors.green,),
    title: Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    onTap: () {
      switch(index){
        case 0 :  Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomerDashboard()),
        );
        break;
        case 1 :  Navigator.push(context,
          MaterialPageRoute(builder: (context) => ProfilePage ()),
        );
        break;
        case 2 :  Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddVehicleInfo ()),
        );
        break;
        case 3 :  Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddressPage ()),
        );
        break;
        case 4 :  Navigator.push(context,
          MaterialPageRoute(builder: (context) => ServiceSearch ()),
        );
        break;
        case 5 :  Navigator.push(context,
          MaterialPageRoute(builder: (context) => GetAllServices()),
        );
        break;
        case 6 :  Navigator.push(context,
          MaterialPageRoute(builder: (context) => SpecialOffers ()),
        );
        break;
        case 7 :  Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPage ()),
        );
        break;
        case 8 :  Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        break;
        case 9 :  Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        break;
      }
    },
  );
}
