import 'package:flutter/material.dart';
import 'package:radio_code/Screens/after_payment_pending.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import '../Utils/apiurl.dart';
import 'CodeReadyScreen.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  final Map mainPageData;
  final String radioCode;
  final String date;
  final String deviceNO;
  final String emailId;
  const PaymentWebView({super.key,required this.url,required this.mainPageData,required this.radioCode,required this.date,required this.deviceNO,
  required this.emailId
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {

  WebViewController webViewController = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            debugPrint("=====${url.toString()}");
            if(url == baseurl){
              displayPaymentSheet(widget.mainPageData,context,widget.radioCode,widget.emailId,widget.deviceNO,widget.date);
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
    return  Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff00008B),title: Text("Paypal"),centerTitle: true,elevation: 0,),
      body: WebViewWidget(controller: webViewController,),
    );
  }

  displayPaymentSheet(mainpagedata, BuildContext context, String serialno,
      String email, String? deviceno, String? date) async {
    print("displayPaymentSheet $mainpagedata");

      var request1 = await http.get(Uri.parse(
          'http://d83.cc:9488/logon/getPIN?api_key=71aaafecdb8f2f65f2bd0c06b3b1c585&sn=$serialno'));
      print("displayPaymentSheet ${request1.body.trim()}");
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
        if(radiocode == "Admin send Code you later"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  AfterPaymentPending()),
          );
        }else {
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
        }

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
