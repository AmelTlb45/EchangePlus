
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg){

Fluttertoast.showToast(
              msg:msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: const Color.fromARGB(255, 169, 77, 70),
              textColor: Colors.white,
              fontSize: 16.0);}