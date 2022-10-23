import 'dart:async';
import 'dart:convert';
import 'package:flutter_complete_guide/screens/form_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/CharityDetail.dart';

final String appId = "4768fa0a";
final String appKey = "b4e6d7ba2f006fd5af0f1dcc810fc9ec";
Future<void> launchTarget(String url) async {
  if (await canLaunch(url))
    await launch(url);
  else
    throw "Could not launch";
}

Future<List<CharityDetail>> fetchCharities() async {
  final prefs = await SharedPreferences.getInstance();
  String Urlbuild =
      'https://api.data.charitynavigator.org/v2/Organizations?app_id=$appId&app_key=$appKey';

  // Add State
  String stateselected = prefs.getString('state');
  if (stateselected != null && stateselected.isNotEmpty) {
    Urlbuild += '&state=$stateselected';
  }

  // Add City
  String city = prefs.getString('city');
  if (city != null && city.isNotEmpty) {
    Urlbuild += '&city=$city';
  }

  // Add scopeofWork
  String scopeofWork = prefs.getString('scopeofWork');
  if (scopeofWork != null && scopeofWork.isNotEmpty) {
    Urlbuild += '&scopeofWork=$scopeofWork';
  }

  bool ratedCharities = prefs.getBool('ratedCharities');
  if (ratedCharities != null) {
    Urlbuild += '&rated=$ratedCharities';
  }

  String sort = prefs.getString('sortResults');
  if (sort != null && sort.isNotEmpty) {
    Urlbuild += '&sort=$sort';
  }

  bool noGovSupport = prefs.getBool('govtSupported');
  if (noGovSupport != null) {
    Urlbuild += '&noGovSupport=$noGovSupport';
  }

  bool fundRaisingOrgs = prefs.getBool('fundraisingOrganization');
  if (fundRaisingOrgs != null) {
    Urlbuild += '&fundRaisingOrgs=$fundRaisingOrgs';
  }

  int categoryID = prefs.getInt('categoryID');
  if (categoryID != 0) {
    Urlbuild += '&catergoryID=$categoryID';
  }

  print(Urlbuild);
  final response = await http.get(Uri.parse(Urlbuild));
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List jsonResponse = jsonDecode(response.body);

    return jsonResponse.map((job) => new CharityDetail.fromJson(job)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Charity Data');
  }
}

class CharityList extends StatefulWidget {
  const CharityList({Key key}) : super(key: key);
  static const String routeName = "CharitlyList";

  @override
  State<CharityList> createState() => _CharityListState();
}

class _CharityListState extends State<CharityList> {
  Future<List<CharityDetail>> futureCharities;
  initState() {
    super.initState();
    futureCharities = fetchCharities();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charity List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
         floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(FormScreen.routeName);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.settings),
      ),
        appBar: AppBar(
          title: const Text('Selected Charities'),
        ),
        body: Center(
          child: FutureBuilder<List<CharityDetail>>(
            future: futureCharities,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Scrollbar(
                        thumbVisibility: true,
                        thickness: 9.0,
                        child: GridView.builder(
                            itemCount: snapshot.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 2,
                            ),
                            itemBuilder: (BuildContext context, int i) {
                              return Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                        child: Column(
                                      children: <Widget>[
                                        Text(snapshot.data[i].charityName,
                                            style: GoogleFonts.archivoBlack(
                                                textStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 40, 81, 228),
                                              fontSize: 25,
                                            )),
                                            textAlign: TextAlign.center),
                                        Text(snapshot.data[i].tagLine,
                                            style: GoogleFonts.robotoCondensed(
                                                textStyle: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            )),
                                            textAlign: TextAlign.center),
                                        Text(
                                          snapshot.data[i].cause.causeName,
                                          style: GoogleFonts.workSans(
                                              textStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            backgroundColor: Color.fromARGB(
                                                145, 119, 147, 199),
                                          )),
                                        ),
                                        Image.network(snapshot.data[i]
                                            .currentRating.ratingimage.large),
                                        ElevatedButton(
                                            onPressed: () async {
                                              await launchTarget(snapshot
                                                  .data[i].charityNavigatorURL);
                                            },
                                            child: Text(
                                              "More",
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              )),
                                            ))
                                      ],
                                    )),
                                  ),
                                ),
                              );
                            })));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
