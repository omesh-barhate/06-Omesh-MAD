import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'myInput.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      title: "Experiment 8",
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final start = TextEditingController();
  final end = TextEditingController();
  bool isVisible = false;
  List<LatLng> routepoints = [LatLng(52.05884, -1.345583)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Routing',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[600],
      ),
      backgroundColor: Colors.blueGrey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                myInput(controller: start, hint: 'Enter Start location'),
                SizedBox(
                  height: 15,
                ),
                myInput(controller: end, hint: 'Enter End location'),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[500]),
                    onPressed: () async {
                      List<Location> start_l =
                          await locationFromAddress(start.text);
                      List<Location> end_l =
                          await locationFromAddress(end.text);

                      var v1 = start_l[0].latitude;
                      var v2 = start_l[0].longitude;
                      var v3 = end_l[0].latitude;
                      var v4 = end_l[0].longitude;

                      var url = Uri.parse(
                          'http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full');
                      var response = await http.get(url);
                      print(response.body);
                      setState(() {
                        routepoints = [];
                        var ruter = jsonDecode(response.body)['routes'][0]
                            ['geometry']['coordinates'];
                        for (int i = 0; i < ruter.length; i++) {
                          var reep = ruter[i].toString();
                          reep = reep.replaceAll("[", "");
                          reep = reep.replaceAll("]", "");
                          var lat1 = reep.split(',');
                          var long1 = reep.split(",");
                          routepoints.add(LatLng(
                              double.parse(lat1[1]), double.parse(long1[0])));
                        }
                        isVisible = !isVisible;
                        print(routepoints);
                      });
                    },
                    child: Text(
                      'Press',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 500,
                  width: 400,
                  child: Visibility(
                    visible: isVisible,
                    child: FlutterMap(
                      options: MapOptions(
                        center: routepoints[0],
                        zoom: 10,
                      ),
                      nonRotatedChildren: [
                        AttributionWidget.defaultWidget(
                            source: 'OpenStreetMap contributors',
                            onSourceTapped: null),
                      ],
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        PolylineLayer(
                          polylineCulling: false,
                          polylines: [
                            Polyline(
                                points: routepoints,
                                color: Colors.blue,
                                strokeWidth: 9)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
