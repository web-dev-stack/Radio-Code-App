import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/Colors.dart';
import '../Utils/apiurl.dart';
import '../main.dart';
import 'HomeScreen.dart';
import 'OrderHistory.dart';
import 'test.dart';

class CodeReadyScreen extends StatefulWidget {
  const CodeReadyScreen(
      {Key? key,
      required this.serialnumber,
      required this.radio,
      required this.title})
      : super(key: key);

  final String serialnumber;
  final String radio;
  final String title;

  @override
  State<CodeReadyScreen> createState() => _CodeReadyScreenState();
}

class _CodeReadyScreenState extends State<CodeReadyScreen> {
  Timer? timer;
  String radioCode = "";

  void initState() {
    // TODO: implement initState
    radioCode = widget.radio;
    Future.delayed(Duration.zero).then((value) {
      if (radioCode == "Admin send Code you later") {
        // showFancyCustomDialog(context);
        callAPiMultiple();
      }
    });
    super.initState();
    Orderhis();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<String> list = [];
  Orderhis() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var srno = await prefs.getStringList('serialno');
    if (srno == null) {
      await prefs.setStringList("serialno", [widget.serialnumber]);
    } else {
      list = srno;
      list.add(widget.serialnumber);

      await prefs.setStringList("serialno", list);
    }
  }

  void callAPiMultiple() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      Orderhiss();
    });
  }

  Orderhiss() async {
    var headers = {'Accept': 'application/json'};
    var request = await http.get(
        headers: headers,
        Uri.parse('${baseurl}/api/getorder/${widget.serialnumber}'));

    if (request.statusCode == 200) {
      var vale = jsonDecode(request.body);
      if (vale.last["code"] != "Admin send Code you later") {
        // Navigator.of(context).pop();
        radioCode = vale.last["code"];
        timer!.cancel();
      }

      // if(vale !="Admin send Code you later"){

      // }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
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
        body: Column(
          children: [
            Expanded(child: SingleChildScrollView(child: headerView()))
          ],
        ),
      ),
    );
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

  Widget headerView() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 240,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              gradient: RadialGradient(
                center: Alignment.bottomCenter,
                stops: [0.1, 0.8],
                colors: [
                  Colors.deepPurple,
                  Colors.black,
                ],
                radius: 1.0,
              )
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Colors.black,
              //     Colors.deepPurple,
              //   ],
              // ),
              ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(top: 50),
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderHistoryScreen(),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                                'images/box.png', // Path to your asset image
                                color: Colors.amber, fit: BoxFit.fill
                            ),
                            const Padding(padding: EdgeInsets.only(left: 5)),
                            Text(
                              'My codes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 60)),
                const Text(
                  'Order details',
                  style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )
              ],
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -35.0, 0.0),
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              radioCode == "Admin send Code you later"
                  ? valueWidget(
                      title: 'Order status',
                      value: radioCode == "Admin send Code you later"
                          ? "Processing"
                          : radioCode,
                      widget: Container(
                        child: Container(
                          height: 37,
                          width: 37,
                          child: Image.asset(
                            "images/ic_clock_processing.png",
                            fit: BoxFit.fill,
                            color: Color(0xffFFBE00),
                          ),
                        ),
                      ))
                  : valueWidget(
                      title: 'Radio Code',
                      value: radioCode,
                      widget: Container(
                        child: Container(
                          height: 43,
                          width: 38,
                          child: Image.asset(
                            "images/ic_open_lock_icon.png",
                            fit: BoxFit.fill,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      textColor: Colors.green),
              valueWidget(
                  title: 'Serial number',
                  value: widget.serialnumber,
                  widget: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  )),
              valueWidget(
                  title: 'Vehicle manufacturer',
                  value: widget.title,
                  widget: Container(
                    height: 43,
                    width: 38,
                    child: Image.asset(
                      "images/ic_stiyaring_weel.png",
                      fit: BoxFit.contain,
                    ),
                  )),

              radioCode == "Admin send Code you later"
                  ?    Container(
                margin: const EdgeInsets.symmetric(vertical: 5),

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
                child:       Padding(
                  padding: const EdgeInsets.all(15),
                  child:  RichText(
                      text: TextSpan(
                          text: 'Recover your code by the ',
                          style: TextStyle(color: Colors.black,fontSize: 17),
                          children: const [

                            TextSpan(
                                text: "Please note  the code delivery may take a bit longer — typically between",
                                style: TextStyle(
                                    fontSize: 16
                                )),
                            TextSpan(
                                text: ' 5 to 30 minutes.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 16

                                )),

                          ])),
                  // child: Text(
                  //   "Please note  the code delivery may take a bit longer — typically between 5 to 30 minutes.",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w700,
                  //       fontSize: 18,
                  //       color:  Colors.black)),
                ),
                ):Container(),

              // rateThis()
            ],
          ),
        )
      ],
    );
  }

  Widget valueWidget(
      {required String title,
      required String value,
      required Widget widget,
      Color? textColor}) {
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
          SizedBox(
            width: 10,
          ),
          widget,
          const Padding(padding: EdgeInsets.only(left: 10)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: textColor ??
                          (title == "Order status"
                              ? Color(0xffFFBE00)
                              : Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rateThis() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 150,
      decoration: BoxDecoration(
          color: pureWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please rate this app',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            const Text(
              'Help us distinguish ourselves from fake apps',
              style: TextStyle(color: Colors.black45),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: const [
                Icon(
                  Icons.star_border,
                  size: 35,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showFancyCustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 550,
        decoration: BoxDecoration(
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
                borderRadius: BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/loadergif.gif",
                          width: 150, height: 150),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Generating Radio Code...",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (Route route) => false);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Text(
                          "(Note :- Admin will send you code in some time , you can tap on home button and check on oder history when radio code will generate.)",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
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
}
