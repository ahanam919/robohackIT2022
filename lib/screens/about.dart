import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Chariy Finder About',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: 
    Scaffold(
        appBar: AppBar(
          title: Text("Charity Finder About"),
        ),
        body: Center(
            child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              SizedBox(height: 140, width: 40),
              Text(
                  "This page is dedicated to Charity Navigator(CN). I would not have been able to make this app without their API, and thank them graciously. You can find them at www.charitynavigator.org. ",
                  style: GoogleFonts.archivoBlack(
                      textStyle: TextStyle(
                    color: Color.fromARGB(233, 10, 92, 140),
                    fontSize: 25,
                    height: 1.75,
                  )),
                  textAlign: TextAlign.center),
            ]))));
  }
}
