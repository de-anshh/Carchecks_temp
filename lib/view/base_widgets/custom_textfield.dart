import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carcheck/util/color-resource.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? lableText;
  final TextInputType textInputType;
  final int maxLine;
  final bool isPhoneNumber;
  final bool isValidator;
  final TextCapitalization capitalization;
  final IconData? iconData;
  final bool? obsecure;
  final bool? readOnly;
  final String? validatorMsg;

  CustomTextField({
    required this.controller,
    required this.hintText,
    this.lableText,
    required this.textInputType,
    this.maxLine = 1,
    this.validatorMsg,
    this.isPhoneNumber = false,
    this.isValidator = false,
    this.capitalization = TextCapitalization.none,
    this.iconData,
    this.obsecure,
    this.readOnly
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0,vertical: 15),
      padding: EdgeInsets.symmetric(vertical: 3,horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          lableText==''?SizedBox.shrink():Text(lableText??'',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return validatorMsg;
              }
              return null;
            },
            readOnly: readOnly==null ? false :true,
            decoration: InputDecoration(
               // prefixIcon: Icon(iconData),
                hintText: hintText,
            ),
            keyboardType: textInputType != null ? textInputType : TextInputType.text,
          ),
        ],
      ),
    );
  }
}

