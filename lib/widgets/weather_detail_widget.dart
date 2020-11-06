import 'package:assessment_app/model/coordinates_model.dart';
import 'package:assessment_app/model/weather_detail_model.dart';
import 'package:assessment_app/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class WeatherDetailWidget extends StatefulWidget {
  @override
  _WeatherDetailWidgetState createState() => _WeatherDetailWidgetState();
}

class _WeatherDetailWidgetState extends State<WeatherDetailWidget> {
  String date = '';

  var bg = 'assets/bg/clearday.png';

  String iconc = 'assets/weathercons/rain.png';

  var desc = "";

  var city = "";

  var weatherx;

  int humidity = 0;

  int pressure = 0;

  int temp = 0;

  double humidity2 = 0;

  double pressure2 = 0;

  double windspeed = 0, windspeed2 = 0;

  WeatherService _weatherService = WeatherService();
  CoordinatesModel _coordinatesModel;
  WeatherDetailModel _weatherDetailData;

  Future<void> _getWeatherAtLocation() async {
    final locationData = await Location().getLocation();
    _coordinatesModel = CoordinatesModel(
        long: locationData.longitude.toString(),
        lat: locationData.latitude.toString());
    _weatherService
        .getWeatherReport(_coordinatesModel.lat, _coordinatesModel.long)
        .then((value) => _weatherDetailData = value);
  }

  bool _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    super.initState();
    _getWeatherAtLocation().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    // setBg();
    // _loadWeatherData();
  }

  // void _loadWeatherData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String response = prefs.getString('_weatherData');
  //   print(prefs.getString('_weatherData') ?? "ERROR");
  //
  //   int i = 0;
  //   List<Weather> list = List();
  //
  //   Map dataMap = jsonDecode(response);
  //   var d = WeatherData.fromJson(dataMap);
  //
  //   list = d.weather;
  //
  //   setState(() {
  //     temp = d.main.temp;
  //     pressure = d.main.pressure;
  //     pressure2 = pressure / 500;
  //
  //     humidity = d.main.humidity;
  //     humidity2 = humidity / 100;
  //
  //     windspeed = d.wind.speed;
  //     windspeed2 = windspeed / 10;
  //
  //     DateTime now = new DateTime.now();
  //     DateTime dated = new DateTime(now.year, now.month, now.day);
  //
  //     date =
  //     "${dated.hour}:${dated.minute} am - ${dated.weekday}, ${dated.day} ${dated.month} ${dated.year} ";
  //   });
  //   print(bg);
  //
  //   // weatherx = c.main;
  // }

  // void setBg() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String response = prefs.getString('_weatherData');
  //   print(prefs.getString('_weatherData') ?? "ERROR");
  //
  //   int i = 0;
  //   List<Weather> list = List();
  //
  //   Map dataMap = jsonDecode(response);
  //   var d = WeatherData.fromJson(dataMap);
  //
  //   list = d.weather;
  //   setState(() {
  //     bg = "";
  //     desc = list[i].main;
  //     int a = d.sys.sunrise;
  //     int b = d.sys.sunset;
  //     var night = false;
  //
  //     if (list[i].main.toLowerCase().contains("rain") || list[i].main.toLowerCase().contains("drizzle")) {
  //       bg = 'assets/bg/rain.png';
  //       iconc = 'assets/weathercons/rain.png';
  //     } else if (list[i].main.toLowerCase().contains("thunder")) {
  //       bg = 'assets/bg/thunder.png';
  //       iconc = 'assets/weathercons/thunder.png';
  //     } else if (list[i].main.toLowerCase().contains("haze")) {
  //       bg = 'assets/bg/fog.png';
  //       iconc = 'assets/weathercons/fog.png';
  //     } else if (list[i].main.toLowerCase().contains("day")) {
  //       bg = 'assets/bg/clearday.png';
  //       iconc = 'assets/weathercons/clearsky.png';
  //     } else if (list[i].main.toLowerCase().contains("snow") || temp < 0) {
  //       bg = 'assets/bg/snow.png';
  //       iconc = 'assets/weathercons/snow.png';
  //     } else if (list[i].main.toLowerCase().contains("wind")) {
  //       bg = 'assets/bg/wind.png';
  //       iconc = 'assets/weathercons/wind.png';
  //     }
  //
  //     if (a > b && temp > 40) {
  //       bg = 'assets/bg/sunny.png';
  //       iconc = 'assets/weathercons/sunny.png';
  //     }
  //
  //     /*   if (list[i].main.toLowerCase().contains("night") || a < b) {
  //           bg = 'assets/bg/night.png';
  //           night = true;
  //           iconc = 'assets/weathercons/cloudy_night.png';
  //         }
  //
  //         if (list[i].main.toLowerCase().contains("cloud") && a < b) {
  //           bg = 'assets/bg/night.png';
  //           night = true;
  //           iconc = 'assets/weathercons/cloudy_night.png';
  //         }
  //    */
  //     if (list[i].main.toLowerCase().contains("cloud") || a > b) {
  //       bg = 'assets/bg/cloud.png';
  //       iconc = 'assets/weathercons/cloud.png';
  //     }
  //     city = d.name;
  //     String m = "am";
  //
  //     if (night) {
  //       m = "pm";
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final dots = Hero(
      tag: 'hero',
      child: Image.asset('assets/icons/dots.png', scale: 3),
    );

    final icon = Hero(
      tag: 'hero',
      child: Image.asset(iconc, scale: 4),
    );

    final menu = Hero(
      tag: 'hero',
      child: Image.asset('assets/icons/menu.png', scale: 3.7),
    );

    final line = Hero(
      tag: 'hero',
      child: Image.asset('assets/icons/line.png', scale: 3.7),
    );

    final wind = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: windspeed2,
    );
    final pressurec = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: pressure2,
    );
    final humidityc = LinearProgressIndicator(
      backgroundColor: Colors.white24,
      value: humidity2,
    );

    return _isLoading
        ? CircularProgressIndicator()
        : Material(
            type: MaterialType.transparency,
            child: Stack(
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage(bg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            menu,
                            SizedBox(width: 20),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            dots,
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(children: <Widget>[
                              Text(
                                city,
                                style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(height: 9),
                                Text(date,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(height: 68),
                                Text(temp.toString() + "º",
                                    style: TextStyle(
                                      fontSize: 72,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(width: 10),
                            icon,
                            SizedBox(width: 9),
                            Text(desc,
                                style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                SizedBox(height: 54),
                                line,
                                SizedBox(height: 20),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text("Wind",
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 12),
                                          Text(windspeed.toString(),
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 10),
                                          Text("km/h",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 7),
                                          SizedBox(
                                            height: 2,
                                            width: 80,
                                            child: wind,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text("Pressure",
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 12),
                                          Text(pressure.toString(),
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 10),
                                          Text("kPa",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 7),
                                          SizedBox(
                                            height: 2,
                                            width: 80,
                                            child: pressurec,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text("Humidity",
                                              style: TextStyle(
                                                fontSize: 9,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 12),
                                          Text(humidity.toString(),
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 10),
                                          Text("%",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              )),
                                          SizedBox(height: 7),
                                          SizedBox(
                                            height: 2,
                                            width: 80,
                                            child: humidityc,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}
