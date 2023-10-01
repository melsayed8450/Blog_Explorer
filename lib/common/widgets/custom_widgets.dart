import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class CustomWidgets {
  static GetSnackBar customSnackBar({required String content}) {
    return GetSnackBar(
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.black,
      messageText: Text(
        content,
        style: const TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    );
  }
}
