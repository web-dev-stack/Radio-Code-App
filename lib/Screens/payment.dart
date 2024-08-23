

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:http_auth/http_auth.dart';


import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:radio_code/Screens/stripepayment_screen.dart';


import '../Utils/apiurl.dart';
import 'CodeReadyScreen.dart';

class Stripay {
// String api =
  //     "sk_test_51MrFvAHxcQb8RRwo8eca5sUsYCNtPfQn3SYVmatToaUZEgjUYEip2sgz32OjS5GqdH5MraJU4i1m3N3F0ArOAhyj00ua3ilXbi";
  String api =
      "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";
  pyinislize() {
    // Stripe.publishableKey =
    //     "pk_test_51MrFvAHxcQb8RRwog0Jcevgfoj7Y5wrlxDRa9LQ3VQEq6Y9gdkeQwIEEDVza4PP5zjHMmSWzGkZFEnGTK7n0jq4900XGakH9pz";
    //
    // Stripe.publishableKey =
    // "pk_live_51MrFvAHxcQb8RRwo3MIMnJmCty9hZ1zPIzO5sEA0yU1RLxSLM91MtrRN5HvfjM4I3u8S7z9H8BTHUjq8G46Si1Zy00H3W08DVX";
  }



  Map<String, dynamic>? paymentIntent;

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${api}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(response.body);
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  var gpay = PaymentSheetGooglePay(
      merchantCountryCode: "EUR", currencyCode: "EU", testEnv: true);

  makePayment(mainpagedata, BuildContext context, String serialno, String email,
      String? deviceno, String? date) async {
    var am = ((mainpagedata['amount'] * 100).toStringAsFixed(2));
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    int vm = double.parse(am.toString()).round();
    String ss = am.toString().replaceAll(regex, '');
    print("click $am $ss ");
    //STEP 1: Create Payment Intent
    paymentIntent = await createPaymentIntent(vm.toString(), 'EUR');

    //STEP 2: Initialize Payment Sheet
    await Stripe.instance
        .initPaymentSheet(

            paymentSheetParameters: SetupPaymentSheetParameters(customFlow: false,
                customerEphemeralKeySecret: paymentIntent!['ephemeralkey'],
                customerId: paymentIntent!['customer'],
                paymentIntentClientSecret: paymentIntent![
                    'client_secret'], //Gotten from payment intent
                style: ThemeMode.light,
                merchantDisplayName: 'amar',
                googlePay: gpay))
        .then((value) {});

    //STEP 3: Display Payment sheet
    return displayPaymentSheet(
        mainpagedata, context, serialno, email, deviceno, date);


  }

  displayPaymentSheet(mainpagedata, BuildContext context, String serialno,
      String email, String? deviceno, String? date) async {
    print("displayPaymentSheet $mainpagedata");

    await Stripe.instance.presentPaymentSheet().then((value) async {
      var request1 = await http.get(Uri.parse(
          'http://d83.cc:9488/logon/getPIN?api_key=71aaafecdb8f2f65f2bd0c06b3b1c585&sn=${serialno}'));
      print("displayPaymentSheet $request1");
      var radiocode;
      if (request1.body is int && request1.statusCode == 200) {
        radiocode = request1.body.toString();
      } else {
        radiocode = "Admin send Code you later";
      }
      // if (request1.statusCode == 200) {
      var headers = {'Accept': 'application/json'};
      var request = await http.get(
          Uri.parse(
              '${baseurl}/api/payorder?serial_no=${serialno}&car_model=${mainpagedata['title']}&email=${email}&amount=${mainpagedata['amount']}&radeocode=${radiocode}&deviceno=${deviceno.toString()}&date=${date.toString()}'),
          headers: headers);

      print("request234 ${request.body}");
      if (request.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodeReadyScreen(
              serialnumber: serialno,
              radio: radiocode,
              title: mainpagedata['title'],
            ),
          ),
        );
      } else {
        print(request.reasonPhrase);
      }
      // }

      // print("Payment Successfully");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CodeReadyScreen(
      //       serialnumber: serialno,
      //       radio: radiocode.toString(),
      //       title: mainpagedata['title'],
      //     ),
      //   ),
      // );
    });
  }

  googlepay(mainpagedata, BuildContext context, String serialno, String email,
      String? deviceno, String? date) async {
    var request1 = await http.get(Uri.parse(
        'http://d83.cc:9488/logon/getPIN?api_key=71aaafecdb8f2f65f2bd0c06b3b1c585&sn=${serialno}'));
    print("displayPaymentSheet $request1");
    var radiocode;
    if (request1.body is int && request1.statusCode == 200) {
      radiocode = request1.body.toString();
    } else {
      radiocode = "Admin send Code you later";
    }
    // if (request1.statusCode == 200) {
    var headers = {'Accept': 'application/json'};
    var request = await http.get(
        Uri.parse(
            '${baseurl}/api/payorder?serial_no=${serialno}&car_model=${mainpagedata['title']}&email=${email}&amount=${mainpagedata['amount']}&radeocode=${radiocode}&deviceno=${deviceno.toString()}&date=${date.toString()}'),
        headers: headers);

    print("request234 ${request.body}");
    if (request.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CodeReadyScreen(
            serialnumber: serialno,
            radio: radiocode,
            title: mainpagedata['title'],
          ),
        ),
      );
    } else {
      print(request.reasonPhrase);
    }
    // }

    print("Payment Successfully");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CodeReadyScreen(
          serialnumber: serialno,
          radio: radiocode.toString(),
          title: mainpagedata['title'],
        ),
      ),
    );
  }
}

class PaypalServices {


  getAccessToken() async {
    // String domain =
    //      "https://api.sandbox.paypal.com";
    String domain =  "https://api.paypal.com";
    // String childId = "AUYP_0igUQu4GY1gPk2vv163FhD87cL4Qb-Wrltw5UM4timBveT_G7MWBbuhHemK5bq6-BuJuZLesOKD"; // Sandbox
    // String secret = "EPsWbL9TWHuMSqNfOuoFqo6t5N7ZOOMNuBglu97rwg5_U4zkiPoKqZieKY6p9YrJNukg4U3fOrxhy0Id"; // Sandbox

    String childId = "ARouKdpH_gfNf0jAYjXkOLB6yD38jHKx6Wu3HM-HmcZhNwisKx551LgKBnEp9StvYxsKg35Wu6Mzvre7"; // production
    String secret = "EOYc6ItExot1LTjQHBd35YWAYxtQPmVvDx74IJZm5BjcYGCgwBThv-nCg1yKHxvNqhqms0GAx_lgZVU2"; // production

    try {
      var client = BasicAuthClient(childId, secret);
      var response = await client.post(
          Uri.parse("$domain/v1/oauth2/token?grant_type=client_credentials"));
      print("=====${response.body}");
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return {
          'error': false,
          'message': "Success",
          'token': body["access_token"]
        };
      } else {
        return {
          'error': true,
          'message': "Your PayPal credentials seems incorrect"
        };
      }
    } catch (e) {
      return {
        'error': true,
        'message': "Unable to proceed, check your internet connection."
      };
    }
  }

  Future<Map> createPaypalPayment(transactions, accessToken) async {
    String domain =  "https://api.paypal.com";
    try {
      var response = await http.post(Uri.parse("$domain/v1/payments/payment"),
          body: jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return {};
      } else {
        return body;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer $accessToken'
          });

      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return {'error': false, 'message': "Success", 'data': body};
      } else {
        return {
          'error': true,
          'message': "Payment inconclusive.",
          'data': body
        };
      }
    } catch (e) {
      return {'error': true, 'message': e, 'exception': true, 'data': null};
    }
  }


}

class StripePayment{

  createCustomer(String email,Map mainpagedata,BuildContext context,String rediocode,String date,String device) async {
    double am = ((mainpagedata['amount'] * 100));
    try {
      //Request body
      Map<String, dynamic> body = {
        'email': email,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/customers'),
        headers: {
          'Authorization': 'Bearer ${stripe_Secret_Key}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(response.body);

      if(response.statusCode == 200){
        var data = json.decode(response.body);
        createPaymentLink(data["id"],am.toInt().toString(),context,mainpagedata,email,rediocode,date,device);

      }
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }


  createPaymentLink(String customerId,String amount,BuildContext context,Map mainpagedata,String email,String rediocode,String date,String device) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'cancel_url': 'https://google.com',
        'success_url':'${payment_redirect_url}',
        'customer':customerId,
        'line_items[0][price_data][currency]':'eur',
        'line_items[0][price_data][product_data][name]':'------------',
        'line_items[0][price_data][unit_amount]':amount,
        'line_items[0][quantity]':'1',
        'mode':'payment',
        'payment_method_types[0]':'card',
        'phone_number_collection[enabled]':'false',
        'line_items[0][price_data][product_data][images][0]':'https://i.ibb.co/ZgRCfh8/icon.jpg'
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/checkout/sessions'),
        headers: {
          'Authorization': 'Bearer ${stripe_Secret_Key}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(response.body);

      if(response.statusCode == 200){
        var data = json.decode(response.body);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebhookPaymentScreen(
                mainPageData: mainpagedata,
                  radioCode: rediocode,
                  emailId: email,
                  date: date!,
                  deviceNO: device!,
                  url: data["url"],
                ),
              ),
            );

      }
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }


}