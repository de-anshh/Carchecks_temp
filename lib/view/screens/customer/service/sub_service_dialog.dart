import 'dart:ui';

import 'package:carcheck/locator.dart';
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

class SubServiceCustomDialogBox extends StatefulWidget {
  Service service;
  bool? cost;
  SubServiceCustomDialogBox(this.service, this.cost);


  @override
  _SubServiceCustomDialogBoxState createState() => _SubServiceCustomDialogBoxState();
}

class _SubServiceCustomDialogBoxState extends State<SubServiceCustomDialogBox> {
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
            width: 560,
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
            child:SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 230,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        _createDataTable()
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: (){
                      widget.cost==false?
                      Navigator.push(context,MaterialPageRoute(builder: (builder)=>NearByStore(selectedList: selectedList)))
                      :Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => WheelsAndTyres2()));
                    },
                    child: Text( 'Ok',style: Style.button),
                  )
                ],
              ),
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
      DataColumn(label: Text(widget.service.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
      widget.cost==true?DataColumn(label: Text('Cost',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)):DataColumn(label: Text(''))
    ];
  }
  List<DataRow> _createRows() {
    return model.subServiceListByServiceId
        .mapIndexed((index, book) => DataRow(
        cells: [
          DataCell(Consumer<ServiceProvider>(
              builder: (context, model, child) => Text(model.subServiceListByServiceId[index].name))),
          widget.cost==true?DataCell(Consumer<ServiceProvider>(
              builder: (context, model, child) => Text(model.subServiceListByServiceId[index].costing))):DataCell(Text(''))
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