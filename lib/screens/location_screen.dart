import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocatingScreen extends StatefulWidget {
  const LocatingScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  State<LocatingScreen> createState() => _LocatingScreenState();
}

class _LocatingScreenState extends State<LocatingScreen> {
  //declaring the variables that we'll need
  late double temperature;
  late int condition;
  late String city;
  late String weatherIcon;
  late String weatherMessage;

  //updating the ui as soon as data fetched by calling updateUI in init method
  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  WeatherModel weatherModel = WeatherModel();

  void updateUi(dynamic weatherData) {
    setState(() {
      temperature = weatherData['main']['temp'];
      condition = weatherData['weather'][0]['id'];
      city = weatherData['name'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUi(weatherData);
                    },
                    icon: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        updateUi(weatherData);
                      }
                    },
                    icon: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      //temperature used here
                      '${temperature.toInt()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      //condition used here
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  //cityName is used here
                  weatherMessage,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
