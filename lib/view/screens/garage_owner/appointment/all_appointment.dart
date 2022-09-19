import 'package:carcheck/locator.dart';
import 'package:carcheck/provider/auth_provider.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/getImage.dart';
import 'package:carcheck/view/screens/customer/garage/garage_dashboard.dart';
import 'package:carcheck/view/screens/garage_owner/appointment/appointment_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carcheck/provider/appointment_provider.dart';
import '../../../base_widgets/custom_appbar.dart';
import 'package:provider/provider.dart';
class AllAppointment extends StatefulWidget {
  List<Appointment> appointmentList;
  String service_name;

//  MaterialColor color;
  AllAppointment(this.appointmentList,  this.service_name);

  @override
  _AllAppointmentState createState() => _AllAppointmentState();
}

class _AllAppointmentState extends State<AllAppointment> {
  AppointmentProvider appointmentProvider = locator<AppointmentProvider>();
  AuthProvider authProvider = locator<AuthProvider>();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController regNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isSelected = false,isSelectedCustomer = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    appointmentProvider.getAppointmentByGarageId(1);
    return Scaffold(
      appBar: CustomAppBarWidget(context,_scaffoldKey,widget.service_name),
      body:  Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Appointment Notifications",style: TextStyle(fontSize: 20),),
                SizedBox(height: 16,),
                getAppointmentList(),
              ],
            ),
          ),


    );
  }

  getAppointmentList() {
    return Expanded(
     // height: MediaQuery.of(context).size.height-120,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.appointmentList.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (builder) => AppointmentDetails(widget.appointmentList[index])));
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: widget.appointmentList[index].color),
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListTile(
                leading: getImage(''),
                title: Text( widget.appointmentList[index].name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( widget.appointmentList[index].date),
                    SizedBox(height: 7,),
                    Container(
                      height: 25,
                      child:ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (builder) => AppointmentDetails(widget.appointmentList[index])));
                        },
                        style: ElevatedButton.styleFrom(
                          onPrimary: ColorResources.BUTTON_COLOR,
                          primary:  widget.appointmentList[index].color,
                          elevation: 3,
                         // side: BorderSide(color: Colors.red, width: 1.5),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                          child: Text( widget.appointmentList[index].status,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white
                              )),
                        ),
                      )

                    )
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_down_outlined),
              ),
            ),
          );
        }),
    );
  }
}
