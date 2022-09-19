import 'dart:developer';
import 'dart:ui';

import 'package:carcheck/locator.dart';
import 'package:carcheck/model/address_model.dart';
import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/provider/address_provider.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/base_widgets/custom_navigation_drawer_widget.dart';
import 'package:carcheck/view/base_widgets/getImage.dart';
import 'package:carcheck/view/base_widgets/search_widget.dart';
import 'package:carcheck/view/base_widgets/star_display.dart';
import 'package:carcheck/view/screens/customer/cart/my_cart.dart';
import 'package:carcheck/view/screens/customer/customer_dashboard.dart';
import 'package:carcheck/view/screens/customer/garage/garage_services_card.dart';
import 'package:carcheck/view/screens/customer/service/service_card.dart';
import 'package:carcheck/view/screens/customer/wheels_tyres_1.dart';
import 'package:carcheck/view/screens/customer/wheels_tyres_2.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class StoreDetails extends StatefulWidget {
  Garage garage;
  StoreDetails(this.garage);

  @override
  _StoreDetailsState createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  String text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum ";
  String chatText =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";
  List<ImageCarousel> _imageUrls = [
    ImageCarousel('assets/images/1.jpg', "Grow your business",
        "Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
    ImageCarousel('assets/images/2.jpg', "Grow your own business",
        "Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
    ImageCarousel('assets/images/3.jpg', "Grow your tkd business",
        "Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
  ];
  int _current = 0;
  bool isCarSelected = true;
  bool isGSelected = false;
  TextEditingController searchTextController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ServiceProvider serviceProvider = locator<ServiceProvider>();
  AddressProvider addressProvider = locator<AddressProvider>();
  getData() async {
    await addressProvider.getAddressById(widget.garage.addressId).then((value) async => {await addressProvider.getCityByCityId(value.cityId)});
  }
  @override
  void initState() {
    getData();
    serviceProvider.getServicesByGarageId(widget.garage.id);
    serviceProvider.getGarageServicesByGarageId(widget.garage.id);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorResources.APPBAR_COLOR,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: ColorResources.BUTTON_COLOR,
          ),
          //SvgPicture.asset("assets/svg/hamburger.svg"),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        actions: [
          getImage(''),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            'assets/svg/menu_cart.svg',
            height: 25,
            width: 25,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchWidget(
                      controller: searchTextController,
                      hintText: "Search Services,Store",
                      onClearPressed: () {},
                      onSubmit: () {}),
                  SizedBox(
                    height: 15,
                  ),
                  getImageSlider(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/menu_services.svg",
                        height: 30,
                        width: 30,
                        color: ColorResources.PRIMARY_COLOR,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Open: ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ColorResources.BUTTON_COLOR),
                              ),
                              Text(
                                "Closes at ${widget.garage.closingTime}",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "See All Hours",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: ColorResources.PRIMARY_COLOR),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(7.0),
                              child: Icon(Icons.call,color: Colors.green,size: 18,)
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                "assets/svg/menu_cart.svg",
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
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.garage.name,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.BUTTON_COLOR),
                      ),
                      Text(
                        widget.garage.noOfRating.toString()+" Rating",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            color: ColorResources.PRIMARY_COLOR),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Consumer<AddressProvider>(
                    builder: (context, model, child) => Text(
                      "${model.addressObj!.street}, ${model.addressObj!.landmark}, ${model.addressObj!.name}, "+
                          "${model.city!.city}, ${model.city!.state}, ${model.city!.country}, ${model.addressObj!.zipCode}",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Highlights",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.garage.discription,
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "See All Services",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  getServices(widget.garage),
                  SizedBox(
                    height: 15,
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
                  SizedBox(
                    height: 15,
                  ),
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
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  color: ColorResources.PRIMARY_COLOR,
                  height: 80,
                ),
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
                      MaterialPageRoute(builder: (builder) => WheelsAndTyres2(garage: widget.garage)));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  int index = -1;

  getImageSlider() {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 160.0,
            aspectRatio: 16 / 9,
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
          items: _imageUrls.map((i) {
            index++;
            return Builder(builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/1.jpg",
                        ))),
              );
            });
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
                  margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
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
  getServices(Garage garage) {
    return Consumer<ServiceProvider>(
      builder: (context, model, child) => Container(
        height: 125,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: model.serviceListByGarageId.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 110,
                  width: 120,
                  margin: EdgeInsets.all(5),
                  child: ServiceCard(model.serviceListByGarageId[index],cost:true));
                 // child: GServiceCard(model.garageServiceListByGarageId[index],widget.garage));
            }
        ),
      ),
    );
  }
  /*getServices() {
    return Container(
      height: 125,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 100,
                width: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.cyan[100],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      size: 50,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Flat Tire")
                  ],
                ),
              ),
            );
          }),
    );
  }
*/
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
