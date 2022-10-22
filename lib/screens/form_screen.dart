import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/Charitylist_screen.dart';
import 'package:us_states/us_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormScreen extends StatefulWidget {
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool _govtSupported = true;
  bool _fundraisingOrganization = true;
  String _chosenStateValue;
  String _city = "";
  String _scopeofWork;
  String _sortResults;
  String _categoryName;
  bool _ratedCharities = true;
  var categoryIds = <String, int> {"Any": 0, "Animals": 1, "Art, Culture and Humanties": 2,"Community Development": 3, "Education": 4, 
  "Environment": 5, "Health": 6, "Human and Civil Rights": 7, "Human Services": 8, "International": 9, "Religion": 10,"Research and Public Policy": 11};
  bool _loading = true;
  
  initState() {
      super.initState();
      _RetrieveData();
  }

  // Store the data in sharedpref
  Future<void> _storeData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('state', _chosenStateValue == null? "" : _chosenStateValue);
      prefs.setString('city', _city == null? "" : _city);
      prefs.setString('scopeofWork', _scopeofWork == null? "ALL" : _scopeofWork);
      prefs.setString('sortResults', _sortResults == null? "RATING:DESC" : _sortResults + ":DESC");
      prefs.setBool('ratedCharities', _ratedCharities == null ? true : _ratedCharities);
      prefs.setBool('govtSupported', _govtSupported == null? true : _govtSupported);
      prefs.setBool('fundraisingOrganization', _fundraisingOrganization == null? true: _govtSupported);
      int categoryID = categoryIds[_categoryName];
      prefs.setInt('categoryID', _categoryName == null? 0: categoryID);
    });
   
  }

    // Store the data in sharedpref
  Future<void> _RetrieveData() async {
    final prefs = await SharedPreferences.getInstance();

      _chosenStateValue= prefs.getString('state');
      _city = prefs.getString('city');
      _scopeofWork = prefs.getString('scopeofWork');
  
      _sortResults = prefs.getString('sortResults').split(":")[0];
      _ratedCharities = prefs.getBool('ratedCharities');
      _govtSupported = prefs.getBool('govtSupported');
      _fundraisingOrganization = prefs.getBool('fundraisingOrganization');
      int _categoryId = prefs.getInt('categoryID');
      _categoryName = ( _categoryId== 0) ? null : categoryIds.entries.firstWhere((element) => element.value == _categoryId).key;

       setState(() {
      _loading = false;
    });

  }

  
  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    if(_loading) return CircularProgressIndicator();
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome to Charity Finder"),
        ),
        body: (GridView.count(crossAxisCount: 1, children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[         
                DropdownButton<String>(
                    value: _chosenStateValue,
                    items: [
                      "AL", "AK","AZ", "AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA",
                      "MI","MN", "MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI", "SC","SD", "TN","TX",
                      "UT", "VT", "VA", "WA","WV","WI","WY",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose a STATE",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                          _chosenStateValue = value;
                      });
                    }),
                TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter City name [Optional]',
                    ),
                    initialValue: _city,
                    onChanged: (text) {
                      setState(() {
                        _city = text;
                      });
                    }),

                DropdownButton<String>(
                    value: _scopeofWork,
                    items: [
                      "ALL",
                      "REGIONAL",
                      "NATIONAL",
                      "INTERNATIONAL",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose Scope",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        if (value!= null) 
                        _scopeofWork = value; 
                        else
                        _scopeofWork = "ALL";
                      });
                    }),
           /*
                _buildSwitchListTile(
                  "No Govt Support",
                  "Show only charities that do not receive government support.",
                  _govtSupported,
                  (newValue) {
                    setState(
                      () {
                        _govtSupported = newValue;
                      },
                    );
                  },
                ),*/
                _buildSwitchListTile(
                  "Fundraising Organizations",
                  "Show only charities that are fundraising organizations.",
                  _fundraisingOrganization,
                  (newValue) {
                    setState(
                      () {
                        _fundraisingOrganization = newValue;
                      },
                    );
                  },
                ),
                 _buildSwitchListTile(
                  "Rated Charities",
                  "Show only rated charities",
                  _ratedCharities,
                  (newValue) {
                    setState(
                      () {
                        _ratedCharities = newValue;
                      },
                    );
                  },
                ),
                DropdownButton<String>(
                    value: _categoryName,
                    items: [
                      "Animals", // 1
                      "Art, Culture and Humanties", //2
                      "Community Development", // 3
                      "Education", //4
                      "Environment", //5
                      "Health", // 6
                      "Human and Civil Rights", // 7
                      "Human Services", // 8
                      "International", //9
                      "Religion", //10
                      "Research and Public Policy", //11
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        if (value != null) {
                          _categoryName = value;
                        } else {
                          _categoryName = "Any";
                        }
                      });
                    }),/*
                DropdownButton<String>(
                    value: _sortResults,
                    items: [
                      "NAME",
                      "RATING",
                      "RELEVANCE",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "How do you want results sorted",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        if(value != null)
                        _sortResults = value; else
                        _sortResults = "RATING";
                      });
                    }),*/
                    ElevatedButton(
                        onPressed: ()  {
                          setState(() {
                            _storeData();
                            Navigator.of(context).pushNamed(CharityList.routeName);
                          });
                        },
                        child: const Text('Submit'),
                      ),
                    
              ])
        ])));
  }
}

