import 'file:///C:/Users/ASUS/AndroidStudioProjects/assessment_app/lib/screens/terrr.dart';
import 'package:assessment_app/screens/weather_screen.dart';
import 'package:assessment_app/widgets/location_input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF4A6572)
      ),
      home: WeatherScreen(),
    );
  }
}



