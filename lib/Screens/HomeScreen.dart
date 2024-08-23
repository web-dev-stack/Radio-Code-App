import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:radio_code/Screens/OrderHistory.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../Utils/Colors.dart';
import '../Utils/apiurl.dart';
import '../modal/carmodal.dart';
import 'RadioCodeGeneratorScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


int indexs=-1;


Carmodal? brands;

bool isLoading = true;


// List<Carmodal?> brands = [
//   // CarBrandObject(id: 0, name: 'Volkswagen', image: 'images/vw.png'),
//   // CarBrandObject(id: 0, name: 'audi', image: 'images/audi.png'),
//   // CarBrandObject(id: 0, name: 'becker', image: 'images/becker.png'),
//   // CarBrandObject(id: 0, name: 'blaupunkt', image: 'images/blaupunkt.png'),
//   // CarBrandObject(id: 0, name: 'bosch', image: 'images/bosch.png'),
//   // CarBrandObject(id: 0, name: 'chrysler', image: 'images/chrysler.png'),
//   // CarBrandObject(id: 0, name: 'dodge', image: 'images/dodge.png'),
//   // CarBrandObject(id: 0, name: 'fiat', image: 'images/fiat.png'),
//   // CarBrandObject(id: 0, name: 'ford', image: 'images/ford.png'),
//   // CarBrandObject(id: 0, name: 'honda', image: 'images/honda.png'),
//   // CarBrandObject(id: 0, name: 'jaguar', image: 'images/jaguar.png'),
//   // CarBrandObject(id: 0, name: 'jeep', image: 'images/jeep.png'),
//   // CarBrandObject(id: 0, name: 'mercedes', image: 'images/mercedes.png'),
//   // CarBrandObject(id: 0, name: 'nissan', image: 'images/nissan.png'),
//   // CarBrandObject(id: 0, name: 'renault', image: 'images/renault.png'),
//   // CarBrandObject(id: 0, name: 'seat', image: 'images/seat.png'),
//   // CarBrandObject(id: 0, name: 'skoda', image: 'images/skoda.png'),
//   // CarBrandObject(id: 0, name: 'toyota', image: 'images/toyota.png'),
//
//   // CarBrandObject(id: 0, name: 'beiben', image: 'images/beiben.png'),
//   // CarBrandObject(id: 0, name: 'bentley', image: 'images/bentley.png'),
//   // CarBrandObject(id: 0, name: 'bharat benz', image: 'images/bharat_benz.png'),
//   // CarBrandObject(id: 0, name: 'bmw', image: 'images/bmw.png'),
//   // CarBrandObject(id: 0, name: 'ferrari', image: 'images/ferrari.png'),
//   // CarBrandObject(id: 0, name: 'gtr', image: 'images/gtr.png'),
//   // CarBrandObject(id: 0, name: 'hino', image: 'images/hino.png'),
//   // CarBrandObject(id: 0, name: 'jeep', image: 'images/jeep.png'),
//   // CarBrandObject(id: 0, name: 'lotus', image: 'images/lotus.png'),
//   // CarBrandObject(id: 0, name: 'mazda', image: 'images/mazda.png'),
//   // CarBrandObject(id: 0, name: 'nissan', image: 'images/nissan.png'),
//   // CarBrandObject(id: 0, name: 'subaru', image: 'images/subaru.png'),
//   // CarBrandObject(id: 0, name: 'tesla', image: 'images/tesla.png'),
// ];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getcar();
  }
  List brand=[];

  Future<Carmodal?>   getcar()async{
    print("apicall");
  var headers = {
    'Accept': 'application/json'
  };
  var request = await http.get(Uri.parse('${baseurl}/api/car-models'),
  headers: headers,
  );
   

  if (request.statusCode == 200) {
    var res=json.decode(request.body);
    brand=res['data'];
setState(() {
  isLoading = false;
});
    print("object ${brand} ${request.statusCode}");
  }
  else {
    setState(() {
      isLoading = false;
    });
  print(request.reasonPhrase);
  }

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


  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: headerView(),
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
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
    );
  }

  Widget headerView() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topLeft,
          height: 280 ,
          decoration:   const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)),
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
            gradient:  RadialGradient(
              center: Alignment.bottomCenter,
              stops: [0.1, 0.8],
              colors: [
                Colors.deepPurple,
                Colors.black,

              ],
              radius: 1.0,
            )
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(top: 40),
                      height: 33,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
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
                              style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(5),
                    //   margin: const EdgeInsets.only(top: 40),
                    //   height: 33,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.white),
                    //       borderRadius: BorderRadius.circular(5)),
                    //   child: InkWell(
                    //
                    //     child: Row(
                    //       children: [
                    //         Icon(
                    //           Icons.person,
                    //           color: Colors.white,
                    //           size: 20,
                    //         ),
                    //         const Padding(padding: EdgeInsets.only(left: 5)),
                    //         Text(
                    //           'Login',
                    //           style: TextStyle(fontSize: 16,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.white),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                 Padding(padding: EdgeInsets.only(top: 25)),
                 Column(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                      'Car radio code',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width/12),
                ),
                     Text(
                       'generator.',
                       style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: MediaQuery.of(context).size.width/12),
                     ),
                     SizedBox(height: 15,),
                     Text(
                       'Car radio code retrieval made easy. All you need is your radio serial number.',
                       style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.normal,
                           fontSize: MediaQuery.of(context).size.width/22),
                     ),
                   ],
                 )
              ],
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                top: 250, left: 15, right: 15),
            child:isLoading == true?Padding(
              padding: EdgeInsets.only(top: 60),
              child: SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
            ): GridView.count(
crossAxisSpacing: 20,
              childAspectRatio: 0.73,
              mainAxisSpacing: 25,
              padding: EdgeInsets.only(bottom: 10),
              physics: NeverScrollableScrollPhysics(),shrinkWrap: true, crossAxisCount: 3,     children: List.generate(brand.length, (index) {
              return InkWell(
                onTap: () {
                  indexs=brand[index]['id'];
                  setState(() {});
                  Future.delayed(const Duration(seconds: 1),(){
                    debugPrint("=======${brand[index]['id']}  -  ${brand[index]['amount'].toString()} - ${brand[index]['title']}");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RadioCodeGeneratorScreen(
                          id: brand[index]['id'].toString(),

                          amount: double.parse(
                              brand[index]['amount'].toString()),
                          title: brand[index]['title'],),
                      ),
                    );

                    indexs=-1;
                    setState(() {

                    });
                  });
                },
                child:  Container(
                  height: MediaQuery.of(context).size.width / 3.4,
                  width: MediaQuery.of(context).size.width / 3.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                        const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child:indexs==brand[index]['id']? Center(
                    child: SpinKitFadingCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      },
                    ),
                  )  : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child:  Container(
                            height: MediaQuery.of(context).size.height / 10,
                            width: MediaQuery.of(context).size.width / 7,
                            child: Image(
                              image: NetworkImage("${baseurl}${brand[index]['img_path']}"),
                            ),
                          )),SizedBox(height: 5,),
                      Center(child: Text(brand[index]['title'],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.width/23),textAlign: TextAlign.center,))
                    ],
                  ),
                ),
              );
            }),)

        ),

      ],
    );
  }
}
