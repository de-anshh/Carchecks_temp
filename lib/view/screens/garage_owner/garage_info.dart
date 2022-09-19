import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../customer/garage/garage_dashboard.dart';

class GarageInfo extends StatefulWidget {
  @override
  State<GarageInfo> createState() => _GarageInfoState();
}

class _GarageInfoState extends State<GarageInfo> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ImageCarousel> _imageUrls = [
    ImageCarousel('assets/images/1.jpg', "Grow your business",
        "Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
    ImageCarousel('assets/images/2.jpg', "Grow your own business",
        "Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
    ImageCarousel('assets/images/3.jpg', "Grow your tkd business",
        "Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Suspendisse arcu dui."),
  ];
  int _current = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(context,_scaffoldKey,"Garage Details"),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getImageSlider(),
              Divider(),
              Row(
                children: [
                  Text("Garage Name: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text("${"Hindustan garage"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("Contact Number: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text("${"9330371885"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("EmailId: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text("${"Ashish@gmail.com"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("Website: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text("${"HindustanGarage.com"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),

              Divider(),
              Row(
                children: [
                  Text("Rating: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text(" ${"4 Star"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("Opening Time: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text(" ${"8:30 Am"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("Closing Time: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text("${"10:30 Pm"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("Latitude: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text(" ${"18.530823"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("Longitude: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text("${"73.847466"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("Rating Count: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Text("${"345"}",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text("Address: ",style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12),),
                  Expanded(child: Text("${"Shop no 3,Main Road,Vijay Nagar,Baner,Pune-19"}",maxLines: 3,style: GoogleFonts.poppins(color: Colors.black,fontSize: 15),)),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
