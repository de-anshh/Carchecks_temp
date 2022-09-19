import 'dart:ui';

import 'package:carcheck/util/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carcheck/util/color-resource.dart';


class RegistrationTextFeild extends StatelessWidget {
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

  RegistrationTextFeild({
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
     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMsg;
          }
          return null;
        },
          readOnly: readOnly != null ? readOnly! : false,
          decoration: InputDecoration(
              labelText: hintText,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: const OutlineInputBorder())),
    );
  }
}

