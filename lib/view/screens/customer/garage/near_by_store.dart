
import 'dart:async';

import 'package:carcheck/locator.dart';
import 'package:carcheck/model/subservices_model.dart';
import 'package:carcheck/provider/garage_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carcheck/view/screens/customer/garage/garage_card.dart';
import 'package:carcheck/view/screens/customer/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class NearByStore extends StatefulWidget {
  List<SubService>? selectedList;
  NearByStore({Key? key, this.selectedList}) : super(key: key);

  @override
  _NearByStoreState createState() => _NearByStoreState();
}

class _NearByStoreState extends State<NearByStore> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget container = Container();
  bool isMapSelected = false,isPopularSelected = false;
  GarageProvider garageProvider = locator<GarageProvider>();
  @override
  void initState() {
    container = getAllData(garageProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(context,_scaffoldKey,"All near by stores"),
      body: Consumer<GarageProvider>(
        builder: (context, model, child) =>Container(
         // padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          isPopularSelected = !isPopularSelected;
                         // isMapSelected = !isMapSelected;
                        });
                        if(isPopularSelected == true)
                        {isMapSelected=false;};

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isPopularSelected? Colors.green[200
                          ]:Colors.transparent
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.pool_outlined),
                            //SvgPicture.asset("assets/svg/up_down_arrow.svg",height: 15,width: 15,),
                            SizedBox(width: 5,),
                            Text("Popular",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isMapSelected = !isMapSelected;
                        //  isPopularSelected = !isPopularSelected;
                        });
                        if(isMapSelected == true)
                        {isPopularSelected=false;};

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isMapSelected? Colors.green[200]:Colors.transparent
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.map),
                            //SvgPicture.asset("assets/svg/map.svg",height: 15,width: 15,),
                            SizedBox(width: 5,),
                            Text("On Map",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15,),
              isPopularSelected?getPopularData(model):isMapSelected?MapScreen():getAllData(model)
            ],
          ),
        ),
      ),
    );
  }

  getAllData(GarageProvider model){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Near By Stores",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: model.allGarageList.length,
                itemBuilder: (context, index) => CardStore(model.allGarageList[index]),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getPopularData(GarageProvider model){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Popular Near By Stores",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: model.isPopularGarageList.length,
                itemBuilder: (context, index) => CardStore(model.isPopularGarageList[index]),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
 }
