import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location_tracking/pages/global/global.dart';
import 'package:location_tracking/pages/login.dart';

class GoogleMap1 extends StatefulWidget {
  const GoogleMap1({super.key});

  @override
  State<GoogleMap1> createState() => _HomeState();
}

class _HomeState extends State<GoogleMap1> {
  User? user = FirebaseAuth.instance.currentUser;
  Position? position;
  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  bool isSatellite = false;
  bool isLive = false;

  List checkInData = [
    {
      "online": "",
      "LatLangIn": "",
    },
  ];
  List checkOutData = [
    {"offline": "", "LatLangOut": ""},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Google Map"),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        getLocation();
                        isSatellite = !isSatellite;
                      });
                    },
                    icon: Icon(Icons.satellite_alt_rounded)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false);
                      });
                    },
                    icon: Icon(Icons.logout))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: isSatellite ? MapType.satellite : MapType.normal,
                      initialCameraPosition:
                          CameraPosition(target: LatLng(37.4234, -122.08395)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: isLive
                                  ? null
                                  : () {
                                      setState(() {
                                        isLive = !isLive;
                                        checkInData.add({
                                          "online": (DateFormat('hh:mm:ss')
                                              .format(DateTime.now())),
                                          "LatLangIn":
                                              "${(position!.latitude).toStringAsFixed(2)},${(position!.longitude).toStringAsFixed(2)}",
                                        });
                                      });
                                    },
                              child: Text("CheckIn")),
                          ElevatedButton(
                              onPressed: !isLive
                                  ? null
                                  : () {
                                      setState(() {
                                        isLive = !isLive;
                                        checkOutData.add({
                                          "offline": (DateFormat('hh:mm:ss')
                                              .format(DateTime.now())),
                                          "LatLangOut":
                                              "${(position!.latitude).toStringAsFixed(2)},${(position!.longitude).toStringAsFixed(2)}",
                                        });
                                      });
                                    },
                              child: Text("CheckOut")),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Online"),
                      Text("LatLng"),
                      Text("Offline"),
                      Text("LatLng")
                    ],
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Row(children: [
                    Expanded(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: checkInData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${checkInData[index]["online"]}"),
                                  Text("${checkInData[index]["LatLangIn"]}"),
                                ],
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: checkOutData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${checkOutData[index]["offline"]}"),
                                  Text("${checkOutData[index]["LatLangOut"]}"),
                                ],
                              ),
                            );
                          }),
                    ),
                  ]),
                ],
              ),
            )));
  }
}
