import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertDialog Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DialogPage(title: 'AlertDialog Home Page'),
    );
  }
}

class DialogPage extends StatefulWidget {
  DialogPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  List<String> colorList = [
    'Orange',
    'Yellow',
    'Pink',
    'White',
    'Red',
    'Black',
    'Green'
  ];

  Map<String, bool> cityList = {
    'Balagam': false,
    'Bangalore': false,
    'Hyderabad': false,
    'Chennai': false,
    'Delhi': false,
    'Surat': false,
    'Junagadh': false,
    'Porbander': false,
    'Rajkot': false,
    'Pune': false,
  };

  List<String> ringTone = [
    'None',
    'Callisto',
    'Ganymede',
    'Luna',
    'Oberon',
    'Phobos',
    'Rose',
    'Sunset',
    'Wood',
    'Time Up',
    'Spaekle',
    'Pianist',
    'One Step Forward',
    'Basic Bell',
    'Beep Once',
    'Beep Beep',
    'Ice Blue Tone',
    'Rainy Day',
    'Glissando Tone',
  ];

  String selectedRing;
  int _currentIndex = 0;

  Future<String> _askFavColor() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Favorite Color'),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: colorList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(colorList[index]),
                    onTap: () {
                      Navigator.pop(context, colorList[index]);
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  Future<Map<String, bool>> _preLocation() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Preferred Location'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text('Cancle'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, cityList);
                    },
                    child: Text('Done'),
                  ),
                ],
                content: Container(
                  width: double.minPositive,
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cityList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String _key = cityList.keys.elementAt(index);
                      return CheckboxListTile(
                        value: cityList[_key],
                        title: Text(_key),
                        onChanged: (val) {
                          setState(() {
                            cityList[_key] = val;
                          });
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }

  Future<String> _selectRingtone() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState2) {
              return AlertDialog(
                title: Text('Phone Ringtone'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text('CANCEL'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, ringTone[_currentIndex]);
                    },
                    child: Text('OK'),
                  ),
                ],
                content: Container(
                  width: double.minPositive,
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ringTone.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        value: index,
                        groupValue: _currentIndex,
                        title: Text(ringTone[index]),
                        onChanged: (val) {
                          setState2(() {
                            _currentIndex = val;
                          });
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: RaisedButton(
                  child: const Text("Simple List"),
                  onPressed: () async {
                    var fColor = await _askFavColor();
                    print('My favorite is $fColor');
                  },
                )),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: RaisedButton(
                  child: const Text("Checkbox List"),
                  onPressed: () async {
                    var citys = await _preLocation();
                    print("My preferred location");
                    for (String city in citys.keys) {
                      if (citys[city] == true) {
                        print(city);
                      }
                    }
                  },
                )),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: RaisedButton(
                  child: const Text("Radio List"),
                  onPressed: () async {
                    var ring = await _selectRingtone();
                    print('$ring is your default ring tone');
                  },
                )),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
