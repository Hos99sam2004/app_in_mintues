import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginScreen.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              // stops: [0.1, 0.4, 0.7, 0.9],
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF000000), // أسود
                Color(0xFF2B1B0E), // بني غامق (ذهبي مطفي)
                Color(0xFF6E4B1F), // ذهبي غامق
                Color(0xFFD4AF37), // ذهبي
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10, width: double.infinity),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[300],
                          image: DecorationImage(
                            image: AssetImage("assets/logoElkollaya.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "اعداد الطالبة : مريم جمال شرف ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                      image: DecorationImage(
                        image: AssetImage("assets/Maryam.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "مريم جمال شرف ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "تحت اشراف    \n دكتور : اسلام قنديل\n دكتور : صافى حسين \n دكتور : سما حجازى ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Container(
                  //   height: 250,
                  //   width: 300,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     color: Colors.grey[300],
                  //     image: DecorationImage(
                  //       image: AssetImage("assets/Aslam.jpg"),
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ),

                  // Image.asset("assets/اسلام.jpg"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
