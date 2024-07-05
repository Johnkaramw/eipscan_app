import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eipscan_app/NotificationPage.dart';
import 'package:eipscan_app/accountPage.dart';
import 'package:eipscan_app/information_page.dart';
import 'package:eipscan_app/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'accountPage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _selectedLanguage = 'English'; // Default language
  bool _isDarkModeEnabled = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkModeEnabled = !_isDarkModeEnabled;
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Log Out"),
          content: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete Account"),
          content: Text(
              "Are you sure you want to delete your account? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.currentUser!.delete();

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Account deleted successfully.'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'An error occurred while deleting your account.'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _changeLanguage(String? newValue) {
    if (newValue != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Language Change"),
            content: Text("Are you sure you want to change the language?"),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Row(
                  children: [
                    Icon(Icons.language,
                        color: Colors.white), // Changed language icon color
                    SizedBox(
                        width: 5), // Added some space between icon and text
                    Text("Change", style: TextStyle(color: Colors.white)),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                  // Implement language change here
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ar', 'EG'), // Adding Arabic locale
      ],
      localizationsDelegates: [
        //   GlobalMaterialLocalizations.delegate,
        //// GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(_selectedLanguage!.toLowerCase(), ''),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon:
                  Icon(_isDarkModeEnabled ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 40)), // Set button size
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account Settings',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Icon(Icons.account_circle,
                        color: Colors.white), // Changed account icon color
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Change Language"),
                      content: DropdownButton<String>(
                        value: _selectedLanguage,
                        onChanged: (String? newValue) {
                          _changeLanguage(newValue);
                        },
                        items: <String>[
                          'English',
                          'Arabic'
                        ] // Adding Arabic language
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 20)),
                          );
                        }).toList(),
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 40)), // Set button size
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Change Language',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Icon(Icons.language,
                        color: Colors.white), // Changed language icon color
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _logout,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 40)), // Set button size
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Log Out',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Icon(Icons.logout,
                        color: Colors.white), // Changed logout icon color
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _deleteAccount,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 40)), // Set button size
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delete Account',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    Icon(Icons.delete,
                        color: Colors.white), // Changed delete icon color
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: 3,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.info, size: 30, color: Colors.white),
            Icon(Icons.alarm, size: 30, color: Colors.white),
            Icon(Icons.settings, size: 30, color: Colors.white),
          ],
          animationCurve: Curves.easeInOut,
          color: Colors.grey,
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
      ),
    );
  }
}
