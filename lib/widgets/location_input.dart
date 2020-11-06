import 'package:assessment_app/screens/weather_detail_screen.dart';
import 'package:assessment_app/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  WeatherService _weatherService = WeatherService();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  Future<void> _getWeatherAtLocation() async {
    final locationData = await Location().getLocation();
    _weatherService.getWeatherReport(
        locationData.latitude, locationData.longitude);
  }

  Future<void> _getWithLongAndLat(long, lat) async {
    _weatherService.getWeatherReport(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.location_on,
              ),
              label: Text('Weather at Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                _getWeatherAtLocation();
              },
            ),
          ],
        ),
        Container(
          width: deviceSize.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  controller: _longitudeController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Longitude",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: deviceSize.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  controller: _latitudeController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Latitude",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 50),
          child: FlatButton(
            child: Text(
              "Go",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.end,
            ),
            onPressed: () async {
              _weatherService
                  .getWeatherReport(
                      _latitudeController.text, _longitudeController.text)
                  .then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherDetailScreen(),
                      )));
            },
          ),
        ),
      ],
    );
  }
}
