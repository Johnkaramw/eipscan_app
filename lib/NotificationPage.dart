import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eipscan_app/SettingScreen.dart';
import 'package:eipscan_app/information_page.dart';
import 'package:eipscan_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        buttonTheme: ButtonThemeData(buttonColor: Colors.deepOrange),
      ),
      home: NotificationPage(),
    );
  }
}

class Medication {
  String name;
  List<TimeOfDay> times;

  Medication({required this.name, required this.times});
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<Medication> medications = [];
  String newMedicationName = '';
  List<TimeOfDay> newMedicationTimes = [];
  int notificationId = 0;

  @override
  void initState() {
    super.initState();
    _initNotifications();
    tz.initializeTimeZones();
  }

  Future<void> _initNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_stat_alarm.png');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification(
      int id, String medicationName, tz.TZDateTime scheduledDate) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Medication Reminder',
      'Time to take your medication: $medicationName',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'medication_channel',
          'Medication Reminders',
          channelDescription: 'Reminder for taking medication',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  void _addMedication() {
    if (newMedicationName.isNotEmpty && newMedicationTimes.isNotEmpty) {
      final medication = Medication(
          name: newMedicationName, times: List.from(newMedicationTimes));
      setState(() {
        medications.add(medication);
      });
      _scheduleMedications(medication);
      // Reset the fields
      newMedicationName = '';
      newMedicationTimes.clear();
    }
  }

  Future<void> _scheduleMedications(Medication medication) async {
    for (var time in medication.times) {
      final now = DateTime.now();
      var scheduledDate =
          DateTime(now.year, now.month, now.day, time.hour, time.minute);
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(Duration(days: 1));
      }
      final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);
      await _scheduleNotification(
          notificationId++, medication.name, tzScheduledDate);
    }
  }

  void _addMultipleTimes(BuildContext context) async {
    // This function opens the dialog to add multiple times
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Times'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: newMedicationTimes.length + 1, // For the add button
              itemBuilder: (context, index) {
                if (index == newMedicationTimes.length) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 40),
                    ),
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        setState(() {
                          newMedicationTimes.add(picked);
                        });
                      }
                    },
                    child: Text('Add Time'),
                  );
                }
                return ListTile(
                  title: Text('${newMedicationTimes[index].format(context)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        newMedicationTimes.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Reminder'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Medication Name'),
                onChanged: (value) {
                  newMedicationName = value;
                },
              ),
              SizedBox(height: 20),
              ...newMedicationTimes.map((time) => ListTile(
                    title: Text('${time.format(context)}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => setState(() {
                        newMedicationTimes.remove(time);
                      }),
                    ),
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 40),
                ),
                onPressed: () => _addMultipleTimes(context),
                child: Text('Add Times for Medication'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 40),
                ),
                onPressed: _addMedication,
                child: Text('Save Medication'),
              ),
              SizedBox(height: 20),
              Text(
                'Scheduled Medications:',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(medications[index].name),
                    subtitle: Text(
                      'Times: ${medications[index].times.map((time) => time.format(context)).join(', ')}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          medications.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
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
    );
  }
}
