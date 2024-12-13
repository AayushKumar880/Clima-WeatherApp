import 'package:geolocator/geolocator.dart';

class Location {
  //declaring lat and lon
  late double latitude;
  late double longitude;
  //setting for the location
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.low,
    distanceFilter: 100,
  );
  //method to get the current Lat and Lon
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
