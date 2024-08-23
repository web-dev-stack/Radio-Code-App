import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mad_pay/mad_pay.dart';

import 'package:radio_code/Screens/payment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Utils/Colors.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_inapp_purchase/modules.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../Utils/apiurl.dart';
import 'CodeReadyScreen.dart';
import 'after_payment_pending.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {Key? key,
      required this.mainpagedata,
      required this.rediocode,
      this.device,
      this.date,
      this.carName})
      : super(key: key);
  final Map mainpagedata;
  final String rediocode;
  final String? device;
  final String? date;
  final String? carName;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectratio;

  WebViewController webViewController = WebViewController();
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "EUR ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "EUR"
  };

  // item name, price and quantity
  String itemName = 'Radio code';
  String itemPrice = '1.99';
  int quantity = 1;

  String returnURL = baseurl;
  String cancelURL = 'https://google.com/';


  StreamSubscription? purchaseUpdatedSubscription;
  StreamSubscription? purchaseErrorSubscription;
  StreamSubscription? conectionSubscription;
  String isPurchased = "0";
  bool isPurchasedOne = false;
  List<String> productLists = [];

  String platformVersion = 'Unknown';
  List<IAPItem>? items = <IAPItem>[];
  List<PurchasedItem>? purchases = <PurchasedItem>[];
  bool isShowingLoader = false;

  @override
  void initState() {
    setState(() {
      selectratio = "Credit or debit Card";
    });
    super.initState();
    if (Platform.isAndroid) {
      productLists = ["com.stormdeve.car_radio.${widget.carName.toString()}"];
    }

    // Stripay().pyinislize();
    initPlatformState();

    // _payClient.showPaymentSelector(PayProvider.google_pay, _paymentItems);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (conectionSubscription != null) {
      conectionSubscription!.cancel();
      conectionSubscription = null;
    }
    super.dispose();
  }

  final MadPay pay = MadPay();

  getpayment() async {
// To find out if payment is available on this device
    var ch = await pay.checkPayments();
    print("checkPayments $ch");
    // double am = widget.mainpagedata['amount'] * 100;
    // RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
    //
    // String ss = am.toString().replaceAll(regex, '');
// If you need to check if user has at least one active card
    var ch1 = await pay.checkActiveCard(
      paymentNetworks: <PaymentNetwork>[
        PaymentNetwork.visa,
        PaymentNetwork.mastercard,
      ],
    );
    print("checkActiveCard $ch1");
    try {
// To pay with Apple Pay or Google Pay
      final PaymentResponse? response =
          await pay.processingPayment(PaymentRequest(
        google: GoogleParameters(
          gatewayName: 'Your Gateway',
          gatewayMerchantId: 'exampleGatewayMerchantId',
          merchantId: '01234567890123456789',
        ),
        apple: AppleParameters(
          merchantIdentifier: 'example',
        ),
        currencyCode: 'EUR',
        countryCode: 'EU',
        paymentItems: <PaymentItem>[
          PaymentItem(
              name: widget.mainpagedata['title'],
              price: double.parse(widget.mainpagedata['amount'].toString())),
        ],
        paymentNetworks: <PaymentNetwork>[
          PaymentNetwork.visa,
          PaymentNetwork.mastercard,
        ],
      ));
      if (response?.rawData != null) {
        Stripay().googlepay(widget.mainpagedata, context, widget.rediocode,
            emailController.text, widget.device, widget.date);
      }
    } catch (e) {
      setState(() {
        print('Error:\n$e');
      });
    }
    //print("payresponse ${data!.rawData}");
  }

  final emailController = TextEditingController();
  String? errortext = "";
  bool buttonLoading = false;

  @override
  Widget build(BuildContext context) {
    // var googlePayButton = SizedBox(
    //   width: 250,
    //   height: 50,
    //   child: GooglePayButton(
    //     // width: 200,
    //     // height: 40,
    //     paymentConfiguration:
    //         PaymentConfiguration.fromJsonString(defaultGooglePay),
    //     paymentItems: [
    //       PaymentItem(
    //         label: 'Total',
    //         amount: widget.mainpagedata['amount'].toString(),
    //         status: PaymentItemStatus.final_price,
    //       )
    //     ],
    //     type: GooglePayButtonType.pay,
    //     margin: const EdgeInsets.only(bottom: 15),
    //     onPaymentResult: (result) async {
    //       await Stripay().googlepay(
    //           widget.mainpagedata,
    //           context,
    //           widget.rediocode,
    //           emailController.text,
    //           widget.device,
    //           widget.date);
    //     },
    //     loadingIndicator: Center(
    //       child: SpinKitFadingCircle(
    //         size: 20,
    //         itemBuilder: (BuildContext context, int index) {
    //           return DecoratedBox(
    //             decoration: BoxDecoration(
    //               color: index.isEven ? Colors.red : Colors.green,
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          launchWhatsapp();
        },
        child: Container(
          height: 50,
          width: 50,
          child: const Center(
            child: Icon(
              Icons.messenger_outlined,
              color: Colors.white,
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(50)),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 278,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomCenter,
                    stops: [0.1, 0.8],
                    colors: [
                      Colors.deepPurple,
                      Colors.black,
                    ],
                    radius: 1.0,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
            ),
            // backGroundView(context: context),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(top: 25),
                          height: 33,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber),
                              borderRadius: BorderRadius.circular(5)),
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.amber,
                                  size: 20,
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 5)),
                                Text(
                                  'Cancel order',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                   Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Radio code retrival',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width/14.7,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  ),
                       Padding(
                         padding: EdgeInsets.only(left: 20),
                         child: Text(
                           'details.',
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: MediaQuery.of(context).size.width/14.7,
                             fontWeight: FontWeight.w700,
                           ),
                         ),
                       ),
                     ],
                   ),
                  const SizedBox(
                    height: 30,
                  ),
                  _detailsView(),
                  _paymentDetailsView(),
                  _paymentMethodView(),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 0),
                      child: InkWell(
                        onTap: () async {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>  CodeReadyScreen(radiocode: "Df",),
                          //   ),
                          // );
                          print(
                              "email test ${emailController.text.isEmpty} ${emailController.text.contains("@")}");

                          if (emailController.text!.isEmpty == false &&
                              emailController.text.contains("@") == true) {
                            errortext = null;
                            if (selectratio == "Credit or debit Card") {
                              buttonLoading = true;
                              setState(() {});
                              if (emailController.text != null) {

                                StripePayment().createCustomer(
                                    emailController.text.toString(),
                                    widget.mainpagedata,
                                    context,
                                    widget.rediocode,
                                    widget.date!,
                                    widget.device!);

                                // await Stripay().makePayment(
                                //     widget.mainpagedata,
                                //     context,
                                //     widget.rediocode,
                                //     emailController.text,
                                //     widget.device,
                                //     widget.date);
                              }
                              Future.delayed(const Duration(seconds: 1),
                                  () async {
                                buttonLoading = false;
                                setState(() {});
                              });
                              // Stripay().displayPaymentSheet({"title":"amarjeet"},context,"UYIUYIHUHIU&","amarj@gmail.com","32432","243");
                            } else if (selectratio == "Paypal") {
                              buttonLoading = true;
                              setState(() {});
                              loadPayment();
                              //  Navigator.pushReplacement(
                              //    context,
                              //    MaterialPageRoute(
                              //      builder: (context) => PaypalDetailsScreen(
                              // emailId: emailController.text.trim(),
                              //        deviceNO: widget.device!,
                              //        date: widget.date!,
                              //        radioCode: widget.rediocode,
                              //        mainPageData: widget.mainpagedata,
                              //
                              //      ),
                              //    ),
                              //  );
                            } else {
                              setState(() {
                                buttonLoading = true;
                              });
                              // displayPaymentSheet(
                              //     widget.mainpagedata, context, widget.rediocode,
                              //     emailController.text.trim(), widget.device,
                              //     widget.date,getRandString(17));
                              requestPurchase(items![0]);
                            }
                          } else {
                            print(
                                "email test2 ${emailController.text!.isEmpty} ${emailController.text.contains("@")}");

                            // errortext = "Please Enter valid Email";

                            var snackBar = const SnackBar(
                                content: Text('Please Enter valid Email'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              // margin: EdgeInsets.symmetric(horizontal: 40)padding: EdgeInsets.symmetric(horizontal: 30,vertical: 18),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: selectratio == "Paypal"
                                      ? Colors.amberAccent
                                      : Colors.green),
                              child: buttonLoading
                                  ? Padding(
                                      padding: const EdgeInsets.all(17.0),
                                      child: SpinKitFadingCircle(
                                        size: 20,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: index.isEven
                                                  ? Colors.red
                                                  : Colors.green,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(17.0),
                                      child: Center(
                                          child: selectratio == "Paypal"
                                              ? const Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image(
                                                      image: AssetImage(
                                                          "images/ic_paypal_image_two.png"),
                                                      height: 20,
                                                      width: 90,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Text(
                                                      "Checkout",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )
                                              : const Text(
                                                  "Buy Radio Code",
                                                  style:
                                                      TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                          fontSize: 20
                                                      ),
                                                )),
                                    ),
                            ),
                          ],
                        ),
                      )),
                  selectratio == "Paypal"
                      ? const SizedBox(height: 8)
                      : Container(),
                  selectratio == "Paypal"
                      ? Center(
                          child: Container(
                            child: const Text(
                              "The safer,easier way to pay",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.security_sharp,
                        size: 18,
                      ),
                      Text(
                        " 100 % Money-back guarntee!",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentMethodView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Pay with:',
          //   style: TextStyle(
          //     color: blueColor,
          //     fontSize: 22,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),

          Column(
            children: [
              // _singlePaymentMethodView(
              //     imageName: 'ic_googleplay_icon.png', Name: "Google Play"),
              // const SizedBox(
              //   height: 10,
              // ),
              _singlePaymentMethodView(
                  imageName: 'ic_debit_cart.png', Name: "Credit or debit Card"),

              // Container(height: 10,),
              // _singlePaymentMethodView(
              //     imageName: 'ic_paypal_icon_three.png', Name: "Paypal"),
              const SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  String selectedPaymentMethod = 'stripe.png';

  Widget _singlePaymentMethodView({
    required String imageName,
    required String Name,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectratio = Name;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(1, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              width: 35,
              child: Radio(
                  value: Name,
                  groupValue: selectratio,
                  onChanged: (v) {
                    setState(() {
                      selectratio = v;
                    });
                  }),
            ),
            Image.asset(
              'images/$imageName',
              width: Name == "Google Play" ? 20 : 23,
              height: Name == "Google Play" ? 20 : 24,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                Name,
                style: const TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _paymentDetailsView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [SizedBox(height: 10,),
          Container(
              decoration: BoxDecoration(
                color: pureWhiteColor, // Replace with your white color
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 0), // Matches the original shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Icon(
                      size: 30,
                      Icons.email_rounded, // Replace with your specific icon
                      color: Colors.black.withOpacity(1),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: InputDecoration(
                          errorText: errortext,
                          hintText: 'example@mail.com',
                          labelText: 'Enter Your Email Address',
                          contentPadding: const EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),SizedBox(height: 17,),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: const Text("Sub-total",style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w500),),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5,left: 5),
                child: Text(
                  "${widget.mainpagedata['amount']} EUR",
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5,left: 5),
                child: Text(
                  "${widget.mainpagedata['amount'] * 2} EUR",
                  style:
                      const TextStyle(decoration: TextDecoration.lineThrough),
                ),
              ),
            ],
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 15, left: 5),
          //   child: const Text(
          //     "Delivery time",
          //     style: TextStyle(),
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(left: 5),
          //   child: const Text(
          //     "Instant",
          //     style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.green),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _detailsView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          valueWidget(
              title: 'Serial number',
              value: widget.rediocode,
              icon: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.black,

                ),
                child: Center(child: Icon(Icons.qr_code_scanner_rounded,color: Colors.white,),),
              ),),
          valueWidget(
              title: 'Code type',
              value: "4 Digit Code",
              icon: Container(height: 43,width: 38, child: Image.asset("images/ic_open_lock_icon.png",fit: BoxFit.contain,),)),
          // valueWidget(title: 'Radio Icon(Icons.open_loc)Manufacturer', value: "Balaunkt",icon:Icon(Icons.settings,color: Colors.white,)),
          valueWidget(
              title: 'Vehicle manufacturer',
              value: "${widget.mainpagedata['title']}",
              icon: Container(height: 43,width: 38, child: Image.asset("images/ic_stiyaring_weel.png",fit: BoxFit.contain,),)),
          Visibility(
            visible: widget.device != "" ? true : false,
            child: Column(
              children: [
                valueWidget(
                    title: 'Device Number',
                    value: "${widget.device}",
                    icon: const Icon(
                      Icons.device_hub_outlined,
                      color: Colors.white,
                    )),
                valueWidget(
                    title: 'Date',
                    value: "${widget.date}",
                    icon: const Icon(
                      Icons.date_range_outlined,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget valueWidget(
      {required String title, required String value, required Widget icon}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 65,
      decoration: BoxDecoration(
        color: pureWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 12,),
     icon,
          const Padding(padding: EdgeInsets.only(left: 12)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:  TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              Text(
                value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  loadPayment() async {
    try {
      Map getToken = await PaypalServices().getAccessToken();
      print("====TOKEN${getToken.toString()}");
      if (getToken['token'] != null) {
        var accessToken = getToken['token'];
        final transactions = getOrderParams();
        final res = await PaypalServices()
            .createPaypalPayment(transactions, accessToken);
        debugPrint("=====H${res.toString()}");
        if (res["approvalUrl"] != null) {
          setState(() {
            var checkoutUrl = res["approvalUrl"].toString();
            var navUrl = res["approvalUrl"].toString();
            var executeUrl = res["executeUrl"].toString();
            print("====${checkoutUrl}");
            buttonLoading = false;
            webViewController = WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {
                    debugPrint("=====${url.toString()}");

                    // if(url == checkoutUrl){
                    //   displayPaymentSheet(widget.mainpagedata,context,widget.rediocode,emailController.text.trim(),widget.device,widget.date);
                    // }

                    if (url == payment_redirect_url) {
                      Navigator.pop(context);
                      showLoading(context);

                      displayPaymentSheet(
                          widget.mainpagedata,
                          context,
                          widget.rediocode,
                          emailController.text.trim(),
                          widget.device,
                          widget.date,
                          getRandString(22));
                    } else if (url.substring(0, url.indexOf('?')) ==
                        "https://www.google.com/") {
                      Navigator.pop(context);
                    }
                  },
                  onPageFinished: (String url) {
                    if (url == baseurl) {}
                  },
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith(checkoutUrl)) {
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse(checkoutUrl));

            showFancyCustomDialog(context);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Something went wrong please try again..")));

          buttonLoading = false;
        }
      } else {
        print("====}");
        buttonLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong please try again..")));
      }
    } catch (e) {}
  }

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": widget.mainpagedata['amount'].toString(),
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String totalAmount = widget.mainpagedata['amount'].toString();
    String subTotalAmount = widget.mainpagedata['amount'].toString();
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = 'Gulshan';
    String userLastName = 'Yadav';
    String addressCity = 'Delhi';
    String addressStreet = 'Mathura Road';
    String addressZipCode = '110014';
    String addressCountry = 'India';
    String addressState = 'Delhi';
    String addressPhoneNumber = '+919990119091';

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
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            // "shipping_address": {
            //   "recipient_name": name.text.trim(),
            //   "line1": address.text.trim(),
            //   "line2": "--",
            //   "city": city.text.trim(),
            //   "country_code": "US",
            //   "postal_code": "--",
            //   "phone": number.text.trim(),
            //   "state": "--"
            // },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  void showLoading(BuildContext context) {
    Dialog fancyDialog = Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
          height: 550,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Payment is Loading",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => fancyDialog,
    );
  }

  void showLoadingTwo(BuildContext context) {
    Dialog fancyDialog = Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 130),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
          height: 100,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          )),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => fancyDialog,
    );
  }

  void showFancyCustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 550,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: WebViewWidget(controller: webViewController),
              ),
            ),
            Align(
              // These values are based on trial & error method
              alignment: const Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => fancyDialog,
    );
  }

  displayPaymentSheet(mainpagedata, BuildContext context, String serialno,
      String email, String? deviceno, String? date, String paymentId) async {
    print("displayPaymentSheet $mainpagedata");

    var request1 = await http.get(Uri.parse(
        'http://d83.cc:9488/logon/getPIN?api_key=71aaafecdb8f2f65f2bd0c06b3b1c585&sn=$serialno'));
    print("displayPaymentSheet ${request1.body.trim()}");
    var radiocode;
    if (mainpagedata['title'] == "volkswagen" ||
        mainpagedata['title'] == "Seat" ||
        mainpagedata['title'] == "Skoda" ||
        mainpagedata['title'] == "Audi") {
      if (request1.statusCode == 200) {
        radiocode = request1.body.toString();
      } else {
        radiocode = "Admin send Code you later";
      }
    } else {
      radiocode = "Admin send Code you later";
    }
    debugPrint("======${radiocode}");
    // if (request1.statusCode == 200) {
    var headers = {'Accept': 'application/json'};
    var request = await http.get(
        Uri.parse(
            '${baseurl}api/payorder?serial_no=${serialno}&car_model=${mainpagedata['title']}&email=${email}&amount=${mainpagedata['amount']}&radeocode=${radiocode}&deviceno=${deviceno.toString()}&date=${date.toString()}&payment_method_id=PAYID-MT${paymentId}'),
        headers: headers);

    print(
        "==========LInk ${baseurl}api/payorder?serial_no=${serialno}&car_model=${mainpagedata['title']}&email=${email}&amount=${mainpagedata['amount']}&radeocode=${radiocode}&deviceno=${deviceno.toString()}&date=${date.toString()}&payment_method_id=PAYID-MT${paymentId}");

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

  void acknowledgePurchaseAndCallAPI(PurchasedItem productDetails) async {
    FlutterInappPurchase.instance
        .acknowledgePurchaseAndroid(productDetails.purchaseToken.toString())
        .then((value) {
      displayPaymentSheet(
          widget.mainpagedata,
          context,
          widget.rediocode,
          emailController.text.trim(),
          widget.device,
          widget.date,
          getRandString(17));
    });
  }

  void requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance
        .requestPurchase(item.productId!)
        .then((value) {
      debugPrint("=====${value.toString()}");
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    FlutterInappPurchase.instance.consumeAll();
    String? platformVersions = Platform.isAndroid ? "Android" : "iOS";
    var result = await FlutterInappPurchase.instance.initialize();
    setState(() {
      platformVersion = platformVersions;
      conectionSubscription =
          FlutterInappPurchase.connectionUpdated.listen((connected) {});

      purchaseUpdatedSubscription =
          FlutterInappPurchase.purchaseUpdated.listen((productItem) {
        if (productItem != null) {
          isShowingLoader = false;
          if (isPurchasedOne == false) {
            if (Platform.isAndroid) {
              setState(() {
                buttonLoading = false;
              });
              showLoadingTwo(context);
              FlutterInappPurchase.instance
                  .consumePurchaseAndroid(productItem.purchaseToken.toString())
                  .then((value) {});
              FlutterInappPurchase.instance.getAvailablePurchases();
              acknowledgePurchaseAndCallAPI(productItem);
            } else {}
          }
          isPurchasedOne = true;
        }
      });

      purchaseErrorSubscription =
          FlutterInappPurchase.purchaseError.listen((purchaseError) {
        print('purchase-error: $purchaseError');
        setState(() {
          isShowingLoader = false;
          buttonLoading = false;
        });
        // Utils.showMessage("", "Error${purchaseError!.message.toString()}");
      });
    });
    getPurchases();
    getProduct();
    getPurchaseHistory();
  }

  Future getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(productLists);
    for (var item in items) {
      setState(() {
        print(item.toString());
        this.items!.add(item);
      });
    }
    // Utils.showMessage("", this.items!.length.toString());
  }

  Future getPurchases() async {
    List<PurchasedItem>? items =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items!) {
      print('purchase-updated1: ${item.transactionStateIOS}');
      // FlutterInappPurchase.instance.acknowledgePurchaseAndroid(item.purchaseToken.toString()).then((value) {
      //
      // });
      purchases!.add(item);
    }
  }

  Future getPurchaseHistory() async {
    List<PurchasedItem>? items =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items!) {
      print('purchase-updated2: ${item.transactionStateIOS}');
      // FlutterInappPurchase.instance.acknowledgePurchaseAndroid(item.purchaseToken.toString()).then((value) {
      //
      // });
      print(item.toString());
      purchases!.add(item);
    }
  }

  launchWhatsapp() async {
    var whatsapp = "48784719269";
    var whatsappAndroid = Uri.parse("https://wa.me/$whatsapp/");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }
}
