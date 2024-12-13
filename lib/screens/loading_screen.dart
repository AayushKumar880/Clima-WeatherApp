import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    //calling the get location method on initialising the app
    getLocationData();
  }

  void getLocationData() async {
    //calling the getLocationWeather of WeatherModel class
    var weatherData = await WeatherModel().getLocationWeather();
    //navigate to locating screen as data is fetched from API(Application Programming Interface)
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocatingScreen(
          //passing the weather data to locating screen
          locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          //using SpinKit library for loader
          child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
