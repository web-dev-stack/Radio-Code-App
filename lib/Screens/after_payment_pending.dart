import 'package:flutter/material.dart';
import 'package:radio_code/Screens/HomeScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class AfterPaymentPending extends StatefulWidget {
  const AfterPaymentPending({super.key});

  @override
  State<AfterPaymentPending> createState() => _AfterPaymentPendingState();
}

class _AfterPaymentPendingState extends State<AfterPaymentPending> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: Container(width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("images/loadergif.gif",width: 150,height: 150),SizedBox(height: 30,),
          Text("Generating Radio Code...",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

          SizedBox(height: 150,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => HomeScreen()), (Route route) => false);
              },
              child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10)),
                child :Text(
                  'Home',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),  SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Text("(Note :- Admin will send you code in some time , you can tap on home button and check on oder history when radio code will generate.))",style: TextStyle(fontSize: 15,),),
          ),
        ]),
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
}
