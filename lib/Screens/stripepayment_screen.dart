import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:radio_code/Screens/payment.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/apiurl.dart';
import 'CodeReadyScreen.dart';
import 'after_payment_pending.dart';


class WebhookPaymentScreen extends StatefulWidget {
  final  Map mainPageData;
  final  String radioCode;
  final  String date;
  final  String deviceNO;
  final  String emailId;
  final String url;
 const WebhookPaymentScreen({required this.mainPageData,required this.radioCode,required this.date,required this.deviceNO,
    required this.emailId,required this.url
  });

  @override
  _WebhookPaymentScreenState createState() => _WebhookPaymentScreenState();
}

class _WebhookPaymentScreenState extends State<WebhookPaymentScreen> {
  CardFieldInputDetails? _card;
  String _email = 'email@stripe.com';
  bool? _saveCard = false;

  bool isLoading = false;

  String urls = "https://checkout.stripe.com/c/pay/cs_test_a1iCttRcFp1xOimv0SczC8N6frSIKEyMcGnJBVJU9VNS15BIJGDE1CDpwg#fidkdWxOYHwnPyd1blpxYHZxWjA0SHdDc0RNfWZUZz1XV3JqYjVPZmBzYmNqbzJcMHJ3aX1BV2Q8SVQ2U1RAdDNcPGJhbmBUckxAQEFTf2QxVVUwf29NSGhWUn9Cbl9DQGtCUU4yazVvdDE8NTVdQmRuTTx1fycpJ2N3amhWYHdzYHcnP3F3cGApJ2lkfGpwcVF8dWAnPyd2bGtiaWBabHFgaCcpJ2BrZGdpYFVpZGZgbWppYWB3dic%2FcXdwYHgl";

  WebViewController webViewController = WebViewController();
  //
  // String api =
  //     "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";
  //
  pyinislize() async{
    Stripe.publishableKey =
        "pk_test_51MrFvAHxcQb8RRwog0Jcevgfoj7Y5wrlxDRa9LQ3VQEq6Y9gdkeQwIEEDVza4PP5zjHMmSWzGkZFEnGTK7n0jq4900XGakH9pz";



    // Stripe.publishableKey =
    // "pk_live_51MrFvAHxcQb8RRwo3MIMnJmCty9hZ1zPIzO5sEA0yU1RLxSLM91MtrRN5HvfjM4I3u8S7z9H8BTHUjq8G46Si1Zy00H3W08DVX";
   await Stripe.instance.applySettings();
  }

  @override
  void initState() {
    Stripay().pyinislize();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            debugPrint("=====${url.toString()}");

            if(url == payment_redirect_url){
          setState(() {
            isLoading = true;
            displayPaymentSheet(widget.mainPageData,context,widget.radioCode,widget.emailId,widget.deviceNO,widget.date,getRandString(17));
          });
            }
            else if(url =="https://www.google.com/"){
              Navigator.of(context).pop();
            }
          },
          onPageFinished: (String url) {
            if(url == baseurl){}
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Stack(children: [
        Column(children: [SizedBox(height: 40,),
          Expanded(child: WebViewWidget(controller: webViewController,))
        ],),
        isLoading == true?  Container(color: Colors.white, height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(child: CircularProgressIndicator(),),SizedBox(height: 20,),
          Text("Payment is Loading",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)
        ],),
        ):Container()
      ]),
      // body:        Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       CardField(
      //         enablePostalCode: false,
      //         countryCode: 'US',
      //         postalCodeHintText: 'Enter the us postal code',
      //         onCardChanged: (card) {
      //           setState(() {
      //             _card = card;
      //           });
      //         },
      //       ),
      //       GestureDetector(onTap: _handlePayPress, child: Container(height: 40,width: 300,color: Colors.green,child: Center(child: Text("Pay"),),),)
      //     ],
      //   ),
      // ),
    );
  }

  Future<void> _handlePayPress() async {
    if (_card == null) {
      return;
    }
    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(number: "4242424242424242",cvc: "211",expirationYear: 29,expirationMonth: 04));
    // 1. fetch Intent Client Secret from backend
    final clientSecret = await fetchPaymentIntentClientSecret();

    // 2. Gather customer billing information (ex. email)
    final billingDetails = BillingDetails(
      email: _email,
      phone: '+48888000888',
      address: Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ),
    ); // mo mocked data for tests

    // 3. Confirm payment with card details
    // The rest will be done automatically using webhooks
    // ignore: unused_local_variable
try{
  final paymentIntent = await Stripe.instance.confirmPayment(
    paymentIntentClientSecret: clientSecret['client_secret'],
    data: PaymentMethodParams.card(

      paymentMethodData: PaymentMethodData(
        billingDetails: billingDetails,
      ),
    ),
    options: PaymentMethodOptions(
      setupFutureUsage:
      _saveCard == true ? PaymentIntentsFutureUsage.OffSession : null,
    ),
  );
  debugPrint("======${paymentIntent.status.toString()}");

  try{
    final paymentIntents = await Stripe.instance.handleNextAction(paymentIntent.clientSecret,returnURL: "www.google.com");
    debugPrint("======Success${paymentIntents.status.toString()}");
  }catch(error){
    debugPrint("======Error${error.toString()}");
  }


  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Success!: The payment was confirmed successfully!')));

} catch(messgae){
  debugPrint("======${messgae.toString()}");
}


  }

  Future<Map<String, dynamic>> fetchPaymentIntentClientSecret() async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': "699",
        'currency': 'EUR',

      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${stripe_Secret_Key}',
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

  displayPaymentSheet(mainpagedata, BuildContext context, String serialno,
      String email, String? deviceno, String? date,String paymentId) async {
    print("displayPaymentSheet $mainpagedata");
    var CodeUrl = auto_code_generator_url + serialno;
    var request1 = await http.get(Uri.parse('${CodeUrl}'));
    var radiocode;
    if (request1.body is int && request1.statusCode == 200) {
      radiocode = request1.body.toString();
    } else {
      radiocode = "Admin send Code you later";
    }
    print("displayPaymentSheet ${request1.body.toString()}");
    // if (request1.statusCode == 200) {
    var headers = {'Accept': 'application/json'};
    var request = await http.get(
        Uri.parse(
            '${baseurl}/api/payorder?serial_no=${serialno}&car_model=${mainpagedata['title']}&email=${email}&amount=${mainpagedata['amount']}&radeocode=${radiocode}&deviceno=${deviceno.toString()}&date=${date.toString()}&payment_method_id=PAYID-MT${paymentId}'),
        headers: headers);

    print("request234 ${request.body}");
    if (request.statusCode == 200) {

        Navigator.pushReplacement(
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

  }

}