import 'dart:ui';

import 'package:carcheck/model/garage_model.dart';
import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:carcheck/view/screens/customer/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'wheels_tyres_1.dart';
import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class ChooseDate extends StatefulWidget {
  Garage? garage;
  String? notes;
  ChooseDate({this.garage,this.notes});

  @override
  _ChooseDateState createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> {

  DateTime? selectedDay;
  String? time;
  List <CleanCalendarEvent>? selectedEvent;

  List<ChooseTime> timeList = [
    ChooseTime("10:30 PM", false),
    ChooseTime("12:00 PM", true),
    ChooseTime("01:30 PM", false),
    ChooseTime("03:00 PM", false),
    ChooseTime("05:30 PM", false),
  ];



  final Map<DateTime,List<CleanCalendarEvent>> events = {
 /*   DateTime (DateTime.now().year,DateTime.now().month,DateTime.now().day):
    [
      CleanCalendarEvent('Event A',
          startTime: DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
          endTime:  DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
          description: 'A special event',
          color: Colors.blue),
    ],

    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
    [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],*/
  };

  void _handleData(date){
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }
  @override
  void initState() {
    // TODO: implement initState
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
      return Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Container(
                color: ColorResources.PRIMARY_COLOR,
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Text('Choose Date And Time',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                    Container(
                      height: 355,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10,30,10,5),
                        child: Calendar(
                          startOnMonday: true,
                          selectedColor: Colors.blue,
                          todayColor: Colors.red,
                         /* eventColor: Colors.green,
                          eventDoneColor: Colors.amber,*/
                          bottomBarColor: Colors.deepOrange,
                          onRangeSelected: (range) {
                            print('selected Day ${range.from},${range.to}');
                          },
                          onDateSelected: (date){
                            return _handleData(date);
                          },
                          events: events,
                          isExpanded: true,
                          dayOfWeekStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          bottomBarTextStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          hideBottomBar: false,
                          hideArrows: false,
                          weekDays: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                timeList[index].isSelected = !timeList[index].isSelected;
                                time = timeList[index].toString();
                                timeList.forEach((element) {
                                  timeList[index].isSelected == false;
                                });
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: timeList[index].isSelected?Colors.green[300]:Colors.white24
                              ),
                              child: Text(timeList[index].time,style: TextStyle(color: Colors.white,fontSize: 20),),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),

              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:  ClipPath(
                clipper: ProsteBezierCurve(
                  position: ClipPosition.top,
                  list: [
                    BezierCurveSection(
                      start: Offset(screenWidth, 0),
                      top: Offset(screenWidth / 2, 30),
                      end: Offset(0, 0),
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  height: 100,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: CustomButton(
                  buttonText: "Continue",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Wallet(garage: widget.garage,date: selectedDay.toString(),time:time,notes: widget.notes,)));
                  },
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class ChooseTime{
  String time;
  bool isSelected;

  ChooseTime(this.time, this.isSelected);
}
