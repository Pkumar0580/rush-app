import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rush/features/auth/screens/splash_screen.dart';
import 'package:rush/utils/navigation.dart';
import 'utils/message.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      title: 'Rush',
      home: const SplashScreen(),
    );
  }
}







// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const  Text('Scrollable Container'),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Container(
//               height: 500, 
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       width: 200, 
//                       color: Colors.red,
//                       child:const Center(child: Text('Item 1')),
//                     ),
//                     Container(
//                       width: 200, 
//                       color: Colors.blue,
//                       child:const Center(child: Text('Item 2')),
//                     ),
//                     Container(
//                       width: 200, 
//                       color: Colors.green,
//                       child:const Center(child: Text('Item 3')),
//                     ),
//                     Container(
//                       width: 200, 
//                       color: Colors.yellow,
//                       child:const Center(child: Text('Item 4')),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
