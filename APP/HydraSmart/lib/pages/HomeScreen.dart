// import 'package:flutter/material.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';
// import 'package:hydrasmart/pages/DataModel.dart';
// class HomeScreen extends StatefulWidget {
//   final DataModel dataModel;
//   const HomeScreen({Key? key}) : super(key: key);
//
//   HomeScreen({required this.dataModel});
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   Widget func(DataModel dataModel)
//   late String temperature;
//   late String humidity;
//   late String moisture;
//   late String con;
//   late bool isWaterOn;
//   _HomeScreenState(){
//       temperature=widget.dataModel.temp;
//       humidity=widget.dataModel.hum;
//       moisture=widget.dataModel.mois;
//       con=widget.dataModel.con;
//       isWaterOn=con=='true';
//   }
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   void toggleWaterControl() {
//     Vibrate.feedback(FeedbackType.success);
//     setState(() {
//       isWaterOn = !isWaterOn;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Smart Home'),
//       ),
//       body: Container(
//         color: Colors.black,
//         child: Column(
//           children: [
//             SizedBox(height: 16),
//             Container(
//               alignment: Alignment.topCenter,
//               child: InkWell(
//                 onTap: toggleWaterControl,
//                 borderRadius: BorderRadius.circular(100),
//                 child: Container(
//                   width: 300,
//                   height: 300,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: isWaterOn ? Colors.red : Colors.blue,
//                       width: 6,
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       isWaterOn ? 'OFF' : 'ON',
//                       style: TextStyle(
//                         fontSize: 48,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 32),
//             _buildRoundedCard(
//               icon: Icons.thermostat,
//               value: temperature + ' °C',
//               label: 'Temperature',
//               color: Colors.blue,
//             ),
//             SizedBox(height: 16),
//             _buildRoundedCard(
//               icon: Icons.water_drop,
//               value: humidity + '%',
//               label: 'Humidity',
//               color: Colors.blue,
//             ),
//             SizedBox(height: 16),
//             _buildRoundedCard(
//               icon: Icons.water,
//               value: moisture+ '%',
//               label: 'Moisture',
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRoundedCard({
//     required IconData icon,
//     required String value,
//     required String label,
//     required Color color,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       color: color,
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Icon(
//               icon,
//               color: Colors.white,
//             ),
//             SizedBox(width: 8),
//             Text(
//               value,
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//             SizedBox(width: 8),
//             Text(
//               label,
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
