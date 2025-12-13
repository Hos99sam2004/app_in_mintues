import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class MedicationSchedule extends StatefulWidget {
  @override
  _MedicationScheduleState createState() => _MedicationScheduleState();
}

class _MedicationScheduleState extends State<MedicationSchedule> {
  TimeOfDay _time = TimeOfDay.now();
  String _mealTime = 'before';
  final AudioPlayer _player = AudioPlayer();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
      });
    }
  }

  Future<void> _scheduleNotification() async {
    DateTime now = DateTime.now();
    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      _time.hour,
      _time.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(Duration(days: 1));
    }

    tz.TZDateTime tzScheduled = tz.TZDateTime.from(scheduled, tz.local);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'medication_channel',
          'Medication Reminders',
          channelDescription: 'Reminders for medication times',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Medication Reminder',
      'Time to take your $_mealTime breakfast medication',
      tzScheduled,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Medication Schedule')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set Medication Time',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Select Time: ${_time.format(context)}'),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: _mealTime,
                style: Theme.of(context).textTheme.bodyLarge,
                items: [
                  DropdownMenuItem(
                    value: 'before',
                    child: Text('Before Breakfast'),
                  ),
                  DropdownMenuItem(
                    value: 'after',
                    child: Text('After Breakfast'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _mealTime = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Save logic
                  print('Time: ${_time.format(context)}, Meal: $_mealTime');
                  // Schedule notification
                  await _scheduleNotification();
                  // Play alarm sound for test
                  try {
                    await _player.play(
                      UrlSource(
                        'https://www.soundjay.com/misc/sounds/bell-ringing-05.wav',
                      ),
                    ); // Original bell sound
                  } catch (e) {
                    print('Error playing sound: $e');
                    // Fallback: show a snackbar or something
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Alarm sound played (simulated)')),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Alarm scheduled for ${_time.format(context)}',
                      ),
                    ),
                  );
                  // You can add save to shared preferences or database here
                },
                child: Text('Save and Test Alarm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
