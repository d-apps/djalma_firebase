import 'package:flutter/material.dart';
import 'package:get/get.dart';

void warningSnackBar({String title, String message}){

  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.orangeAccent,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    duration: Duration(seconds: 4),
  );

}