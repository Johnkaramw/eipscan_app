import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eipscan_app/InformationDises.dart';
import 'package:eipscan_app/NotificationPage.dart';
import 'package:eipscan_app/SettingScreen.dart';
import 'Predict.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disease Information"),
        backgroundColor: Color.fromARGB(255, 209, 207, 207),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 28, 27, 27),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset(
                  'assets/images/4c91e0f4-306b-4969-a323-2ec413da032c.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            customButton(context, 'Melanoma'),
            customButton(context, 'Melanocytes'),
            customButton(context, 'Dermatofibroma'),
            customButton(context, 'Actinic keratosis'),
            customButton(context, 'Vascular lesions'),
            customButton(context, 'Basal cell carcinoma'),
            customButton(context, 'Benign keratosis '),
            customButton(context, 'Mycosis Fungoides'),
            customButton(context, 'Squamous Cell Carcinoma'),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.info, size: 30, color: Colors.white),
          Icon(Icons.alarm, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        animationCurve: Curves.easeInOut,
        color: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          print('Tapped on item $index');

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

Widget customButton(BuildContext context, String title) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    height: 40,
    margin: const EdgeInsets.only(bottom: 10),
    child: ElevatedButton(
      onPressed: () {
        if (title == 'Benign keratosis ') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => KeratosisisesPage()));
        } else if (title == 'Melanocytes') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Melanocytes')));
        } else if (title == 'Melanoma') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MelanomaPage()));
        } else if (title == 'Basal cell carcinoma') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BasalCellCarcinomaPage()));
        } else if (title == 'Vascular lesions') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => VascularlesionsPage()));
        } else if (title == 'Dermatofibroma') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DermatofibromaPage()));
        } else if (title == 'Actinic keratosis') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ActinicKeratosisPage()));
        } else if (title == 'Squamous Cell Carcinoma') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SquamousCellCarcinoma()));
        } else if (title == 'Mycosis Fungoides') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MycosisFungoides()));
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Adjust padding for centering
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold), // Adjust font size if necessary
        ),
      ),
    ),
  );
}
