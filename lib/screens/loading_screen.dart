import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
        super.initState();
  // getlocation();
  getpermission();
  }

  GeolocatorPlatform geolocatorPlatform=GeolocatorPlatform.instance;
  LocationPermission? permission;
  void getData() async{
   http.Response response=await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=23a7ac21679d175a2e04fdc21a96b3c4"));
   if(response.statusCode==200){
     String data=response.body;

     var decodedData=jsonDecode(data);
     var id=decodedData['weather'][0]['id'];
     var temperature=decodedData['main']['temp'];
     var cityName=decodedData['name'];
     print(id);
     print(temperature);
     print(cityName);

   }else{
     print(response.statusCode);
   }
  }
  void getpermission() async{
  permission=await geolocatorPlatform.checkPermission();
  if(permission==LocationPermission.denied){
    print('permission denied');
    permission=await geolocatorPlatform.requestPermission();
    if(permission!=LocationPermission.denied){
      if(permission==LocationPermission.denied){
        print('permission permanently denied , please provide to the permission app for devise settings');
      }else{
        print('permission granted');
        getlocation();
      }
    }else{
      print('user denied the request');
    }
  }else{
    getlocation();
      }

  }

  void getlocation() async{
  Location location=Location();
  await location.getCurrentLocation();
  print(location.latitude);
  print(location.lognitude);

  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            getpermission();
            //Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
