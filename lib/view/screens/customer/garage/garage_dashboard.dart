import 'dart:ui';
import 'package:carcheck/locator.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/provider/garage_provider.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/custom_navigation_drawer_widget.dart';
import 'package:carcheck/view/base_widgets/garage_owner_navigation_drawer.dart';
import 'package:carcheck/view/base_widgets/getImage.dart';
import 'package:carcheck/view/base_widgets/search_widget.dart';
import 'package:carcheck/view/screens/auth/profile_page.dart';
import 'package:carcheck/view/screens/customer/cart/my_cart.dart';
import 'package:carcheck/view/screens/customer/garage/garage_card.dart';
import 'package:carcheck/view/screens/customer/garage/near_by_store.dart';
import 'package:carcheck/view/screens/customer/service/get_all_services.dart';
import 'package:carcheck/view/screens/customer/service/service_card.dart';
import 'package:carcheck/view/screens/garage_owner/appointment/all_appointment.dart';
import 'package:carcheck/view/screens/garage_owner/garage_services/add_services.dart';
import 'package:carcheck/view/screens/garage_owner/garage_services/choose_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class ImageCarousel{
  String image1;
  String title;
  String subTitle;

  ImageCarousel(this.image1, this.title, this.subTitle);
}

class GarageDashboard extends StatefulWidget {
  @override
  _GarageDashboardState createState() => _GarageDashboardState();
}

class _GarageDashboardState extends State<GarageDashboard> {
  List<ImageCarousel> _imageUrls = [
    ImageCarousel('assets/images/1.jpg',"Grow your business","Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
    ImageCarousel('assets/images/2.jpg',"Grow your own business","Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
    ImageCarousel('assets/images/3.jpg',"Grow your tkd business","Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
  ];
  int _current = 0;
  TextEditingController searchTextController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ServiceProvider serviceProvider = locator<ServiceProvider>();
  GarageProvider garageProvider = locator<GarageProvider>();

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

  List<Appointment> allNewAppointmnet = [
    Appointment("Edward Sheren", "Today, June 26", "New Request", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "New Request", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "New Request", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "New Request", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "New Request", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "New Request", Colors.blue),
    Appointment("Edward Sheren", "Today, June 26", "New Request", Colors.blue),
  ];

  List<Appointment> allPendingAppointmnet = [
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
    Appointment("Edward Sheren", "Today, June 26", "Pending", Colors.green),
  ];

  List<Appointment> allWorkingAppointmnet = [
    Appointment("Edward Sheren", "Today, June 26", "Work In Progress", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Work In Progress", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Work In Progress", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Work In Progress", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Work In Progress", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Work In Progress", Colors.pink),
    Appointment("Edward Sheren", "Today, June 26", "Work In Progress", Colors.pink),
  ];

  String location ='Null, Press Button';
  String Address = 'searching current location.......';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }

  getCurrentLocation() async {
    Position position = await _getGeoLocationPosition();
    location ='Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    serviceProvider.getAllServices();
    garageProvider.getAllGarage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorResources.APPBAR_COLOR,
        leading: IconButton(
          icon: Icon(Icons.menu,color: ColorResources.BUTTON_COLOR,),//SvgPicture.asset("assets/svg/hamburger.svg"),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child:  getImage(''),),
          SizedBox(width: 10,),
          /*InkWell(
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyCart()),
                );
              },
              child: SvgPicture.asset('assets/svg/menu_cart.svg',height: 25,width: 25,color: Colors.black,)),
          SizedBox(width: 10,),*/
        ],
      ),
      drawer: GarageOwnerDrawerWidget(),
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(
          builder: (context, model, child) =>Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               /* Row(
                  children: [
                    SvgPicture.asset("assets/svg/location.svg"),
                    //  Image.asset('assets/svg/Icon-awesome-map-marker-alt.svg',height: 30,width: 30,),
                    SizedBox(width: 10,),
                    Expanded(child: Text(Address,maxLines:2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
                  ],
                ),
                SizedBox(height: 15,),*/
                SearchWidget(controller: searchTextController, hintText: "Search Services You Provide", onClearPressed: (){}, onSubmit: (){}),
                SizedBox(height: 15,),
                /*getImageSlider(),
                SizedBox(height: 15,),*/
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("All Services",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>GetAllServices()));
                        },
                        child: Text("View All",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,decoration: TextDecoration.underline,color: ColorResources.PRIMARY_COLOR),)),
                  ],
                ),
                SizedBox(height: 15,),*/
                getCards(),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Choose Services",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>ChooseServices()));
                        },
                        child: Text("View All",style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15,decoration: TextDecoration.underline,color: ColorResources.PRIMARY_COLOR),)),
                  ],
                ),
                SizedBox(height: 15,),
                getAvailableServices(),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int index = -1;
  getImageSlider(){
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 160.0,
            aspectRatio: 16/9,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: _imageUrls.map((i){
            index++;
            return Builder(
                builder:(BuildContext context){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/1.jpg",)
                        )
                    ),
                  );
                }
            );
          }).toList(),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _imageUrls.map((i) {
                int index = _imageUrls.indexOf(i);
                return Container(
                  width: 7.0,
                  height: 7.0,
                  margin: EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? ColorResources.PRIMARY_COLOR
                        : Colors.black.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
          ),
        )
      ],
    );

  }

  getCards() {
    return Container(
      height: 320,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCard(Icons.local_car_wash, "Number Of Request",Colors.orange,0,"100"),
                getCard(Icons.tire_repair, "Work In Progress Request",Colors.green,1,"23"),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children  : [
                getCard(Icons.battery_alert, "New Appointments",Colors.blue,2,"25"),
                getCard(Icons.car_repair, "Pending Appointments",Colors.pink,3,"15"),
              ],
            ),

          ],
        ),
      ),
    );
  }

  getCard(IconData icon, String service_name, MaterialColor color, int i,String count) {
    return InkWell(
      onTap: (){
        switch(i){
          case 0 : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => AllAppointment(allAppointmnet,service_name)));
          break;
          case 1 : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => AllAppointment(allWorkingAppointmnet,service_name)));
          break;
          case 2 : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => AllAppointment(allNewAppointmnet,service_name)));
          break;
          case 3 : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => AllAppointment(allPendingAppointmnet,service_name)));
          break;
        }

      },
      child: SizedBox(
        width: 150,
        height: 150,
        child: Card(
          elevation: 6,
          color: color[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon(icon, size: 50,),
              Text(
                count,
                textAlign: TextAlign.center,
                style: TextStyle(color: color,fontWeight: FontWeight.bold,fontSize: 30),
              ),
              SizedBox(height: 5,),
              Text(
                service_name,
                textAlign: TextAlign.center,
                style: TextStyle(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }

  getAvailableServices() {
    return Consumer<ServiceProvider>(
      builder: (context, model, child) => Container(
        height: 170,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.allServices.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 160,
                  width: 150,
                  margin: EdgeInsets.all(5),
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
                  ));
              /*return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>StoreDetails()));
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: 100,
                    width: 140,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/2.jpg"
                                  )
                                )
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 20,
                                width: 45,
                                margin: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(7)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                  //  SvgPicture.asset("assets/svg/star.svg",height: 10,width: 10,)
                                     Icon(Icons.star,size: 15,color: ColorResources.PRIMARY_COLOR,),
                                    Text("4.7",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text("KSR Services",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: ColorResources.PRIMARY_COLOR),),
                        SizedBox(height: 3,),
                        Text("3185, JFK Ave, Jeresey City, New Jeresey, 07325",style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal),)
                      ],
                    ),
                  ),
                ),
              );*/
            }
        ),
      ),
    );
  }

}


class Appointment{
  String name,date,status;
  MaterialColor color;

  Appointment(this.name, this.date, this.status, this.color);
}