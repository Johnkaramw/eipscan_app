import 'package:flutter/material.dart';

class AppAlerts {
  static const String msgMedicationFieldIsEmpty =
      'Please enter the name of the medication to complete the reminder.';
  static const String msgReminderDatePassed =
      'The selected reminder date has passed. Please add a valid date.';
  static customSnackBar({
    required BuildContext context,
    required String msg,
  }) {
    SnackBar sB = SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.9),
      ),
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.red,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(sB);
  }
}
