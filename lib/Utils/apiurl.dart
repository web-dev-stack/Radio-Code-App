

import 'dart:convert';
import 'dart:math';

String baseurl="https://vw-codes.co.uk/";
String payment_redirect_url="https://vw-codes.co.uk/login";
String auto_code_generator_url="http://d83.cc:9488/logon/getPIN?api_key=5dc1702fb3e91de75239c0bb235596c7&sn=";

// LIVE PUBLISHABLE KEY
String stripe_Publishable_Key="pk_live_51MrFvAHxcQb8RRwo3MIMnJmCty9hZ1zPIzO5sEA0yU1RLxSLM91MtrRN5HvfjM4I3u8S7z9H8BTHUjq8G46Si1Zy00H3W08DVX";
String stripe_Secret_Key="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";

// TESTING PUBLISHABLE KEY
// String stripe_Publishable_Key="pk_test_51MrFvAHxcQb8RRwog0Jcevgfoj7Y5wrlxDRa9LQ3VQEq6Y9gdkeQwIEEDVza4PP5zjHMmSWzGkZFEnGTK7n0jq4900XGakH9pz";
// String stripe_Secret_Key="sk_test_51MrFvAHxcQb8RRwo8eca5sUsYCNtPfQn3SYVmatToaUZEgjUYEip2sgz32OjS5GqdH5MraJU4i1m3N3F0ArOAhyj00ua3ilXbi";


String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) =>  random.nextInt(255));
  return base64UrlEncode(values);
}