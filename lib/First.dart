import 'package:eipscan_app/Login.dart';
import 'package:eipscan_app/signup.dart';
import 'package:flutter/material.dart';

class first extends StatelessWidget {
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
