import 'package:flutter_local_notifications/flutter_local_notifications.dart';
int notificationcount=0;
class LocalNotifications{
  final FlutterLocalNotificationsPlugin notificationsPlugin=FlutterLocalNotificationsPlugin();
Future<void> initNotification() async{
 AndroidInitializationSettings initializationSettingsAndriod=const AndroidInitializationSettings("@mipmap/ic_launcher");
 var initializationSettings=InitializationSettings(android: initializationSettingsAndriod);
 await notificationsPlugin.initialize(initializationSettings,
 onDidReceiveNotificationResponse: (NotificationResponse notificationResponse)async{});
}
 notificationDetails(){
  return const NotificationDetails(
    android: AndroidNotificationDetails('2','channel name',playSound: true,enableVibration: true,importance: Importance.max,),
  );
 }

 Future showNotification({required int id,String? title,String? body})async{
  // int newId = notificationcount++;
  
  return notificationsPlugin.show(id, title, body,await notificationDetails());
  
 }
}