import 'package:flutter/material.dart';
import 'information_page.dart'; // استيراد صفحة المعلومات
import 'SettingScreen.dart'; // استيراد صفحة الإعدادات
import 'NotificationPage.dart'; // استيراد صفحة الإشعارات

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IconPage(), // تحديد الصفحة الأولية
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 244, 192, 192),
      ),
      routes: {
        '/notifications': (context) =>
            MyHomePage(title: 'Notifications'), // صفحة الإشعارات
      },
    );
  }
}

class IconPage extends StatefulWidget {
  const IconPage({Key? key}) : super(key: key);

  @override
  _IconPageState createState() => _IconPageState();
}

class _IconPageState extends State<IconPage> {
  // تعريف الحالة الخاصة بالأيقونات
  Map<String, bool> _tapStates = {
    'Camera': false,
    'Information': false,
    'Notifications': false,
    'Settings': false,
  };

  // وظيفة تغيير حالة النقر
  void _toggleTapState(String label) {
    setState(() {
      _tapStates.updateAll((key, value) => _tapStates[key] = false);
      _tapStates[label] = true;

      if (label == 'Camera') {
        // هنا يمكنك وضع الكود الخاص بفتح الكاميرا
        // في هذا المثال، سنستخدم showDialog لعرض رسالة بسيطة
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Camera'),
              content: Text('Opening Camera...'), // رسالة توضيحية
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      } else if (label == 'Information') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InformationPage()),
        );
      } else if (label == 'Settings') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      } else if (label == 'Notifications') {
        Navigator.pushNamed(context, '/notifications');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      backgroundColor:
          const Color.fromARGB(255, 244, 192, 192), // الخلفية باللون المطلوب
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: IconCard(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    isTapped: _tapStates['Camera']!,
                    onTap: _toggleTapState,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: IconCard(
                    icon: Icons.medical_services,
                    label: 'Information',
                    isTapped: _tapStates['Information']!,
                    onTap: _toggleTapState,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: IconCard(
                    icon: Icons.notifications,
                    label: 'Notifications',
                    isTapped: _tapStates['Notifications']!,
                    onTap: _toggleTapState,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: IconCard(
                    icon: Icons.settings,
                    label: 'Settings',
                    isTapped: _tapStates['Settings']!,
                    onTap: _toggleTapState,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// بناء عنصر بطاقة الأيقونة
class IconCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isTapped;
  final void Function(String) onTap;

  const IconCard({
    required this.icon,
    required this.label,
    required this.isTapped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Card(
        elevation: isTapped ? 10 : 0,
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(isTapped ? 10 : 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isTapped ? Colors.pinkAccent : Colors.transparent,
              ),
              child: Icon(
                icon,
                size: 80,
                color: isTapped ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: isTapped ? Colors.pinkAccent : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
