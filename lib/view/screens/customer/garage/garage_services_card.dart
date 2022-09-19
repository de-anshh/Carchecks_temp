import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/model/garage_services_model.dart';
import 'package:carcheck/model/services.dart';
import 'package:carcheck/view/screens/customer/garage/garage_sub_services_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GServiceCard extends StatefulWidget {
  GarageService service;
  Garage garage;
  GServiceCard(this.service, this.garage , {Key? key}) : super(key: key);

  @override
  State<GServiceCard> createState() => _GServiceCardState();
}

class _GServiceCardState extends State<GServiceCard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
           //   widget.service.isServiceSelected = !widget.service.isServiceSelected;
            });
            showDialog(context: context,
                builder: (BuildContext context){
                  return GarageSubServiceCustomDialogBox(
                      widget.service,widget.garage
                  );
                }
            );
          },
          child: Stack(
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: widget.service.isServiceSelected == true
                          ? Colors.green[300]
                          : Colors.greenAccent[100],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        widget.service.isServiceSelected == true
                            ? const BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          color: Colors.grey,
                        )
                            : const BoxShadow()
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home,size: 50,color: Colors.black,),
                      SizedBox(height: 10,),
                      Text(widget.service.subServiceId.toString())
                    ],
                  ),
                ),
              ),
              widget.service.isServiceSelected == true
                  ? const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.greenAccent,
                    size: 20,
                  ),
                ),
              )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
