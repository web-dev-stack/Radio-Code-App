import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:radio_code/Screens/PaymentScreen.dart';
import 'package:radio_code/Screens/formate.dart';
import 'package:radio_code/Utils/Colors.dart';
import 'package:radio_code/Screens/OrderHistory.dart';
import 'package:url_launcher/url_launcher.dart';

import 'textlist.dart';

class RadioCodeGeneratorScreen extends StatefulWidget {
  const RadioCodeGeneratorScreen(
      {super.key, required this.title, required this.amount, required this.id});

  final String title;
  final double amount;

  final String id;

  @override
  State<StatefulWidget> createState() => _RadioCodeGeneratorScreenState();
}

class _RadioCodeGeneratorScreenState extends State<RadioCodeGeneratorScreen> {
  final radiocode = TextEditingController();
  final sirialno = TextEditingController();
  final date = TextEditingController();

  List datetext = ["Date", "Prod Date#"];
  List srtext = ["Device Number", "Part#"];
  List srplace = ["7612030076", "20105BH30A"];

  bool dateshow = false;
  bool deviceshow = false;
  bool showRadioCodeDetails = true;
  bool showFastService = false;
  bool doesRetrievalCost = false;

  DateTime? startDate;
  DateTime? facesstartDate;

  int _currentPage = 0;

  Timer? _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  int ind = 0;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    // _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
    //   if (_currentPage < radiohelp[widget.title].length) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }
    //   // _pageController.animateToPage(
    //   //   _currentPage,
    //   //   duration: Duration(milliseconds: 350),
    //   //   curve: Curves.easeIn,
    //   // );
    // });
    super.initState();
    // Future.delayed(Duration(seconds: 2),(){
    //   showFancyCustomDialog(context);
    // });

    Timer.periodic(Duration(seconds: 1), (time) {
      setState(() {
        Random random = new Random();
        int randomNumber = random.nextInt(placeholder["volkswagen"].length);
        index = randomNumber;
        // print("object $index");
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  bool show = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [headerView(), bottomView()],
            ),

          ),
          if (_isLoading)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.black45),
                    strokeWidth: 5,
                  ),
                  SizedBox(height: 20), // Space between the loader and text
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),

        ]
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

  void _onTap() async {
    FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1)); // Simulate delay

    if (radiocode.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            rediocode: radiocode.text,
            mainpagedata: {
              "title": widget.title,
              "amount": widget.amount,
              "id": widget.id,
            },
            date: date.text,
            device: sirialno.text,
            carName: widget.title.replaceAll(" ", "").toLowerCase(),
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void showFancyCustomDialog(BuildContext context) {
    Dialog fancyDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
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
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            ),
            PageView.builder(
              itemCount: radiohelp[widget.title].length,
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            radiohelp[widget.title][index],
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        radioimage[widget.title][index],
                      ),
                    ),
                  ],
                );
              },
            ),
            Align(
              // These values are based on trial & error method
              alignment: Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RadioCodeGeneratorScreen(
                          id: widget.id,
                          amount: double.parse(widget.amount.toString()),
                          title: widget.title),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => fancyDialog);
  }

  Widget headerView() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 295,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   stops: [0.5, 2.0],
              //   colors: [Colors.indigo, Colors.white],
              // ),
              // image: DecorationImage(
              //     image: AssetImage('images/ic_image_backgroup.png'), fit: BoxFit.fill),
              // gradient: LinearGradient(
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   colors: [
              //     Colors.black,
              //     Colors.deepPurple,
              //   ],
              //     stops: [0.60, 1.0]
              // ),
              gradient: RadialGradient(
                center: Alignment.bottomCenter,
                stops: [0.1, 0.9],
                colors: [
                  Colors.deepPurple,
                  Colors.black,
                ],
                radius: 0.6,
              )),
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
                      margin: const EdgeInsets.only(top: 40),
                      height: 40,
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
                            const Padding(padding: EdgeInsets.only(left: 8)),
                            Image.asset(
                                'images/box.png', // Path to your asset image
                                color: Colors.amber, fit: BoxFit.fill
                            ),
                            // Icon(
                            //   Icons.airplane_ticket,
                            //   color: Colors.amber,
                            //   size: 20,
                            // ),
                            const Padding(padding: EdgeInsets.only(left: 8)),
                            Text(
                              'My codes',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            ),
                            SizedBox(
                              width: 3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 25)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get the code for your \nVolkswagen Audi Skoda Seat Radio.',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 12.1),
                    ),
                    // Text(
                    //   'Code Calculator.',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: MediaQuery.of(context).size.width/14.1),
                    // ),SizedBox(height: 15,),
                    // Text(
                    //   'Need the code for your ${widget.title} radio? Get it now online by providing the radio serial number.',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.normal,
                    //       fontSize: MediaQuery.of(context).size.width/24),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -40.0, 0.0),
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 0, left: 20, right: 20),
          // height: (widget.title == "Nissan")
          //     ? MediaQuery.of(context).size.height / 1.7
          //     : MediaQuery.of(context).size.height / 2.7,
          padding: EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Enter your ',
                          style: TextStyle(color: pureBlackColor, fontSize: 16),
                          children: [
                        TextSpan(
                            text: widget.title == "Dacia" ||
                                    widget.title == "Renault"
                                ? "VIN or "
                                : '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        TextSpan(
                            text: ' 𝑖',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              // decoration: TextDecoration.underline,
                              // decorationStyle: TextDecorationStyle.dotted,
                            )),
                        TextSpan(
                            text: ' radio serial number',
                            recognizer: TapGestureRecognizer()
                            ..onTap = (){
                              _showPopup(context);
                            },
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                            ))
                      ])),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                        fontFamily: 'CupertinoIcons'
                    ),
                    onChanged: (value) {
                      if (widget.title == "Nissan") {
                        Future.delayed(Duration(microseconds: 500), () {
                          if (value == "") {
                            dateshow = false;
                            deviceshow = false;
                            ind = 0;
                          } else if (value[0] == "P") {
                            dateshow = false;
                            deviceshow = false;
                            ind = 0;
                          } else if (value[0] == "D" && value.length == 10) {
                            dateshow = true;
                            ind = 1;
                            deviceshow = true;
                          } else if (value[0] == "D" &&
                              //  value.length > 10 &&
                              value.length < 17) {
                            dateshow = false;
                            deviceshow = false;
                            ind = 0;
                          } else if (value[0] == "D" && value.length >= 17) {
                            dateshow = true;
                            deviceshow = false;
                            ind = 0;
                          } else if (int.parse(value[0]) is int &&
                              value.length >= 7) {
                            dateshow = true;
                            deviceshow = true;
                            ind = 0;
                          } else if (value[0] != "D" && value[0] != "P") {
                            dateshow = false;
                            deviceshow = false;
                            ind = 0;
                          }
                          setState(() {});
                        });
                      }
                      else if (widget.title == "vauxhall") {
                        Future.delayed(Duration(microseconds: 500), () {
                          if (value == "") {
                            dateshow = false;
                            deviceshow = false;
                            ind = 0;
                          } else if (value[0] == "P") {
                            dateshow = false;
                            deviceshow = false;
                            ind = 0;
                          } else if (value[0] == "D" && value.length == 10) {
                            dateshow = true;
                            ind = 1;
                            deviceshow = true;
                          } else if (value[0] == "D" &&
                              //  value.length > 10 &&
                              value.length < 17) {
                            dateshow = false;
                            deviceshow = false;
                            ind = 0;
                          } else if (value[0] == "D" && value.length >= 17) {
                            dateshow = true;
                            deviceshow = false;
                            ind = 0;
                          } else if (int.parse(value[0]) is int &&
                              value.length >= 7) {
                            dateshow = true;
                            deviceshow = true;
                            ind = 0;
                          } else if (value[0] != "D" && value[0] != "P") {
                            dateshow = false;
                            deviceshow = false;
                            ind = 0;
                          }
                          setState(() {});
                        });
                      }

                      radiocode.value = TextEditingValue(
                          text: value.toUpperCase(),
                          selection: radiocode.selection);
                    },
                    textCapitalization: TextCapitalization.characters,
                    controller: radiocode,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
                      fillColor: Color(0xfff6f6f6),
                      filled: true,
                      hintText: placeholder["volkswagen"][index],
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Visibility(
                    visible: deviceshow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          srtext[ind],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                        TextFormField(
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                          textCapitalization: TextCapitalization.characters,
                          controller: sirialno,
                          decoration: InputDecoration(
                              fillColor: Color(0xfff6f6f6),
                              filled: true,
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              hintText: srplace[ind],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: dateshow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datetext[ind],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dotted,
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              DateTextFormatter(),
                            ],

                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),

                            // readOnly: true,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.characters,
                            controller: date,
                            decoration: InputDecoration(
                                fillColor: Color(0xfff6f6f6),
                                filled: true,
                                hintStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                                hintText: "03.21.2015",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: _onTap,
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffdea003), // Shadow color
                              spreadRadius: 0, // Spread radius
                              blurRadius: 0, // Blur radius
                              offset: Offset(0,
                                  4), // Offset in the X and Y direction (X, Y)
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get radio code',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '⚡️️Codes are now generated instantly !',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bottomView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Description',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                // fontWeight: FontWeight.bold
              )),
          SizedBox(height: 10),
          Text(
              'Get the code and instructions required to reactivate your car audio unit. All you need is the serial number, which you can find on the side or top of the unit.The service applies to all original audio units fitted to volkswagen Audi Skoda Seat vehicles manufactured between 1998 and 2015.',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
          SizedBox(height: 25),
          Text('Delivery',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                // fontWeight: FontWeight.bold
              )),
          SizedBox(height: 10),
          Text(
              'Your activation code and instructiions appears on the screen the instant after payment is completed.',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              _showPopup(context);
            },
            child: Container(
              alignment: Alignment.center,
              height: 38,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                  ),
                  boxShadow: [
                    BoxShadow(
                        // color: Color(0xffdea003), // Shadow color
                        // spreadRadius: 0, // Spread radius
                        // blurRadius: 0, // Blur radius
                        // offset: Offset(0, 4), // Offset in the X and Y direction (X, Y)
                        ),
                  ]),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '𝑖',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Text(
                    ' Where do I find my serial number?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black38, // Optional: Add a slight tint
              ),
            ),
            Positioned(
              top: 50.0,
              // Adjust this value to position the dialog at the desired height
              left: -20.0,
              // Center the dialog horizontally by adjusting these values
              right: -20.0,

              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.white,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '𝑖',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.blue),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "To get the activation code it is needed the radio serial number. To see this number, remove the radio and check the label sticked to it. A valid serial number starts with VWZ and it's 14 or 15 characters long.",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 20),
                          Image.asset(
                            "images/volkswagen.jpeg",
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: IconButton(
                        icon: Text(
                          '✕',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Positioned(
    //       top: 50.0, // Adjust this value to position the dialog at the desired height
    //       left: 20.0, // Center the dialog horizontally by adjusting these values
    //       right: 20.0,
    //       child: Dialog(
    //
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(20.0),
    //         ),
    //         child: Stack(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(20.0),
    //               child: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                 Text(
    //                 '𝑖',
    //                 style: TextStyle(
    //                     fontWeight: FontWeight.bold, fontSize: 40,color: Colors.blue),
    //               ),
    //                   SizedBox(height: 10),
    //                   Text(
    //                     "To get the activation code it is needed the radio serial number. To see this number, remove the radio and check the label sticked to it. A valid serial number starts with VWZ and it's 14 or 15 characters long.",
    //                     style: TextStyle(fontSize: 16),
    //                   ),
    //                   SizedBox(height: 20),
    //                   Image.asset(
    //                     "images/volkswagen.jpeg",
    //                     fit: BoxFit.fill,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Positioned(
    //               right: 0.0,
    //               top: 0.0,
    //               child: IconButton(
    //                 icon: Text(
    //                   '✕',
    //                   style: TextStyle(
    //                     fontSize: 24,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
