import 'package:flutter/material.dart';
import './screens/homescreen.dart';
import './screens/form_screen.dart';
import './screens/Charitylist_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Charity Finder',
      home: MyHomePage(title: 'Charity Finder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charity Finder',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyMedium: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            titleLarge: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),

      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => HomeScreen(),
        CharityList.routeName: (ctx) => CharityList(),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);

        return MaterialPageRoute(
          builder: (ctx) => FormScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => FormScreen(),
        );
      },
    );
  }
}
