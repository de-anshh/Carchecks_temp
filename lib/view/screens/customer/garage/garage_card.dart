import 'package:carcheck/model/garage_model.dart';
//import 'package:carcheck/response/garage/getAllGarage.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/screens/customer/garage/garage_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CardStore extends StatefulWidget {
  Garage garage;
  CardStore(this.garage, {Key? key}) : super(key: key);

  @override
  State<CardStore> createState() => _CardStoreState();
}

class _CardStoreState extends State<CardStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>StoreDetails(widget.garage)));
          },
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(10)),
              child: (
                 Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/1.jpg"))
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
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //  SvgPicture.asset("assets/svg/star.svg",height: 10,width: 10,)
                                Icon(
                                  Icons.star,
                                  size: 15,
                                  color: ColorResources.PRIMARY_COLOR,
                                ),
                                Text(
                                  "4.7",
                                  style: TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.garage.name,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.PRIMARY_COLOR),
                          ),
                         /* Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "\$3000",
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2),
                      child: Text(
                        "${widget.garage.name}, ${widget.garage.name}, ${widget.garage.name}",
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                 )
                ),
              ),
            ),
          ),
        ),

    );
  }
}
