import 'package:calculator1/buttons.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', '*',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent[100],
      body:

      Column(
        children: <Widget>[

          Expanded(
            child:  TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }));
              },
              child: const Text('Go to: KM-MILE CONVERTER'),
            ),
          ),
          Expanded(
            flex: 2,


            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}


// KILOMETER - MILE CONVERTER

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextStyle labelStyle = TextStyle(
    color: Colors.blue,
    fontSize: 20.0,
  );
  final TextStyle resultSyle = TextStyle(
    color: Colors.red,
    fontSize: 30.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _measures = ['Kilometers', 'Miles'];

  double _value = 1.0;
  String _fromMeasures = 'Kilometers';
  String _toMeasures = 'Miles';
  String _results = "";

  final Map<String, int> _measuresMap = {
    'Kilometers': 0,
    'Miles': 1,
  };

  dynamic _conversionMultipliers = {
    '0': [1, 0.621371],
    '1': [1.60934, 1],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Padding(
        padding: const EdgeInsets.all(15.0),
        child:

        Column(
          children: [
        Center(
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
         child: const Text('Go to: CALCULATOR'),
       ),),

            //  INPUT VALUE
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter the value of unit you wish to convert from:',
              ),
              onChanged: (value) {
                setState(() {
                  _value = double.parse(value);
                });
              },
            ),
            SizedBox(height: 30.0),

            //  CONVERTING UNITS
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'FROM',
                      style: labelStyle,
                    ),
                    DropdownButton(
                      items: _measures
                          .map((String value) => DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _fromMeasures = value!;
                        });
                      },
                      value: _fromMeasures,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('TO', style: labelStyle),
                    DropdownButton(
                      items: _measures
                          .map((String value) => DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _toMeasures = value!;
                        });
                      },
                      value: _toMeasures,
                    )
                  ],
                ),
              ],
            ),

            // CONVERTING
            MaterialButton(
              minWidth: double.infinity,
              onPressed: _convert,
              child: Text(
                'CONVERT',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 25.0),
            Text(
              _results,
              style: resultSyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Conversion and Display
  void _convert() {
    print('Button Pressed');
    print(_value);

    if (_value != 0 && _fromMeasures.isNotEmpty && _toMeasures.isNotEmpty) {
      int from = _measuresMap[_fromMeasures]!;
      int to = _measuresMap[_toMeasures]!;

      var multiplier = _conversionMultipliers[from.toString()][to];

      setState(() {
        _results =
        "$_value $_fromMeasures = ${_value * multiplier} $_toMeasures";
      });
    } else {
      setState(() {
        _results = "Please enter an integer";
      });
    }
  }
}