import 'package:hydrasmart/pages/DataModel.dart';
import 'package:hydrasmart/pages/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:hydrasmart/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DataModel dataModel=DataModel.fromJson({
      'temp':'12.5',
      'hum':'112.56',
      'mois':'21.2',
      'con':'true'
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context)=> Home(),
      },
    );
  }
}




