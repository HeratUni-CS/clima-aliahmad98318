import 'package:geolocator/geolocator.dart';

class Location{
  double? latitude,lognitude;
 Future<void> getCurrentLocation() async{
   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
   latitude=position.latitude;
   lognitude=position.longitude;

 }
}