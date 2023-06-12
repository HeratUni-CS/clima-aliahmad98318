import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loadingWadget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const[
            SpinKitPulse(
              size: 10,
              color:KlightColor,
            ),
            SizedBox(height: 10,),
            Text('fetching data...',style: TextStyle(fontSize: 20,color:KMidlightColor),),
          ],
        ),
      ),
    );
  }
}
