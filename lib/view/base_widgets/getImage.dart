
import 'package:flutter/material.dart';

getImage(String src) {
  return src == "" ?
  Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[100],
          image: new DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/1.jpg')
          )
      ))
      :
  Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(
                  src)
          )
      ));
}