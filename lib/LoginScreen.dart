import 'package:flutter/material.dart';
import 'MainScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color.fromARGB(255, 2, 2, 2),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000), // أسود
              Color(0xFF2B1B0E), // بني غامق (ذهبي مطفي)
              Color(0xFF6E4B1F), // ذهبي غامق
              Color(0xFFD4AF37), // ذهبي
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image maryam from assets
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/Maryam.jpg'),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add login logic here
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  // For now, just print
                  print('Username: $username, Password: $password');
                  // Navigate to MainScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
