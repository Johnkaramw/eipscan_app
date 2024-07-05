// ignore_for_file: unused_local_variable

import 'package:eipscan_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:eipscan_app/Predict.dart';

class Medication {
  String name;
  List<DateTime> dateTimeList;

  Medication({required this.name, required this.dateTimeList});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dates':
          dateTimeList.map((dateTime) => dateTime.toIso8601String()).toList(),
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    List<DateTime> dateTimeList =
        (json['dates'] as List<dynamic>).map((dateString) {
      return DateTime.parse(dateString as String);
    }).toList();
    return Medication(name: json['name'], dateTimeList: dateTimeList);
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? email;
  String? password;

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 20.0),
                const Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome back!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 50.0),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: _textFieldDecoration(
                    hintText: 'Email',
                    icon: Icons.email,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: _textFieldDecoration(
                    hintText: 'Password',
                    icon: Icons.lock,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () => _showForgotPasswordDialog(context),
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final UserCredential userCredential =
                            await auth.signInWithEmailAndPassword(
                                email: email!, password: password!);
                        if (userCredential.user != null) {
                          _login(email!);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Firstpage()),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(e.message ?? "An error occurred")),
                        );
                      }
                    },
                    child: const Text("Login", style: TextStyle(fontSize: 20)),
                    style: _buttonStyle(),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpForm()),
                    );
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _textFieldDecoration(
      {required String hintText, required IconData icon}) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.deepOrange.shade800, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey.shade200,
      prefixIcon: Icon(icon, color: Color.fromRGBO(136, 83, 3, 1)),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      minimumSize: const Size(200, 60),
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.deepOrange;
          }
          return null;
        },
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? resetEmail;
        return AlertDialog(
          title: Text("Forgot Password"),
          content: TextField(
            onChanged: (value) {
              resetEmail = value;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Enter your email"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Send"),
              onPressed: () {
                if (resetEmail != null) {
                  _sendPasswordResetLink(resetEmail!);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendPasswordResetLink(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Password reset link has been sent to your email")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred. Please try again")),
      );
    }
  }

  void _login(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? medicationJsonList =
        prefs.getStringList('medications_$email');
    if (medicationJsonList != null) {
      setState(() {
        List<Medication> retrievedMedications = medicationJsonList
            .map((medicationJson) =>
                Medication.fromJson(jsonDecode(medicationJson)))
            .toList();
      });
    }
  }

  Future<void> _saveMedications(
      String email, List<Medication> medications) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> medicationJsonList = medications
        .map((medication) => jsonEncode(medication.toJson()))
        .toList();
    await prefs.setStringList('medications_$email', medicationJsonList);
  }
}
