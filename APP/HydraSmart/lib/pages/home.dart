import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'dart:async';
import 'dart:convert';
import 'package:hydrasmart/pages/HomeScreen.dart';
import 'package:hydrasmart/service/server.dart';
import 'package:flutter/material.dart';
import 'package:hydrasmart/pages/DataModel.dart';
late String motor;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamController<DataModel> _streamController = StreamController();

  @override
  void dispose() {
    _streamController.close();
  }
  Future<void> ini() async{
    final response = await Server.post('getMotor', {});
    final databody = json.decode(response.body);
    motor=databody['con'];
    await Future.delayed(Duration(seconds: 1));
  }
  @override
  void initState() {
    ini();
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      update();
    });
  }

  Future<void> update() async {
    Map body = Map();
    body['motor'] = motor;
    final response = await Server.post('fetch', body);
    final databody = json.decode(response.body);
    DataModel dataModel = DataModel.fromJson(databody);
    _streamController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text('Hydra Smart'),),
      body: Center(
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapdata) {
              switch (snapdata.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator(),);
                default:
                  if (snapdata.hasError) {
                    return Text("Please Wait");
                  } else {
                    return func(snapdata.data!);
                  }
              }
            }
        ),
      ),
    ),);
  }
}

Widget func(DataModel dataModel){
  String temperature=dataModel.temp;
  String humidity=dataModel.hum;
  String moisture=dataModel.mois;
  motor =dataModel.con;
  return  Container(
    color: Colors.black,
    child: Column(
      children: [
        SizedBox(height: 16),
        switch_button(),
        SizedBox(height: 32),
        _buildRoundedCard(
          icon: Icons.thermostat,
          value: temperature + ' °C',
          label: 'Temperature',
          color: Colors.blue,
        ),
        SizedBox(height: 16),
        _buildRoundedCard(
          icon: Icons.water_drop,
          value: humidity + '%',
          label: 'Humidity',
          color: Colors.blue,
        ),
        SizedBox(height: 16),
        _buildRoundedCard(
          icon: Icons.water,
          value: moisture+ '%',
          label: 'Moisture',
          color: Colors.blue,
        ),
      ],
    ),
  );
}

Widget _buildRoundedCard({
  required IconData icon,
  required String value,
  required String label,
  required Color color,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    color: color,
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

class switch_button extends StatefulWidget {

  const switch_button({super.key});

  @override
  State<switch_button> createState() => _switch_buttonState();
}

class _switch_buttonState extends State<switch_button> {
  bool isWaterOn = motor=='true';
  void toggleWaterControl() {
    Vibrate.feedback(FeedbackType.success);
    setState(() {
      isWaterOn = !isWaterOn;
      motor = isWaterOn?'true':'false';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: toggleWaterControl,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isWaterOn ? Colors.red : Colors.blue,
              width: 6,
            ),
          ),
          child: Center(
            child: Text(
              isWaterOn ? 'ON' : 'OFF',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}



























