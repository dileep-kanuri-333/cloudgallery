import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:galleryproject999666333/screens/home_screen.dart';
import 'package:get/get.dart';

final navigatorKey=GlobalKey<NavigatorState>();

Future<void>handleBackgroundMeassage(RemoteMessage message)async{
  if(message==null) return;
print("Title:${message.notification?.title}");
print("Title:${message.notification?.body}");
print("Title:${message.data}");
// if(message == null)return;
// navigatorKey.currentState?.pushNamed("LoginScreen",arguments: message);
}

class PushNotifcations{
  final firebasemessaging=FirebaseMessaging.instance;
handleMeassage(RemoteMessage? message){
  if(message==null) return;
print("Title:${message.notification?.title}");
print("Title:${message.notification?.body}");
print("Title:${message.data}");
// if(message == null)return;
// navigatorKey.currentState?.pushNamed("LoginScreen",arguments: message);
}
initpushnotification(){
  firebasemessaging.getInitialMessage().then(handleMeassage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMeassage);
     FirebaseMessaging.onBackgroundMessage(handleBackgroundMeassage);

}

  Future<void> initNotification() async{
     await firebasemessaging.requestPermission();
     final Fcmtoken=await firebasemessaging.getToken();
     print(Fcmtoken);
     FirebaseMessaging.onBackgroundMessage((message) => handleBackgroundMeassage(message));
  }

}
//c9PpTNq1SxWOFhQk-rMoJZ:APA91bFD-_AkV80qs44lBVhFqtsdxUc5e7nou5Ji3qHH_zrEDRv9QBjsTuk5Z64uvsLyBdvgMWcCMUWXqtZUuGpVyNTByIoI2XQlD6rDIni28Fl5oCdUCN-ovsWmZrW_3vHJldzsM7Ds