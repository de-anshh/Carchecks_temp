import 'package:carcheck/model/services.dart';
import 'package:carcheck/view/screens/customer/service/sub_service_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatefulWidget {
  Service service;
  bool? cost;
  ServiceCard(this.service, {Key? key, this.cost}) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
           /*setState(() {
             widget.service.isServiceSelected = !widget.service.isServiceSelected;
           });*/
           showDialog(context: context,
               builder: (BuildContext context){
                 return SubServiceCustomDialogBox(
                    widget.service,widget.cost
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
                      Icon(Icons.handyman,size: 50,color: Colors.black,),
                      SizedBox(height: 10,),
                      Text(widget.service.name)
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
