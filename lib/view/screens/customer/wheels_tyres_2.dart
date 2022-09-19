
import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/view/base_widgets/custom_appbar.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'date_screen.dart';
import 'wheels_tyres_1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WheelsAndTyres2 extends StatefulWidget {
  Garage? garage;
  WheelsAndTyres2({this.garage});

  @override
  _WheelsAndTyres2State createState() => _WheelsAndTyres2State();
}

class _WheelsAndTyres2State extends State<WheelsAndTyres2> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBarWidget(context,_scaffoldKey,"Wheels & Tires"),
      body: Container(
        child: ListView(
          shrinkWrap: true,
       //   crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.symmetric(horizontal: 35,vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueGrey[200]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Notes For Technician",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: (){
                             Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Please provide any notes about the issue that may help the technician with your wheel alignment Adjustment.",style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: TextField(
                      maxLines: 10,
                      controller: notesController,
                      decoration: InputDecoration(
                        hintText: "Required!",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: CustomButton(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>ChooseDate(garage: widget.garage,notes: notesController.text,)));
                  },
                  buttonText: "Continue"
              ),
            )
          ],
        ),
      ),
    );
  }
}
