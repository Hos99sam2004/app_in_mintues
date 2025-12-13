import 'package:flutter/material.dart';
import 'SettingsScreen.dart';
import 'MedicationSchedule.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    SettingsScreen(),
    HelpWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Welcome to Home Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicationSchedule()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class HelpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عن المشروع',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'هذا التطبيق هو تطبيق Flutter لجدولة الأدوية. يساعد المستخدمين في تتبع أوقات تناول الأدوية قبل أو بعد الوجبات.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'الميزات الرئيسية:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '- تسجيل الدخول الآمن\n'
                '- واجهة رئيسية مع تنقل بين الصفحات\n'
                '- إعدادات لتخصيص الألوان والسمات (فاتح/داكن)\n'
                '- جدولة الأدوية مع اختيار الوقت والوجبة\n'
                '- إشعار صوتي للمنبه\n'
                '- دعم عدة ألوان للواجهة',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'كيفية الاستخدام:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '1. قم بتسجيل الدخول.\n'
                '2. في الصفحة الرئيسية، اضغط على الزر العائم لإضافة جدولة دواء.\n'
                '3. اختر الوقت والوجبة، ثم احفظ لاختبار المنبه.\n'
                '4. في الإعدادات، غير السمة أو الألوان حسب الرغبة.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'تم تطوير هذا التطبيق باستخدام Flutter لضمان الأداء العالي والتكيف مع الأجهزة المختلفة.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
