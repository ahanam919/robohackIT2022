import 'package:flutter/material.dart';
import 'package:us_states/us_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormScreen extends StatefulWidget {
  @override
  State<FormScreen> createState() => _FormScreenState();
  //final Function saveFilters;
  //final Map<String, bool> currentFilters;

  //FormScreen(this.currentFilters, this.saveFilters);
}

class _FormScreenState extends State<FormScreen> {
  bool _dPP = false;
  bool _govtSupported = false;
  bool _fundraisingOrganization = false;
  
  initState() {
    // _dPP = widget.currentFilters['DPP'];
    //_govtSupported = widget.currentFilters['govtsupported'];
    //_fundraisingOrganization = widget.currentFilters['fundraisingorganization'];
    super.initState();
  }

  // Store the data in sharedpref
  Future<void> _storeData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('state', _chosenStateValue == null? "" : _chosenStateValue);
      prefs.setString('city', _city == null? "" : _city);
      prefs.setString('scopeofWork', _scopeofWork == null? "ALL" : _scopeofWork);
      prefs.setString('sortResults', _sortResults == null? "RATING" : _sortResults);
      prefs.setBool('ratedCharities', _ratedCharities == null ? true : _ratedCharities);
      prefs.setBool('dPP', _dPP== null? true:_dPP);
      prefs.setBool('govtSupported', _govtSupported == null? true : _govtSupported);
      prefs.setBool('fundraisingOrganization', _fundraisingOrganization == null? true: _govtSupported);
    });

    print(" Found: " + prefs.getString('state'));
  }

  String _chosenStateValue;
  String _city = "";
  String _scopeofWork;
  String _sortResults;
  String _categoryId;
  bool _ratedCharities;
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
                TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter City name',
                    ),
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
                _buildSwitchListTile(
                  "Donor Privacy Policy",
                  "Show only organizations that have donor privacy policy",
                  _dPP,
                  (newValue) {
                    setState(
                      () {
                        _dPP = newValue;
                      },
                    );
                  },
                ),
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
                ),/*
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
                ),*/
                DropdownButton<String>(
                    value: _categoryId,
                    items: [
                      "Any",
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
                          _categoryId = value;
                        } else {
                          _categoryId = "Any";
                        }
                      });
                    }),
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
                    }),
                    ElevatedButton(
                        onPressed: ()  {
                          setState(() {
                            _storeData();
                          });
                        },
                        child: const Text('Submit'),
                      ),
                    
              ])
        ])));
  }
}

/*
          Container(child: Text("hello2")),
          Container(child: Text("hello3")),
          Container(child: Text("hello")),
          Container(child: Text("hello")),
          Container(child: Text("hello")),
          Container(child: Text("hello")),
          Container(child: Text("hello")),
          Container(child: Text("hello")),*/
