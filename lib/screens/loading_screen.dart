import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  GeolocatorPlatform geolocatorPlatform=GeolocatorPlatform.instance;
  LocationPermission? permission;
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
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);


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
