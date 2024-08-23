import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../Utils/apiurl.dart';
import 'package:radio_code/Screens/after_payment_pending.dart';
import 'package:radio_code/Screens/payment.dart';
import 'package:radio_code/Screens/payment_webview.dart';

class PaypalDetailsScreen extends StatefulWidget {

  final Map mainPageData;
  final String radioCode;
  final String date;
  final String deviceNO;
  final String emailId;
  const PaypalDetailsScreen({super.key,required this.mainPageData,required this.radioCode,required this.date,required this.deviceNO,
    required this.emailId});

  @override
  State<PaypalDetailsScreen> createState() => _PaypalDetailsScreenState();
}

class _PaypalDetailsScreenState extends State<PaypalDetailsScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isEnableShipping = false;
  bool isEnableAddress = false;

  bool buttonLoading = false;

  Map<dynamic,dynamic> defaultCurrency = {"symbol": "EUR ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "EUR"};



  // item name, price and quantity
  String itemName = 'Radio code';
  String itemPrice = '1.99';
  int quantity = 1;

  String returnURL = baseurl;
  String cancelURL= baseurl;
  TextEditingController name  = TextEditingController();
  TextEditingController address  = TextEditingController();
  TextEditingController city  = TextEditingController();
  TextEditingController number  = TextEditingController();

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": widget.mainPageData['amount'].toString(),
        "currency": defaultCurrency["currency"]
      }
    ];


    // checkout invoice details
    String totalAmount = widget.mainPageData['amount'].toString();
    String subTotalAmount = widget.mainPageData['amount'].toString();
    String shippingCost = '0';
    int shippingDiscountCost = 0;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": subTotalAmount,
              "shipping": shippingCost,
              "shipping_discount":
              ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
              "shipping_address": {
                "recipient_name": name.text.trim(),
                "line1": address.text.trim(),
                "line2": "--",
                "city": city.text.trim(),
                "country_code": "US",
                "postal_code": "--",
                "phone": number.text.trim(),
                "state": "--"
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": returnURL,
        "cancel_url": cancelURL
      }
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,centerTitle: false,
        titleSpacing: 0,
        title: const Text("Return",style: TextStyle(color: Colors.black)),
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        child: Container(width: MediaQuery.of(context).size.width,
          child: Column(children: [SizedBox(height: 20,),
   Container(height: 80,width: 80,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: AssetImage("images/icon.jpeg"))),),
            SizedBox(height: 15,),   Text("${widget.mainPageData['amount']} EUR",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),

            SizedBox(height: 25,),
            customTextFiled("Name",name,"Please enter your name"),
            SizedBox(height: 15,),
            customTextFiled("Address 1",address,"Please enter your Address"),
            SizedBox(height: 15,),
            customTextFiled("City",city,"Please enter your City Name"),
            SizedBox(height: 15,),
            customTextFiled("Number",number,"Please enter your Mobile Number"),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InkWell(
                onTap: () {
               setState(() {
           if(name.text.isEmpty){
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text("name is required"))
             );

           }else if(address.text.isEmpty) {
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text("address is required"))
             );
           }else if(city.text.isEmpty) {
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text("city is required"))
             );
           }else if(number.text.isEmpty) {
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text("number is required"))
             );
           }else {
             setState(() {
               buttonLoading = true;
               loadPayment();

             });
           }
               });

                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10)),
                  child :buttonLoading == true?Center(child: CircularProgressIndicator(),): Text(
                    'Pay',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),

          ],),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {

    // _scaffoldKey.currentState!.ScaffoldMessenger.showSnackBar(new SnackBar(
    //     content: new Text(value)
    // ));

  }
  
  Widget customTextFiled(String title,TextEditingController controller,String hintText){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,style: TextStyle(fontSize: 18),),SizedBox(height: 15,),
        TextField(
          controller: controller,
          keyboardType: hintText == "Please enter your Mobile Number"?TextInputType.number:TextInputType.text,
          decoration: InputDecoration(
            hintText: hintText,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1,color: Colors.black)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1,color: Colors.black)
            ),

          ),
        )
      ]),
    );
  }


  loadPayment() async {

    try {
      Map getToken = await PaypalServices().getAccessToken();
      print("====TOKEN${getToken.toString()}");
      if (getToken['token'] != null) {
        var  accessToken = getToken['token'];
        final transactions = getOrderParams();
        final res =
        await PaypalServices().createPaypalPayment(transactions, accessToken);
        debugPrint("=====H${res.toString()}");
        if (res["approvalUrl"] != null) {
          setState(() {
            var checkoutUrl = res["approvalUrl"].toString();
            var navUrl = res["approvalUrl"].toString();
            var  executeUrl = res["executeUrl"].toString();
            print("====${checkoutUrl}");
            buttonLoading = false;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  PaymentWebView(url: checkoutUrl,mainPageData: widget.mainPageData,radioCode: widget.radioCode,date: widget.date!,deviceNO: widget.deviceNO!,
                emailId: widget.emailId,
              )),
            );


          });

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Something went wrong please try again.."))
          );

          buttonLoading = false;
        }
      } else {
        print("====}");
        buttonLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something went wrong please try again.."))
        );
      }
    } catch (e) {

    }
  }
}
