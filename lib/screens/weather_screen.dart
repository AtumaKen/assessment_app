import 'package:assessment_app/widgets/location_input.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(child: Padding(
        padding:  EdgeInsets.only(top: deviceSize.padding.top * 3),
        child: LocationInput(),
      )),
    );
  }
}
