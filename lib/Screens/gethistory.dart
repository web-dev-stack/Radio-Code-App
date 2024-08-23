import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/Colors.dart';
import '../Utils/apiurl.dart';

class Gethistory extends StatefulWidget {
  const Gethistory({
    Key? key,
    required this.serialnumber,
  }) : super(key: key);

  final String serialnumber;

  @override
  State<Gethistory> createState() => _GethistoryState();
}

class _GethistoryState extends State<Gethistory> {
  List radiocode = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Orderhis();
  }

  bool showdata = true;

  Orderhis() async {
    var headers = {'Accept': 'application/json'};

    radiocode = [];

    var request = await http.get(
        headers: headers,
        Uri.parse('${baseurl}/api/getorder/${widget.serialnumber}'));

    if (request.statusCode == 200) {
      var vale = jsonDecode(request.body);
      print(vale);

      radiocode.add(vale.last);
      showdata = false;
      setState(() {});
    }
  }

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
          child: const Center(child: Icon(Icons.messenger_outlined,color: Colors.white,),),
          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(50)),
        ),
      ),
      body: Column(
        children: [Expanded(child: SingleChildScrollView(child: headerView()))],
      ),
    );
  }

  launchWhatsapp() async {
    var whatsapp = "48784719269";
    var whatsappAndroid =Uri.parse("https://wa.me/$whatsapp/");
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
          height: 270,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
              gradient:  RadialGradient(
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
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 5)),
                            Text(
                              'Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 70)),
                const Text(
                  'My orders history',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )
              ],
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              left: 20, right: 20),
          child: showdata
              ? CircularProgressIndicator()
              : Column(
                  children: radiocode.map((edata) {
                    return Column(
                      children: [
                        edata['code'] == "Admin send Code you later"
                            ? valueWidget(
                            title: 'Order status',
                            value: edata['code'] == "Admin send Code you later"
                                ? "Processing"
                                : edata['code'],
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
                            value: edata['code'],
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
                            title: 'Serial number', value: edata['serial_no'],widget: Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.black,

                          ),
                          child: Center(child: Icon(Icons.done,color: Colors.white,),),
                        )),
                        valueWidget(
                            title: 'Order no', value: edata['id'].toString(),widget: Container(height: 43,width: 38, child: Image.asset("images/ic_stiyaring_weel.png",fit: BoxFit.contain,),)),
                        edata['code'] == "Admin send Code you later"?
                          Container(
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
                    );
                  }).toList(),
                ),
        )
      ],
    );
  }

  Widget valueWidget({required String title, required String value,required Widget widget,Color? textColor}) {
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
          SizedBox(width: 10,),
          widget,
          const Padding(padding: EdgeInsets.only(left: 10)),
          Column(
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
}
