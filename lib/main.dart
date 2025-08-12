import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s_lab/theme_provider.dart';

import 'home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'S-Lab | The Student Platform',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

// import 'package:flutter/material.dart';
//
// import 'home_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'S-Lab | The Student Platform',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.black,
//         primaryColor: Colors.white,
//         textTheme: Theme.of(context).textTheme.apply(
//               bodyColor: Colors.white,
//               displayColor: Colors.white,
//             ),
//         fontFamily: 'Montserrat',
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const HomePage(),
//     );
//   }
// }
