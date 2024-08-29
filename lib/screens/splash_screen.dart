// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:galleryproject999666333/screens/home_screen.dart';
// import 'package:galleryproject999666333/screens/login_screen.dart';
// import 'package:firebase_core/firebase_core.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     initializeApp();
//   }

//   Future<void> initializeApp() async {
//     // Ensure that Firebase is initialized before navigating to the home or login screen
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//         apiKey: "AIzaSyAYgD43dHoTcQthWAgnbofHM4rOA8Ao5YA",
//         appId: "1:178570104302:android:1a2129ee7de142e7a992ff",
//         messagingSenderId: "178570104302",
//         projectId: "galleryproject999666333",
//         storageBucket: "galleryproject999666333.appspot.com",
//       ),
//     );

//     // Check user login status
//     final bool? isUserLoggedIn = await checkLoginStatus();

//     // Navigate to the appropriate screen
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => isUserLoggedIn == true ? HomeScreen() : LoginScreen(),
//       ),
//     );
//   }

//   Future<bool?> checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isUser');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
