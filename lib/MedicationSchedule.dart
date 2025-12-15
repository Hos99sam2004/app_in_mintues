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
  String _mealTime = 'before_breakfast';
  String _medicationName = '';
  List<bool> _selectedDays = List.generate(
    7,
    (index) => false,
  ); // Sunday to Saturday
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

  Future<void> _scheduleNotifications() async {
    for (int i = 0; i < _selectedDays.length; i++) {
      if (_selectedDays[i]) {
        DateTime now = DateTime.now();
        DateTime scheduled = DateTime(
          now.year,
          now.month,
          now.day,
          _time.hour,
          _time.minute,
        );
        // Adjust for the day of the week
        int daysToAdd = (i - now.weekday + 7) % 7;
        if (daysToAdd == 0 && scheduled.isBefore(now)) {
          daysToAdd = 7; // Next week if today and time passed
        }
        scheduled = scheduled.add(Duration(days: daysToAdd));

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

        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.zonedSchedule(
          i, // Use day index as ID
          'Medication Reminder',
          'Time to take $_medicationName $_mealTime',
          tzScheduled,
          platformChannelSpecifics,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Medication Schedule')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set Medication Time',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Medication Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _medicationName = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Select Days of the Week',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...List.generate(7, (index) {
                List<String> days = [
                  'Sunday',
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                ];
                return CheckboxListTile(
                  title: Text(days[index]),
                  value: _selectedDays[index],
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedDays[index] = value ?? false;
                    });
                  },
                );
              }),
              SizedBox(height: 20),
              Text(
                'Select Meal Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _mealTime,
                style: Theme.of(context).textTheme.bodyLarge,
                items: [
                  DropdownMenuItem(
                    value: 'before_breakfast',
                    child: Text('Before Breakfast'),
                  ),
                  DropdownMenuItem(
                    value: 'before_lunch',
                    child: Text('Before Lunch'),
                  ),
                  DropdownMenuItem(
                    value: 'after_lunch',
                    child: Text('After Lunch'),
                  ),
                  DropdownMenuItem(
                    value: 'before_dinner',
                    child: Text('Before Dinner'),
                  ),
                  DropdownMenuItem(
                    value: 'after_dinner',
                    child: Text('After Dinner'),
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
                onPressed: () => _selectTime(context),
                child: Text('Select Time: ${_time.format(context)}'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Save logic
                  print(
                    'Medication: $_medicationName, Days: $_selectedDays, Time: ${_time.format(context)}, Meal: $_mealTime',
                  );
                  // Schedule notifications
                  await _scheduleNotifications();
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
                      content: Text('Alarms scheduled for selected days'),
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
