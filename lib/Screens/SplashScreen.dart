import 'dart:async';
import 'dart:convert';
import '../modal/carmodal.dart';
import 'RadioCodeGeneratorScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Utils/apiurl.dart';
import 'package:radio_code/Screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  List brand=[];
  Carmodal? brands;
  @override
  void initState() {
    getcar();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('images/ic_splash.png'),
          ),
        ),
      ),
    );
  }

  Future<Carmodal?>  getcar()async{
    print("apicall");
    var headers = {
      'Accept': 'application/json'
    };
    var request = await http.get(Uri.parse('${baseurl}/api/car-models'),
      headers: headers,
    );


    if (request.statusCode == 200) {
      var res=json.decode(request.body);
      brand=res['data'];
      // setState(() {
      //   isLoading = false;
      // });
      if(brand.isNotEmpty){
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RadioCodeGeneratorScreen(
                id: brand[0]['id'].toString(),
                amount: double.parse(brand[0]['amount'].toString()),
                title: brand[0]['title'],),
            ),
          );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HomeScreen(),
          //   ),
          // );
        });
      }

      print("object ${brand} ${request.statusCode}");
    }
    else {
      setState(() {
        isLoading = false;
      });
      print(request.reasonPhrase);
    }

  }
}
