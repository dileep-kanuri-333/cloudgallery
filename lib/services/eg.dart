// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:galleryproject999666333/repsotiory/awesome_notifications.dart';
// import 'package:galleryproject999666333/repsotiory/local_notification.dart';
// import 'package:galleryproject999666333/repsotiory/notifications.dart';
// import 'package:galleryproject999666333/screens/home_screen.dart';
// import 'package:galleryproject999666333/screens/login_screen.dart';
// import 'package:galleryproject999666333/screens/otpverify_screen.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tuple/tuple.dart';
// final themeProvider=StateProvider<bool>((ref) => false);


// void main() async {
//   // Ensure that Firebase is initialized before runApp()
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options:
//      kIsWeb || Platform.isAndroid? 
//      const FirebaseOptions(
//       apiKey:"AIzaSyAYgD43dHoTcQthWAgnbofHM4rOA8Ao5YA", 
//       appId:"1:178570104302:android:1a2129ee7de142e7a992ff", 
//       messagingSenderId: "178570104302",
//       projectId:"galleryproject999666333",
//       storageBucket:"galleryproject999666333.appspot.com")
//       : null
//   );
  
//  LocalNotifications().initNotification();
//  PushNotifcations().initNotification();
//  await AwesomeNotificationsService.initializeNotification();
// //  FirebaseMessaging.onBackgroundMessage((message) => null)
//   runApp(const ProviderScope(child:MyApp())); 
// }

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});
// static GlobalKey<NavigatorState> navigatorkey=GlobalKey<NavigatorState>();
//   @override
//   Widget build(BuildContext context,ref) {
   
//     final isThemeMode=ref.watch(themeProvider);

//     return GetMaterialApp(
//       title: 'Flutter Demo',
//      theme:
//       // ThemeData(
//       // //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
//       isThemeMode?ThemeData.dark():ThemeData.light(),
//       debugShowCheckedModeBanner: false,
//       home: 

//        FutureBuilder(
//         future: checkLoginStatus(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else {
//             if (snapshot.data == true) {
//                                 //  ref.read(themeProvider.notifier).state=true;

//   //  ref.watch(phNoloadingprovider.notifier).state = false;
//   //    ref.read(otploadingprovider.notifier).state = false;

//               return const HomeScreen();}
//             else {
//               return const LoginScreen();
//             }
//           }
//         },
//       ),

  
//     );
//   }
//     Future<bool?> checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? isUser = prefs.getBool('isUser');
//     return isUser;
//   }
//    Future<bool?> checkthemetatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? isUsers = prefs.getBool('isUsers');
//     return isUsers;
//   }

// }
//   //  SharedPreferences prefs = await SharedPreferences.getInstance();
//   // String phoneNumber = prefs.getString('phoneNumber') ?? "";
// //https://firebasestorage.googleapis.com/v0/b/galleryproject333666999.appspot.com/o/images%2F1712141157210241%2F1712141180059?alt=media&token=c9945726-7fe8-44af-baea-ece9650d21fb
// //https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT8IoOgH3riOG0H-lznN5HvPoHPw88EEzhNA&s
// //https://firebasestorage.googleapis.com/v0/b/galleryproject333666999.appspot.com/o/images?alt=media&token=aeaad7e0-ffe9-4ec7-b595-bfff4dfd7c7e
// //  StreamBuilder(
// //       stream: FirebaseAuth.instance.authStateChanges(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return CircularProgressIndicator();
// //         } else {
// //           if (snapshot.hasData) {
// //             return HomeScreen(); 
// //           } else {
// //             return LoginScreen(); 
// //           }
// //         }
// //       },
// //     )



  // Future<void> sharing(prourl)async{
  //       // final shareUrl = pro["url"];
  //       final shareUrl=prourl;
  //   try {
  //     final response = await http.get(Uri.parse(shareUrl));
  //     if (response.statusCode == 200) {
  //       final bytes = response.bodyBytes;

  //       // Check if the response contains valid image data
  //       if (bytes.length == 0) {
  //             Fluttertoast.showToast(msg: "Image data is empty");

  //         Get.snackbar("Error", "Image data is empty");
  //         return;

  //       }

  //       final temp = await getTemporaryDirectory();
  //       final path = '${temp.path}/image.jpg';
  //       await File(path).writeAsBytes(bytes);
  //       final xFile = XFile(path);
  //       await Share.shareXFiles([xFile], text: "Shared by dileep").then((value) => null);
  //     } else {
  //             Fluttertoast.showToast(msg: "Failed to fetch image: ${response.statusCode}");

  //       Get.snackbar("Error", "Failed to fetch image: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //             Fluttertoast.showToast(msg: "Failed to share: ${e.toString()}");

  //     Get.snackbar("Error", "Failed to share: ${e.toString()}");
  //   }
  // }
