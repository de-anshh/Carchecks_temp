import 'package:carcheck/locator.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/garage_owner_navigation_drawer.dart';
import 'package:provider/provider.dart';
import '../appointment/all_appointment.dart';
import 'add_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base_widgets/custom_button.dart';

class ChooseServices extends StatefulWidget {
  @override
  _ChooseServicesState createState() => _ChooseServicesState();
}

class _ChooseServicesState extends State<ChooseServices> {
  final _scaffoldKey1 = GlobalKey<ScaffoldState>();
  Widget container = Container();
  bool isMapSelected = false, isPopularSelected = false;
  ServiceProvider serviceProvider = locator<ServiceProvider>();

  @override
  void initState() {
    serviceProvider.getAllServices();
    container = getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey1,
      appBar: AppBar(
        backgroundColor: ColorResources.APPBAR_COLOR,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: ColorResources.BUTTON_COLOR,
          ),
          onPressed: () => _scaffoldKey1.currentState!.openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
      drawer: GarageOwnerDrawerWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(
                  child: Text("Choose the services you provide",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey))),
            ),
            SizedBox(height: 15,),
            getServices(),
            SizedBox(
              height: 5,
            ),
            /*CustomButton(
                onTap: () {
                 *//* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => AllAppointment()));*//*
                },
                buttonText: "Continue")*/
          ],
        ),
      ),
    );
  }

  getServices(){
    return Consumer<ServiceProvider>(
      builder: (context, model, child) => Expanded(
       // height: 400,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: model.allServices.length,
          itemBuilder: (context, index) {
           return InkWell(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddServices(model.allServices[index])));
             },
             child: Card(
               elevation: 5,
               shape:
               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
               child: Container(
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                     color: Colors.blueGrey[50],
                     borderRadius: BorderRadius.circular(10)),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       height: 60,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           /*image: DecorationImage(
                               fit: BoxFit.cover,
                               image: AssetImage("assets/images/1.jpg"))*/
                       ),
                       child: Icon(Icons.local_car_wash, size: 50,),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Text(
                       model.allServices[index].name.toString(),
                       style: TextStyle(
                           fontSize: 15,
                           fontWeight: FontWeight.bold,
                           color: ColorResources.BLACK),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                     Container(
                       height: 25,
                       child: ElevatedButton(
                           onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddServices(model.allServices[index])));
                           },
                           style: ElevatedButton.styleFrom(
                             primary: ColorResources.PRIMARY_COLOR,
                             onPrimary: Colors.white,
                             elevation: 3,
                             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                           ),
                           child: Text("Add")),
                     )
                   ],
                 ),
               ),
             ),
           );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0
          ),
        ),
      ),
    );
  }
  getAllData() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCard(Icons.local_car_wash, "Car Wash"),
                getCard(Icons.tire_repair, "Falt Tire"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCard(Icons.battery_alert, "Battery Replacement"),
                getCard(Icons.car_repair, "Car Repair"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCard(Icons.format_paint, "Car Paint"),
                getCard(Icons.car_repair, "Car Repair"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getCard(IconData icon, String service_name) {
    return InkWell(
      onTap: (){
      /*  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => AddServices()));*/
      },
      child: SizedBox(
        width: 150,
        height: 150,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50,),
              Text(
                service_name,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
