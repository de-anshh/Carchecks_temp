import 'package:carcheck/util/color-resource.dart';
import 'package:carcheck/view/base_widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDialog extends StatelessWidget {
  final bool isFailed;
  final double rotateAngle;
  final IconData icon;
  final String title;
  final String description;
  MyDialog({this.isFailed = false, this.rotateAngle = 0, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            left: 0, right: 0, top: -55,
            child: Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: isFailed ? ColorResources.RED : ColorResources.GREEN, shape: BoxShape.circle),
              child: Transform.rotate(angle: rotateAngle, child: Icon(icon, size: 40, color: Colors.white)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
             children: [
              /* Text(title),
              SizedBox(height: 10),*/
               Text(description, style:TextStyle(
                 fontWeight: FontWeight.bold
               ),textAlign: TextAlign.center),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: CustomButton(buttonText: 'Ok', onTap: () => Navigator.pop(context)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
