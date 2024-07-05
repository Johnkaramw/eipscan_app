import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eipscan_app/SettingScreen.dart';
import 'package:eipscan_app/accountPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'CameraWithRtmp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
// ignore: unused_import
import 'Welcome.dart';
import 'information_page.dart';
import 'SettingScreen.dart';
import 'NotificationPage.dart';
import 'onboarding_page_model.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initNotifications();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

Future<void> _initNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(), // تأكد من وجود OnboardingScreen
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingPageModel> onboardingPages = [
    OnboardingPageModel(
      imagePath: "assets/images/Health professional team-bro.png",
      title: "Episcan",
      description:
          "Begin your wellness journey today with Episcan, your trusted health partner.",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/Virus-bro.png",
      title: "Early Cancer Screening",
      description:
          "Discover early signs of cancer with simple steps through our screening feature.",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/Time management-pana.png",
      title: "Treatment Alarms",
      description:
          "Receive timely notifications for your treatment schedules, making sure you never miss a dose with our reminder system.",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/Questions-pana.png",
      title: "General Information",
      description:
          "Explore detailed information on 7 types of cancer, understanding the differences and specifics of each to empower your knowledge.",
    )
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 229, 216),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.10, // 10% of total height space from top
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return buildOnboardingPage(onboardingPages[index], context);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 50, top: 100),
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align button to the right
              children: [
                if (_currentPage != onboardingPages.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20), // Right padding for the "Next" button
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child:
                          Text('Next', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                if (_currentPage == onboardingPages.length - 1)
                  _buildButton(
                    label: 'Start Now',
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage(
      OnboardingPageModel pageModel, BuildContext context) {
    bool isTitleEpiscan = pageModel.title == "Episcan";
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            pageModel.imagePath,
            height: 300,
            width: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
          isTitleEpiscan
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(
                        255, 88, 88, 88), // Gold color for highlight
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "\"Episcan\"",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Text(
                  pageModel.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
          SizedBox(height: 15),
          Text(
            pageModel.description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      {required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 208, 120, 4),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      child: Text(label, style: TextStyle(fontSize: 16)),
    );
  }
}

class OnboardingPageModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPageModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 229, 216),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              Image.asset(
                'assets/images/1.png',
                width: 300.0,
                height: 250.0,
              ),
              const SizedBox(height: 30.0),
              const Text(
                'EIPSCAN',
                style: TextStyle(
                  color: Color.fromARGB(255, 231, 111, 13),
                  fontSize: 50,
                  fontFamily: 'Protest Revolution',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40.0),
              _buildButton(
                context: context,
                label: 'Login',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginForm()),
                ),
              ),
              SizedBox(height: 20.0),
              _buildButton(
                context: context,
                label: 'Sign up',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpForm()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      {required BuildContext context,
      required String label,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(
        label,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      minimumSize: const Size(200, 60),
      backgroundColor: Color.fromARGB(255, 208, 120, 4),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 10,
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.deepOrange[700];
          }
          return null;
        },
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          backgroundColor: Colors.deepOrange,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    SizedBox(height: 60.0),
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginFormFields(onLoginSuccess: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Firstpage()),
          );
        }),
      ),
    );
  }
}

// ignore: must_be_immutable
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20.0)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'UserName',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.grey.shade800, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.deepOrange.shade800, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        prefixIcon: const Icon(Icons.person,
                            color: Color.fromRGBO(136, 83, 3, 1)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.grey.shade800, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.deepOrange.shade800, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        prefixIcon: const Icon(Icons.email,
                            color: Color.fromRGBO(136, 83, 3, 1)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.grey.shade800, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.deepOrange.shade800, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        prefixIcon: const Icon(Icons.phone,
                            color: Color.fromRGBO(136, 83, 3, 1)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.grey.shade800, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.deepOrange.shade800, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        prefixIcon: const Icon(Icons.lock,
                            color: Color.fromRGBO(136, 83, 3, 1)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: Colors.grey.shade800, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.deepOrange.shade800, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        prefixIcon: const Icon(Icons.lock,
                            color: Color.fromRGBO(136, 83, 3, 1)),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
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
                            !email!.contains('@')) {
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
                            MaterialPageRoute(
                                builder: (context) => Firstpage()),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        minimumSize: const Size(200, 60),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ).copyWith(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.deepOrange;
                            return null; // Use the component's default.
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginForm()),
                        );
                      },
                      child: const Text(
                        'Login here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFormFields extends StatefulWidget {
  final Function onLoginSuccess;

  const LoginFormFields({Key? key, required this.onLoginSuccess})
      : super(key: key);

  @override
  _LoginFormFieldsState createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  String? email;
  String? password;

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                  _forgotPassword(context),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final UserCredential userCredential =
                            await auth.signInWithEmailAndPassword(
                                email: email!, password: password!);
                        if (userCredential.user != null) {
                          widget.onLoginSuccess();
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
                  const SizedBox(height: 20.0),
                  _signup(context),
                ],
              ),
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

  Widget _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () => _showForgotPasswordDialog(context),
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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

  Widget _signup(BuildContext context) {
    return GestureDetector(
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
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          children: <TextSpan>[
            TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class Firstpage extends StatefulWidget {
  const Firstpage({Key? key}) : super(key: key);

  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  int _currentIndex = 0;
  final List<String> imageUrls = [
    "https://media.istockphoto.com/id/1637354459/photo/ovarian-cancer-cells-closeup-view-3d-illustration.jpg?s=2048x2048&w=is&k=20&c=R9HEVewfbRfz4_VD8T-nKufPFEyENCuKar9IxSoMvXw=",
    "https://media.istockphoto.com/id/2135551600/photo/car-t-cell-therapy-in-non-hodgkin-lymphoma-closeup-view-3d-illustration.webp?s=2048x2048&w=is&k=20&c=1Sqa6eSxnPZOY8XgPmaLxVXfvOyAvUDO212QcxDanF0=",
    "https://media.istockphoto.com/id/1204174267/photo/virus-infected-blood-cells.jpg?s=2048x2048&w=is&k=20&c=dPAh_fIGeOAguPPxs5Pps2ou-zNQAwG39QZJuCp4CHc=",
    "https://media.istockphoto.com/id/522696027/photo/cancer-cell.jpg?s=2048x2048&w=is&k=20&c=kIGJ8K1H5iYIlFrJKmGtAEf2-LjyvA78XuU4goG4Cn8=",
  ];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % imageUrls.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 209, 207, 207),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              top: 50,
              right: 20,
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 221, 221, 221), // هنا
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome to EPISCAN!',
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    color: Color.fromARGB(136, 54, 54, 54),
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              pause: const Duration(milliseconds: 1000),
            ),
          ),
          Positioned(
            bottom: 170,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 120,
                  backgroundImage: NetworkImage(imageUrls[_currentIndex]),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        // Changed MaterialButton to ElevatedButton for better styling
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Choose image'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      OutlinedButton(
                                        onPressed: () {
                                          pickImageGallery();
                                        },
                                        child: const Text("Gallery"),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          "Take Image",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraWithRtmp(),
                            ),
                          );
                        },
                        child: Text(
                          "Camera",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ], // Closing the Stack widget's children list
      ), // Closing the Stack widget
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.info, size: 30, color: Colors.white),
          Icon(Icons.alarm, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        animationCurve: Curves.easeInOut,
        color: Color.fromARGB(135, 36, 36, 36),
        backgroundColor: Colors.white,
        onTap: (index) {
          // Handle tap events here
          print('Tapped on item $index');
          // You can navigate to different pages based on the index
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Firstpage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformationPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
              break;
          }
        },
      ),
    );
  }
}

void pickImageGallery() {}
