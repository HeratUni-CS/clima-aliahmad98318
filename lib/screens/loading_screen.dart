import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var latitude;
  var longittude;
  @override
  void initState() {
        super.initState();
  // getlocation();
  getpermission();
  }

  GeolocatorPlatform geolocatorPlatform=GeolocatorPlatform.instance;
  LocationPermission? permission;



  void getlocation() async{
  Location location=Location();
  await location.getCurrentLocation();
  latitude =location.latitude;
  longittude =location.lognitude;
  NetworkHelper networkHelper=NetworkHelper("https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longittude&appid=$apiKey");
  var weatherData=await networkHelper.getData();
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


  @override
  Widget build(BuildContext context) {

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

// var id=decodedData['weather'][0]['id'];
// var temperature=decodedData['main']['temp'];
// var cityName=decodedData['name'];




