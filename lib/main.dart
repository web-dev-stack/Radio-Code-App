import 'package:flutter/material.dart';
import 'package:radio_code/Screens/SplashScreen.dart';
// main.dart
import 'package:flutter_stripe/flutter_stripe.dart';

import 'Utils/apiurl.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripe_Publishable_Key;
   await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
