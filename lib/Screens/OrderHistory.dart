import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/Colors.dart';
import 'gethistory.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List radiocode = [];

  Orderhis() async {
    print("object");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //  await prefs.setStringList("serialno", ["VWZ1Z2N1130260"]);
// Save an list of strings to 'items' key.
    var srno = await prefs.getStringList('serialno');
    setState(() {
      radiocode = srno!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Orderhis();
  }

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
      body: Column(
        children: [Expanded(child: SingleChildScrollView(child: headerView()))],
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
          height: 195,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              gradient: RadialGradient(
                center: Alignment.bottomCenter,
                stops: [0.05, 0.8],
                colors: [
                  Colors.deepPurple,
                  Colors.black,
                ],
                radius: 1.0,
              )
              // image: DecorationImage(
              //     image: AssetImage('images/background.png'), fit: BoxFit.cover),
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
                      margin: const EdgeInsets.only(top: 40),
                      height: 33,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.amber,
                              size: 20,
                            ),
                            Padding(padding: EdgeInsets.only(left: 5)),
                            Text(
                              'Back',
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
                Padding(padding: EdgeInsets.only(top: 50)),
                const Text(
                  'My orders history.',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )
              ],
            ),
          ),
        ),
        Container(
          transform: Matrix4.translationValues(0.0, -15.0, 0.0),
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20),
          child:
              radiocode.length == 0
                  ?  Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                          child: Text("No order Found")),
                    )
                  :
              Column(
                  children: radiocode.map((e) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Gethistory(
                      serialnumber: e.toString(),
                    ),
                  ),
                );
              },
              child: valueWidget(title: 'Order complete', value: e.toString()),
            );
          }).toList()),
        )
      ],
    );
  }

  Widget valueWidget({required String title, required String value}) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 18,
                width: MediaQuery.of(context).size.width / 9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                child: Center(
                  child: Image.asset(
                    'images/box.png', // Path to your asset image
                    color: Colors.white, fit: BoxFit.fill
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
