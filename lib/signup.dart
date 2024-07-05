import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Predict.dart';
import 'Login.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? email;
  String? username;
  String? phone;
  String? password;
  String? confirmPassword;

  final auth = FirebaseAuth.instance;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  bool isPhoneValid(String phone) {
    Pattern pattern = r'^(010|011|012|015)[0-9]{8}$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(phone);
  }

  bool isNameValid(String name) {
    Pattern pattern = r'^[a-zA-Z]+([\ -][a-zA-Z ])?[a-zA-Z]*$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(name);
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
                const SizedBox(height: 10.0),
                const Text(
                  "Sign up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Create your account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    username = value;
                  },
                  decoration: _textFieldDecoration(
                    hintText: 'UserName',
                    icon: Icons.person,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: _textFieldDecoration(
                    hintText: 'Email',
                    icon: Icons.email,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) {
                    phone = value;
                  },
                  decoration: _textFieldDecoration(
                    hintText: 'Phone',
                    icon: Icons.phone,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: _textFieldDecoration(
                    hintText: 'Password',
                    icon: Icons.lock,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  decoration: _textFieldDecoration(
                    hintText: 'Confirm Password',
                    icon: Icons.lock,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (username == null ||
                          phone == null ||
                          email == null ||
                          password == null ||
                          confirmPassword == null ||
                          username!.isEmpty ||
                          phone!.isEmpty ||
                          email!.isEmpty ||
                          password!.isEmpty ||
                          confirmPassword!.isEmpty ||
                          !isEmailValid(email!)) {
                        print("Please enter a valid email and password");
                        return;
                      }
                      if (password != confirmPassword) {
                        print("Passwords do not match");
                        return;
                      }
                      try {
                        var userCredential =
                            await auth.createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                        print("User registered: ${userCredential.user}");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Firstpage()),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      minimumSize: const Size(200, 50),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginForm()),
                          );
                        },
                        child: const Text(
                          'Login here',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
