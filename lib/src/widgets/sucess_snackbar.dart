import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successSnackBar({String title, String message}){

  Get.snackbar(
    title,
    message,
    backgroundColor: Colors.green,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    duration: Duration(seconds: 4),
  );

}