import 'dart:ui';

import 'package:carcheck/locator.dart';
import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/model/garage_services_model.dart';
import 'package:carcheck/model/services.dart';
import 'package:carcheck/model/subservices_model.dart';
import 'package:carcheck/provider/services_provider.dart';
import 'package:carcheck/util/style.dart';
import 'package:carcheck/view/screens/customer/garage/near_by_store.dart';
import 'package:carcheck/view/screens/customer/wheels_tyres_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class GarageSubServiceCustomDialogBox extends StatefulWidget {
  GarageService service;
  Garage garage;
  GarageSubServiceCustomDialogBox(this.service, this.garage);


  @override
  _GarageSubServiceCustomDialogBoxState createState() => _GarageSubServiceCustomDialogBoxState();
}

class _GarageSubServiceCustomDialogBoxState extends State<GarageSubServiceCustomDialogBox> {
  final model = locator<ServiceProvider>();


  List<bool> _selected = [];

  List<SubService> selectedList = [];
  @override
  void initState() {
    super.initState();
    model.getSubServicesByServiceId(serviceId: widget.service.id);
    _selected = List<bool>.generate(20, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Consumer<ServiceProvider>(
        builder: (context, model, child) => Container(
          margin: EdgeInsets.only(top: 45,left: 0,right: 0,bottom: 50),
          height: 300,
          width: 500,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child:Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  _createDataTable()
                ],
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: (){
                  //Navigator.push(context,MaterialPageRoute(builder: (builder)=>NearByStore(selectedList: selectedList)));
                  Navigator.push(context,MaterialPageRoute(builder: (builder)=>WheelsAndTyres2(garage: widget.garage)));
                },
                child: Text( 'Ok',style: Style.button),
              )
            ],
          ),
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text(widget.service.subServiceId.toString())),
      DataColumn(label: Text('Cost'))
    ];
  }
  List<DataRow> _createRows() {
    return model.subServiceListByServiceId
        .mapIndexed((index, book) => DataRow(
        cells: [
          DataCell(Consumer<ServiceProvider>(
              builder: (context, model, child) => Text(model.subServiceListByServiceId[index].name))),
          DataCell(Consumer<ServiceProvider>(
              builder: (context, model, child) => Text(model.subServiceListByServiceId[index].costing)))
        ],
        selected: _selected[index],
        onSelectChanged: (bool? selected) {
          setState(() {
            _selected[index] = selected!;
            selectedList.add(model.subServiceListByServiceId[index]);
          });
        }))
        .toList();
  }


}