import 'package:flutter/material.dart';
import '/screens/form_screen.dart';
import '/screens/about.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charity Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
        appBar: AppBar(
          title: Text("Charity Finder"),
        ),
        body: Center(
            child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              new Padding(padding: const EdgeInsets.symmetric(vertical: 80.0)),
              SizedBox(height: 80, width: 40),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FormScreen()));
                  },
                  child: Text(
                    'Find Charities',
                    style: TextStyle(fontSize: 40),
                  )),
              SizedBox(height: 80, width: 40),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => About()));
                  },
                  child: Text(
                    'Learn',
                    style: TextStyle(fontSize: 40),
                  )),
              SizedBox(height: 50, width: 40)
            ]))));
  }
}
