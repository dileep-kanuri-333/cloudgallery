
// ignore_for_file: use_super_parameters, unnecessary_import
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:galleryproject999666333/repsotiory/awesome_notifications.dart';
import 'package:galleryproject999666333/screens/home_screen.dart';
import 'package:galleryproject999666333/screens/login_screen.dart';
import 'package:galleryproject999666333/services/theme_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
final themeProvider=StateProvider<bool>((ref) => false);


void main() async {
  // Ensure that Firebase is initialized before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
     const FirebaseOptions(
      apiKey:"AIzaSyAYgD43dHoTcQthWAgnbofHM4rOA8Ao5YA", 
      appId:"1:178570104302:android:1a2129ee7de142e7a992ff", 
      messagingSenderId: "178570104302",
      projectId:"galleryproject999666333",
      storageBucket:"galleryproject999666333.appspot.com")
   
  );
  
//  LocalNotifications().initNotification();
//  PushNotifcations().initNotification();
 await AwesomeNotificationsService.initializeNotification();
//  FirebaseMessaging.onBackgroundMessage((message) => null)
   final bool? isUserLoggedIn = await MyApp.checkLoginStatus();
     final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;

  runApp(
    ProviderScope(
      child: MyApp(isUserLoggedIn: isUserLoggedIn,theme: initTheme,),
    ),
  );
}


class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key, required this.isUserLoggedIn,required this.theme}) : super(key: key);
 static GlobalKey<NavigatorState> navigatorkey=GlobalKey<NavigatorState>();
  final ThemeData theme;
  final bool? isUserLoggedIn;

  static Future<bool?> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isUser');
  }

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends  ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final isThemeMode = ref.watch(themeProvider);

       return  ThemeProvider(
          initTheme:widget.theme,
          builder: (p0, theme) => 
         MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            // isThemeMode ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: widget.isUserLoggedIn == true ?const HomeScreen() : const LoginScreen(),
          ),
        );
      },
    );
  }
}

  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  // String phoneNumber = prefs.getString('phoneNumber') ?? "";
//https://firebasestorage.googleapis.com/v0/b/galleryproject333666999.appspot.com/o/images%2F1712141157210241%2F1712141180059?alt=media&token=c9945726-7fe8-44af-baea-ece9650d21fb
//https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT8IoOgH3riOG0H-lznN5HvPoHPw88EEzhNA&s
//https://firebasestorage.googleapis.com/v0/b/galleryproject333666999.appspot.com/o/images?alt=media&token=aeaad7e0-ffe9-4ec7-b595-bfff4dfd7c7e
//  StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else {
//           if (snapshot.hasData) {
//             return HomeScreen(); 
//           } else {
//             return LoginScreen(); 
//           }
//         }
//       },
//     )