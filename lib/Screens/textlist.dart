import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils/Colors.dart';

int index1 = 0;
int index2 = 0;

Map placeholder = {
  "Nissan": [
    "DW24N15914",
    "HP72N00146",
    "DW3BN2677621BH30D",
    "2123412",
    "4231427",
    "BP538971326067",
    "PN3001PA0029117",
    "CL048820059582"
  ],
  "volkswagen": [
    "SEZ1Z3H3231155",
    "SKZAZ3F4301489",
    "VWZGZ1T2630162",
    "AUZ1Z3G6855326",
    "VWZ6Z7K6262095",
  ],
  "Audi": [
    "AUZ1Z3L2279459",
    "AUZBZ7H4113638",
    "AUZ4Z1K1116324",
    "AUZ2Z3C1219975"
  ],
  "jeep": [
    "T00AM2324R0582",
    "T30QN125214003",
    "T19QN254304284",
    "T0MYD332923332",
    "TM9302701589",
    "TZ1AA0533R0104"
  ],
  "Chrysler": [
    "T00AM2324R0582",
    "T30QN125214003",
    "T19QN254304284",
    "T0MYD332923332",
    "TM9302701589",
    "TZ1AA0533R0104"
  ],
  "Skoda": ["SKZ1Z7E5141443", "SKZ7Z3G0089708", "SKZ1Z2K8399775"],
  "volvo": ["89FKSFB1120410042", "89FKSFB1120430041"],
  "Dacia": [
    "X7LASREA757004504",
    "VF6MF000064258609",
    "UU1HSDADG53084082",
    "93Y4SRZ85LJ236027"
  ],
  "Ford": [
    "C73F047A123456",
    "BP051577002888",
  ],
  "Honda": ["25001425", "40314252", "11324128", "503214", "601452", "93GB0142"],
  "Fiat": ["BP5385751912211", "815CM2330D2697724", "A2C9629930000012102"],
  "Seat": ["SEZ2Z9G2213299", "SEZAZ1L7833098", "SEZ1Z3M5044448"],
  "Mercedes Benz": ["AL2910Y0104000"],
  "Renault": ["VF1CNJ60551131919","VF15RH20A59787071"],
  "Dodge": ["T30QN208316224", "A2C94848489393"],
  "vauxhall": [
    "8923428",
    "2135321"
  ],
  "Blaupunkt":[
    "BP030144360404",
    "BP1029A0211125"
  ]
};

Map radioimage = {
  "Nissan": [
    "images/nissan1.jpeg",
    "images/nissan2.jpeg",
    "images/nissan3.jpeg",
    "images/nissan4.jpeg"
  ],
  "vauxhall": [
    "images/nissan1.jpeg",
    "images/nissan2.jpeg",
    "images/nissan3.jpeg",
    "images/nissan4.jpeg"
  ],
  "volkswagen": ["images/volkswagen.jpeg"],
  "Audi": ["images/audi.jpeg"],
  "Dodge": ["images/dodge.jpeg"],
  "jeep": ["images/jeep.jpeg"],
  "Chrysler": ["images/chrysler.jpeg"],
  "Skoda": ["images/skoda.jpeg"],
  "volvo": ["images/volvo.jpeg"],
  "Dacia": ["images/dacia.jpeg"],
  "Srod": ["images/frod.jpeg"],
  "Honda": ["images/honda2.jpeg", "images/honda.jpeg"],
  "Fiat": ["images/fiat.jpeg", "images/fiat2.jpeg"],
  "Seat": ["images/seat1.jpg"],
  "Mercedes Benz": ["images/Mersedes.jpeg"],
  "Renault": ["images/Renault.jpeg"],
  "Ford": ["images/frod.jpeg", "images/frod2.jpeg", "images/frod3.jpeg"],
};
Map radiohelp = {
  "volkswagen": [
    "There are different types of VW radios but all of them need to be removed to find your serial number. Once you have removed the radio, find your VW serial number by looking for a code starting with VWZ  an example of this would be VWZ1Z2H1234567 and ensuring your VW serial is correct is essential in retrieving the correct code for your radio. Make sure you can tell the difference between a capitalized I and a 1, as this can lead to getting an incorrect code."
  ], //0

  "Nissan": [
    "Your Nissan Serial Number On The Label If the radio has been removed you will need to locate the radios label, which is on the top or side of the radios casing. In the example photos, we have highlighted the required information.",
    "When ON, the radio display will show CODE. Enter 3 incorrect codes into the system, pressing 'OK' to confirm each. Upon the third attempt, your radio will show 'system is locked for 60 minutes' & display the information needed to decode your radio. You need the 'Serial number', 'Device number' and 'Date'. this will show on the",
    "Turn the ignition switch ON. ADIO CODE' will show on-screen. Enter an incorrect code 3x times. For example, enter 1-2-3-4. The 'Serial number', 'Part number' and 'Date' will display on the radio.See image for reference.",
    "Turn the ignition switch ON.ADIO CODE' will show on-screen. Enter an incorrect code 3x times. For example, enter 1-2-3-4. The 'Serial number', 'Part number' and 'Date' will display on the radio. See image for reference."
  ], //1
  "vauxhall": [
    "Your Nissan Serial Number On The Label If the radio has been removed you will need to locate the radios label, which is on the top or side of the radios casing. In the example photos, we have highlighted the required information.",
    "When ON, the radio display will show CODE. Enter 3 incorrect codes into the system, pressing 'OK' to confirm each. Upon the third attempt, your radio will show 'system is locked for 60 minutes' & display the information needed to decode your radio. You need the 'Serial number', 'Device number' and 'Date'. this will show on the",
    "Turn the ignition switch ON. ADIO CODE' will show on-screen. Enter an incorrect code 3x times. For example, enter 1-2-3-4. The 'Serial number', 'Part number' and 'Date' will display on the radio.See image for reference.",
    "Turn the ignition switch ON.ADIO CODE' will show on-screen. Enter an incorrect code 3x times. For example, enter 1-2-3-4. The 'Serial number', 'Part number' and 'Date' will display on the radio. See image for reference."
  ],

  "Audi": [
    "There are different types of Audi  radios but all of them need to be removed to find your serial number.Once you have removed the radio, find your AUDI serial number by looking for a code starting with AUZ  an example of this would be AUZ1Z3G1234218 and ensuring your Seat serial is correct is essential in retrieving the correct code for your radio. Make sure you can tell the difference between a capitalized I and a 1, as this can lead to getting an incorrect code.",
  ], //2

  "jeep": [
    "The serial is printed on a label stuck on the casing of the stereo itself and begins with T and is 14 digits and letters long. Example: T00AM394958584 2013+ model serial numbers beginning A2C for example: *A2C94848489393 Chrysler Jeep serials begin with 'T', below are some popular examples:   TQ	TD	TH	T16   T00AM	TZ	 TM9	T19 TC	TB	TVP	T0MY T82",
  ], //3

  "Ford": [
    "Ford 6000 CD 2004+  Hold down the buttons 1 & 6 together.The radio will cycle through a series of different numbers on the display. Your serial will begin with “V” followed by six digits.If the serial does not show, the radio will need to be removed from the dash, and the serial is printed on the back of the stereos casing. Serial number example: V223456",
    "Ford 6000 CD 2004+  Hold down the buttons 1 & 6 together.The radio will cycle through a series of different numbers on the display. Your serial will begin with “V” followed by six digits.If the serial does not show, the radio will need to be removed from the dash, and the serial is printed on the back of the stereos casing. Serial number example: V223456",
    "Ford 6000 CD 2004+  Hold down the buttons 1 & 6 together.The radio will cycle through a series of different numbers on the display. Your serial will begin with “V” followed by six digits.If the serial does not show, the radio will need to be removed from the dash, and the serial is printed on the back of the stereos casing. Serial number example: V223456",
  ], //4

  "Chrysler": [
    "The serial is printed on a label stuck on the casing of the stereo itself and begins with T and is 14 digits and letters long. Example:  T30QN208316224 2013+ model serial numbers beginning A2C for example: *A2C94848489393 Chrysler Jeep dodge  serials begin with 'T', below are some popular examples: TQ	TD	TH	T16   T00AM	TZ	 TM9	T19 TC	TB	TVP	T0MY T82"
  ], //5
  "": [
    "First the radio must be removed to get access to the serial number on the back. Once removed a 17(C7) or 14(BP) digit serial will be on the label this is the serial needed to unlock your radio.Serial number example: C73F047A123456  BP051577002888",
  ], //6

  "Dacia": [
    "The registration number or VIN uniquely identifies your car and is located in one or more of the following places: under the windshield at the bottom of the driver's side, in the driver's door jam or on the steering column. Sample of a valid VIN: UU1HSDADG53084082",
  ], //7

  "volvo": [
    "Find the serial number required to calculate your Volvo truck radio code on the sticker attached to the unit side. You can see this number below the barcode, starting with 89F plus 13 characters. Example: 89FKSFB112065005. Note that you must remove the radio to see this label.",
  ], //8

  "Skoda": [
    "Once you have removed the radio, find your Skoda serial number by looking for a code starting with SKZ  an example of this would be SKZ1Z2G1321426 and ensuring your Seat serial is correct is essential in retrieving the correct code for your radio. Make sure you can tell the difference between a capitalized I and a 1, as this can lead to getting an incorrect code."
  ],
  //9

  "Seat": [
    "There are different types of Seat radios but all of them need to be removed to find your serial number. Once you have removed the radio, find your SEAT serial number by looking for a code starting with SEZ  an example of this would be SEZ1Z2G1234145 and ensuring your Seat serial is correct is essential in retrieving the correct code for your radio. Make sure you can tell the difference between a capitalized I and a 1, as this can lead to getting an incorrect code"
  ],
  //10

  "Honda": [
    "Honda Radio Serial Number On Screen Hold the preset buttons 1 & 6, whilst turning ON your radio. The 8 digit serial number will appear on the display. Some models display with 'U' followed by 4 digits, then 'L' followed by 4 numbers. For example, the screen could show 250014231. (this may be split into two screens). Copy all the information from the display as this is needed to decode your radio.",
    "To find your Honda serial number, you will need to remove the radio using radio release keys. Press the keys into place with pressure, then the unit will free from the dashboard. Once the radio is removed you will need to locate the label, this is on the top or side of the casing.",
  ], //11

  "Fiat": [
    "Removing a Fiat radio is easy and requires no technical skill.First, you need radio release keys to remove the radio, these are for sale online or from a local Halfords store. Push the keys into either side of the radio, this will free the unit to be taken out. Once you have the radio release keys, push them into the 4 holes in each corner of the radio See image. Apply a little pressure and the radio will release from the dashboard. The radios label will be located on the radio’s casing",
  ],
  "Mercedes Benz": [
    "The Mercedes Audio 10 radio serial number starts with either AL or MF and is 14 digits long. For example AL 2910 Y 01 04000 This is usually on the back of the radio, engraved underneath a white label. Please see the image for reference."
  ],

  "Travelpilot": [
    "First the radio must be removed to get access to the serial number on the back. Once removed a 17(C7) or 14(BP) digit serial will be on the label this is the serial needed to unlock your radio.",
  ],

  "Renault": [
    "The registration number or VIN uniquely identifies your car and is located in one or more of the following places: under the windshield at the bottom of the driver's side, in the driver's door jam or on the steering column. Sample of a valid VIN: VF14SFAP449541321"
  ],

  "Dodge": [
    "The serial is printed on a label stuck on the casing of the stereo itself and begins with T and is 14 digits and letters long. Example:  T30QN208316224 2013+ model serial numbers beginning A2C for example: *A2C94848489393 Chrysler Jeep dodge  serials begin with 'T', below are some popular examples: TQ	TD	TH	T16   T00AM	TZ	 TM9	T19 TC	TB	TVP	T0MY T82"
  ],

  "Frod": [
    "on the display Your serial will begin with “V” followed by six digits. If the serial does not show, the radio will need to be removed from the dash, and the serial is printed on the back of the stereos casing. Serial number example: V223456",
    "The serial number can be found by removing your radio and locating the sticker label on the side. Identify the serial number beginning with M and followed by six digits, for example, M123456. Your radio can then be unlocked with the official code via this info",
    "First the radio must be removed to get access to the serial number on the back. Once removed a 17(C7) or 14(BP) digit serial will be on the label this is the serial needed to unlock your radio."
  ], //12
};


Map howToGetRadioCodeWidget = {
  "volkswagen":Column(children: [SizedBox(height: 10,),
    Text("Recover your code by the radio serial number,which you can find for volkswagen, by removing the radio.",style: TextStyle(fontSize: 17)),
    Container(
      height: 200,
      width: 300,
      child: Image.asset(
        "images/volkswagen.jpeg",fit: BoxFit.fill,
      ),
    ),
    RichText(
        text: TextSpan(
            text: 'The serial number for a VW radio ',
            style: TextStyle(color: Colors.black,fontSize: 17),
            children: const [
              TextSpan(
                  text: 'starts with VWZ ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'letter and its ',
                  style: TextStyle(
                      fontSize: 17

                  )),
              TextSpan(
                  text: '14 chars long. ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'Somethings there may be a digit or a letter at the end, case in which you can ignore it.',
                  style: TextStyle(
                      fontSize: 17

                  ))
            ])),
    SizedBox(height: 20,)
  ],),
  "Honda":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),
      RichText(
          text: TextSpan(
              text: 'Recover your code by the ',
              style: TextStyle(color: pureBlackColor,fontSize: 16),
              children: const [
                TextSpan(
                    text: 'radio serial number, ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16

                    )),
                TextSpan(
                    text: 'which you can find on the radio screen or label.',
                    style: TextStyle(
                        fontSize: 16

                    )),
              ])),SizedBox(height: 15,),
      const Text("Find serial on screen",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),SizedBox(height: 10,),
      const Text(
        'If your Honda radio is newer than 2001, you can get the serial number without removing the radio. To do this, turn on the unit and make sure you read "CODE". Then press and hold buttons 1 and 6 simultaneously for several seconds. Depending on the model, the serial displays in different ways. Some radios display an eight-digit number, while others alternate the serial number split into two pieces. Example: U2039 on one screen and L0290 on the next. The serial number would then be U2039L0290.',style: TextStyle(fontSize: 16),),

      SizedBox(height: 15,),
      SizedBox(
        height: 120,
        width: 300,
        child: Image.asset(
          "images/honda2.jpeg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 15,),
      const Text("Find serial on the label.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      SizedBox(height: 10,),
      const Text(
        'If your radio is old or the first method did not work, you have to take out the radio to see the serial. Once outside, locate the number on the label attached to the side of the unit. A valid Honda serial number is usually made up of 8 digits with two or three letters on the front. Some series are only made up of 7 digits, while others start with M and are made up of different numbers and letters. Please note that radios made in Japan are not compatible with online unlocking.',style: TextStyle(fontSize: 16),),
      SizedBox(height: 15,),
      SizedBox(
        height: 100,
        width: 300,
        child: Image.asset(
          "images/honda.jpeg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 15,),
      const Text("Finding Honda Accura navigation.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      SizedBox(height: 10,),
      const Text(
        'Sometimes you can find the serial number and activation code on a sticker on the box. if you can not find yours, then follow this procedure to see the number:',style: TextStyle(fontSize: 16),),

      Container(margin: EdgeInsets.only(left: 25),
        child: Column(children: [
          SizedBox(height: 15,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("• ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Expanded(
                child:                         const Text(
                  'Turn off or make sure your navigation is OFF.',style: TextStyle(fontSize: 16),),
              ),
            ],
          ),SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("• ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Expanded(
                child:                         const Text(
                  'With one hand, press and hold the SEEK (SEEK/SKIP) and CH(CH/DISC) button.',style: TextStyle(fontSize: 16),),
              ),
            ],
          ),SizedBox(height: 5,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("• ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Expanded(
                child:                         const Text(
                  'With the other hand, press the power button.',style: TextStyle(fontSize: 16),),
              ),
            ],
          ),SizedBox(height: 5,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("• ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Expanded(
                child:                         const Text(
                  'The serial number that appears on the screen is generally divided into two pieces. Example: U1233 and L3829',style: TextStyle(fontSize: 16),),
              ),
            ],
          ),

        ],),
      ),
      const SizedBox(height: 20,)
    ],),
  "Mercedes Benz":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),
      RichText(
          text: TextSpan(
              text: 'Recover your code by the ',
              style: TextStyle(color: pureBlackColor,fontSize: 16),
              children: const [
                TextSpan(
                    text: 'radio serial number, ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16

                    )),
                TextSpan(
                    text: 'which you can find by removing your radio. Depending on the radio model, there are a few serial number formats. See the next photos as reference.',
                    style: TextStyle(
                        fontSize: 16

                    )),
              ])),SizedBox(height: 15,),

      SizedBox(
        height: 100,
        width: 300,
        child: Image.asset(
          "images/Mersedes.jpeg",fit: BoxFit.fill,
        ),
      ),
      const SizedBox(height: 20,)
    ],),
  "Seat":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),
      Text("Recover your code by the radio serial number,which you can find for seat, by removing the radio.",style: TextStyle(fontSize: 17)),
      SizedBox(height: 20,),
      SizedBox(
        height: 150,
        width: 300,
        child: Image.asset(
          "images/seat1.jpg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 20,),
      RichText(
          text: TextSpan(
              text: 'The serial number for a Seat radio',
              style: TextStyle(color: pureBlackColor,fontSize: 16),
              children: const [
                TextSpan(
                    text: 'starts with SEZ ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16

                    )),
                TextSpan(
                    text: 'letter and it is ',
                    style: TextStyle(
                        fontSize: 16

                    )),
                TextSpan(
                    text: '14 chars long.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16

                    )),
                TextSpan(
                    text: 'Sometimes there may be a digit or a letter at the end, case in which you can ignore it.',
                    style: TextStyle(
                        fontSize: 16

                    )),
              ])),SizedBox(height: 15,),


      const SizedBox(height: 20,)
    ],),
  "Fiat":Column(children: [SizedBox(height: 10,),

    RichText(
        text: TextSpan(
            text: 'Recover your code by the ',
            style: TextStyle(color: Colors.black,fontSize: 17),
            children: const [
              TextSpan(
                  text: 'radio serial number,',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'which you can find by removing your radio. Depending on the radio model, there are a few serial number formats. See the next photos as references.',
                  style: TextStyle(
                      fontSize: 17

                  )),

            ])),SizedBox(height: 15,),
    Container(
      height: 100,
      width: 300,
      child: Image.asset(
        "images/fiat.jpeg",fit: BoxFit.fill,
      ),
    ),SizedBox(height: 15,),
    Container(
      height: 100,
      width: 300,
      child: Image.asset(
        "images/fiat2.jpeg",fit: BoxFit.fill,
      ),
    ),
    SizedBox(height: 20,)
  ],),
  "Nissan":Column(children: [SizedBox(height: 10,),
    Text("You can get the code for your radio from radio serial number.",style: TextStyle(fontSize: 17)),SizedBox(height: 15,),
    const Text("Where can i find the serial number?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
    SizedBox(height: 10,),
    RichText(
        text: TextSpan(
            text: 'if you have a touch-screen unit, enter the code ',
            style: TextStyle(color: Colors.black,fontSize: 17),
            children: const [
              TextSpan(
                  text: '1111 ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'three times. The unit gets locked for 60 min while displaying the info needed to decode.',
                  style: TextStyle(
                      fontSize: 17

                  )),

            ])),SizedBox(height: 15,),
    Container(
      height: 130,
      width: 300,
      child: Image.asset(
        "images/nissan1.jpeg",fit: BoxFit.fill,
      ),
    ),SizedBox(height: 15,),
    Text("If your unit is made by Daewoo (like the one in the photo below), the process is the same as above.",style: TextStyle(fontSize: 17)),

    SizedBox(height: 15,),
    Container(
      height: 130,
      width: 300,
      child: Image.asset(
        "images/nissan2.jpeg",fit: BoxFit.fill,
      ),
    ),  SizedBox(height: 15,),
    RichText(
        text: TextSpan(
            text: 'If you have an older unit, it is needed to pull it out in order to see the serial. The serial starts with',
            style: TextStyle(color: Colors.black,fontSize: 17),
            children: const [
              TextSpan(
                  text: ' CL,PN,PP or BP.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
            ])),SizedBox(height: 15,),     Container(
      height: 130,
      width: 300,
      child: Image.asset(
        "images/nissan3.jpeg",fit: BoxFit.fill,
      ),
    ),  SizedBox(height: 15,),Container(
      height: 130,
      width: 300,
      child: Image.asset(
        "images/nissan4.jpeg",fit: BoxFit.fill,
      ),
    ),
    SizedBox(height: 20,)
  ],),
  "vauxhall":Column(children: [SizedBox(height: 10,),
    Text("You can get the code for your radio from radio serial number.",style: TextStyle(fontSize: 17)),SizedBox(height: 15,),
    const Text("Where can i find the serial number?",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
    SizedBox(height: 10,),
    RichText(
        text: TextSpan(
            text: 'if you have a touch-screen unit, enter the code ',
            style: TextStyle(color: Colors.black,fontSize: 17),
            children: const [
              TextSpan(
                  text: '1111 ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'three times. The unit gets locked for 60 min while displaying the info needed to decode.',
                  style: TextStyle(
                      fontSize: 17

                  )),

            ])),SizedBox(height: 15,),
    Container(
      height: 150,
      width: 300,
      child: Image.asset(
        "images/ic_vauxhall.jpg",fit: BoxFit.fill,
      ),
    ),

    SizedBox(height: 20,)
  ],),
  "Audi":Column(children: [SizedBox(height: 10,),
    Text("Recover your code by the radio serial number, which you can find for Audi, by removing the radio.",style: TextStyle(fontSize: 17)),SizedBox(height: 15,),
    SizedBox(height: 15,),
    Container(
      height: 130,
      width: 300,
      child: Image.asset(
        "images/audi.jpeg",fit: BoxFit.fill,
      ),
    ),SizedBox(height: 15,),
    RichText(
        text: TextSpan(
            text: 'The serial number for a Audi radio ',
            style: TextStyle(color: Colors.black,fontSize: 17),
            children: const [
              TextSpan(
                  text: 'starts with AUZ or 014AUZ ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'letters and it is ',
                  style: TextStyle(
                      fontSize: 17

                  )),
              TextSpan(
                  text: '14 chars long. ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'Sometimes there may be a digit or a letter at the end, case in which you can ingore it.',
                  style: TextStyle(
                      fontSize: 17

                  )),

            ])),
    SizedBox(height: 20,)
  ],),
  "jeep":Column(children: [SizedBox(height: 10,),

    RichText(
        text: TextSpan(
            text: 'Recover your code by the ',
            style: TextStyle(color: Colors.black,fontSize: 17),
            children: const [
              TextSpan(
                  text: 'radio serial number. ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'which you can find by removing your radio. Depending on the radio model, there are a few serial number formats. See the next photos as reference.',
                  style: TextStyle(
                      fontSize: 17

                  )),


            ])),SizedBox(height: 15,),
    Container(
      height: 130,
      width: 300,
      child: Image.asset(
        "images/jeep.jpeg",fit: BoxFit.fill,
      ),
    ),
    SizedBox(height: 20,)
  ],),
  "Chrysler":Column(children: [SizedBox(height: 10,),

    RichText(
        text: TextSpan(
            text: 'Recover your code by the ',
            style: TextStyle(color: Colors.black,fontSize: 17),
            children: const [
              TextSpan(
                  text: 'radio serial number. ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 17

                  )),
              TextSpan(
                  text: 'which you can find by removing your radio. Depending on the radio model, there are a few serial number formats. See the next photos as reference.',
                  style: TextStyle(
                      fontSize: 17

                  )),


            ])),SizedBox(height: 15,),
    Container(
      height: 130,
      width: 300,
      child: Image.asset(
        "images/chrysler.jpeg",fit: BoxFit.fill,
      ),
    ),
    SizedBox(height: 20,)
  ],),
  "Ford":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),
      Text("Ford 6000 CD 2004+  Hold down the buttons 1 & 6 together.The radio will cycle through a series of different numbers on the display. Your serial will begin with “V” followed by six digits.If the serial does not show, the radio will need to be removed from the dash, and the serial is printed on the back of the stereos casing. Serial number example:",style: TextStyle(fontSize: 17)),SizedBox(height: 5,),
      const Text("V223456",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),SizedBox(height: 15,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/frod.jpeg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 10,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/frod2.jpeg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 10,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/frod3.jpeg",fit: BoxFit.fill,
        ),
      ),


      SizedBox(height: 20,)
    ],) ,
  "Renault":Column (
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),

      Text("You can get the code fpr your radio from the VIN or from the serial number of the radio.",style: TextStyle(fontSize: 17)),SizedBox(height: 10,),
      const Text("Where can i find the VIN?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),SizedBox(height: 10,),
      Text("There are a few places where you can find the VIN: under the windshield at the bottom of the driver's side, in the driver's door jam or on the steering column. Sample of a valid VIN:",style: TextStyle(fontSize: 17)),SizedBox(height: 5,),
      const Text("VF14SRAP449541701",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),SizedBox(height: 15,),


      const Text("Where can i find the serial number?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),SizedBox(height: 10,),
      Text("Pull the radio out of the centre console. you're going to see the label attched to the box's side. You can locate the serial number below the barcode. A renault serial number can be longer or shorter, but it always ends with a letter +3 digit as a general rule. The only exception would be in cases where the serial number starts with BP.",style: TextStyle(fontSize: 17)),
      SizedBox(height: 10,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/Renault.jpeg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 12,),
      SizedBox(height: 20,)
    ],),
  "Dacia":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),

      Text("You can get the code for your radio from the VIN or from the serial number of the radio.",style: TextStyle(fontSize: 17)),SizedBox(height: 10,),
      const Text("Where can i find the VIN?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),SizedBox(height: 10,),
      Text("The registration number or VIN uniquely identifies your car and is located in one or more of the following places: under the windshield at the bottom of the driver's side, in the driver's door jam or on the steering column. Sample of a valid VIN:",style: TextStyle(fontSize: 17)),SizedBox(height: 5,),
      const Text("UU1HSDADG53084082",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),SizedBox(height: 15,),


      const Text("Where can i find the serial number?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),SizedBox(height: 10,),
      Text("Pull the radio out of the centre console. you're going to see the label attched to the box's side. You can locate the serial number below the barcode. A renault serial number can be longer or shorter, but it always ends with a letter +3 digit as a general rule. The only exception would be in cases where the serial number starts with BP.",style: TextStyle(fontSize: 17)),
      SizedBox(height: 10,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/dacia.jpeg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 12,),
      SizedBox(height: 20,)
    ],),
  "volvo":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),

      Text("Recover your code by the radio serial number, which you can find for Volvo, by removing the radio.",style: TextStyle(fontSize: 17)),SizedBox(height: 15,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/volvo.jpeg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 15,),
      RichText(
          text: TextSpan(
              text: 'The serial number ',
              style: TextStyle(color: Colors.black,fontSize: 17),
              children: const [
                TextSpan(
                    text: 'starts with 89 ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 17

                    )),
                TextSpan(
                    text: "and it's ",
                    style: TextStyle(
                        fontSize: 17

                    )),
                TextSpan(
                    text: '16 chars long.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 17

                    )),

              ])),

      SizedBox(height: 20,)
    ],),
  "Skoda":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),

      Text("Recover your code by the radio serial number, which you can find for Skoda, by removing the radio.",style: TextStyle(fontSize: 17)),SizedBox(height: 15,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/skoda.jpeg",fit: BoxFit.fill,
        ),
      ),SizedBox(height: 15,),
      RichText(
          text: TextSpan(
              text: 'The serial number for a Skoda radio',
              style: TextStyle(color: Colors.black,fontSize: 17),
              children: const [
                TextSpan(
                    text: 'starts with SKZ ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 17

                    )),
                TextSpan(
                    text: "letters and it's ",
                    style: TextStyle(
                        fontSize: 17

                    )),
                TextSpan(
                    text: '14 chars long. ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 17

                    )),
                TextSpan(
                    text: "Sometimes there may be a digit or a letter at the end, case in which you can ignore it.",
                    style: TextStyle(
                        fontSize: 17

                    )),

              ])),

      SizedBox(height: 20,)
    ],),
  "Dodge":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),
      RichText(
          text: TextSpan(
              text: 'Recover your code by the ',
              style: TextStyle(color: Colors.black,fontSize: 17),
              children: const [
                TextSpan(
                    text: 'radio serial number, ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 17

                    )),
                TextSpan(
                    text: "which you can find by removing your radio. Depending on the radio model, there are a few serial number formats. See the next photos as reference.",
                    style: TextStyle(
                        fontSize: 17
                    )),

              ])),SizedBox(height: 15,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/dodge.jpeg",fit: BoxFit.fill,
        ),
      ),


      SizedBox(height: 20,)
    ],),
  "Blaupunkt":Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [SizedBox(height: 10,),
      RichText(
          text: TextSpan(
              text: 'Recover your code by the ',
              style: TextStyle(color: Colors.black,fontSize: 17),
              children: const [
                TextSpan(
                    text: 'radio serial number, ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 17

                    )),
                TextSpan(
                    text: "which you can find by removing your radio. Depending on the radio model, there are a few serial number formats. See the next photos as reference.",
                    style: TextStyle(
                        fontSize: 17
                    )),

              ])),SizedBox(height: 15,),
      Container(
        height: 130,
        width: 300,
        child: Image.asset(
          "images/bluepnkit_image.jpeg",fit: BoxFit.fill,
        ),
      ),


      SizedBox(height: 20,)
    ],)
};

Map doesRadioRetrievalCost = {
  "volkswagen":Text(
    'Volkswagen codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),

  "Honda":Text(
    'Honda codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Mercedes Benz":Text(
    'Mercedes Benz codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Seat":Text(
    'Seat codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Fiat":Text(
    'Fiat codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Audi":Text(
    'Audi codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "jeep":Text(
    'jeep codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Chrysler":Text(
    'Chrysler codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Ford":Text(
    'Ford codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Dacia":Text(
    'Dacia codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "volvo":Text(
    'volvo codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Skoda":Text(
    'Skoda codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Dodge":Text(
    'Dodge codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),),
  "Blaupunkt":Text(
    'Blaupunkt codes are obtained through an official system, which makes it impossible to provide them for free. However, prices are minimal, and depending on the country from which you buy, they vary from 8 to 12 euros.',style: TextStyle(fontSize: 16),)


};

Map howFastYourService = {
  "volkswagen":Text(
    'Lightning fast! Volkswagen codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),

  "Honda":Text(
    'Lightning fast! Honda codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Mercedes Benz":Text(
    'Lightning fast! Mercedes Benz codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Seat":Text(
    'Lightning fast! Seat codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Fiat":Text(
    'Lightning fast! Fiat codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Audi":Text(
    'Lightning fast! Audi codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "jeep":Text(
    'Lightning fast! jeep codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Chrysler":Text(
    'Lightning fast! Chrysler codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Ford":Text(
    'Lightning fast! Ford codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Dacia":Text(
    'Lightning fast! Dacia codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "volvo":Text(
    'Lightning fast! volvo codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Skoda":Text(
    'Lightning fast! Skoda codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Dodge":Text(
    'Lightning fast! Dodge codes are provided instantly after payment.',style: TextStyle(fontSize: 16),),
  "Renault":Text(
    'Lightning fast! Renault codes are provided instantly after payment. As exception, if you unlock from VIN it may take up to a few hours in receiving the code.',style: TextStyle(fontSize: 16),),
  "Nissan":Text(
    'We are very fast. The code is supplied in a few minutes after completing the payment. In some cases it may takes up to a few hours.',style: TextStyle(fontSize: 16),),
  "vauxhall":Text(
    'We are very fast. The code is supplied in a few minutes after completing the payment. In some cases it may takes up to a few hours.',style: TextStyle(fontSize: 16),),
  "Blaupunkt":Text(
    'We are very fast. The code is supplied in a few minutes after completing the payment. In some cases it may takes up to a few hours.',style: TextStyle(fontSize: 16),)




};
