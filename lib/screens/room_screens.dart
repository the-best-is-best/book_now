// import 'package:book_now/component/appBar_component.dart';
// import 'package:flutter/material.dart';

// class RoomScreen extends StatelessWidget {
// final houseName;

//   const RoomScreen({required this.houseName});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: buildAppBar("Rooms - $houseName", null),
//        body: Center(
//           child: SingleChildScrollView(
//             child: Container(
//               width: myHousesWatch.tabIndex == 0
//                   ? MediaQuery.of(context).size.width / 1.1
//                   : null,
//               height: myHousesWatch.tabIndex == 0
//                   ? MediaQuery.of(context).size.height / 2
//                   : null,
//               child: Card(
//                 elevation: 20,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: myHousesWatch.tabsWidget[myHousesWatch.tabIndex],
//                 ),
//               ),
//             ),
//           ),
//         ),
//     );
//   }
// }
