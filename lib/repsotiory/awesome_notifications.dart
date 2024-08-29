import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:galleryproject999666333/contsants/constants.dart';
import 'package:galleryproject999666333/main.dart';
import 'package:galleryproject999666333/screens/home_screen.dart';
class AwesomeNotificationsService{
 static Future<void> initializeNotification() async{
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelGroupKey: "high importance channel",
        channelKey: "high importance channel",
         channelName: "Basic Notifications",
          channelDescription: "Notifications for my app",
          defaultColor: Appconstants.mainthemeColor,
          ledColor: Appconstants.mainforegroundcolor,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
          enableVibration:true,
          enableLights: true
          )
    ],
    channelGroups: [
      NotificationChannelGroup(channelGroupKey: "high importance channel group", channelGroupName: "high importance channel group")
    ],
    debug: true);
    await AwesomeNotifications().isNotificationAllowed().then((value) => 
    (isAllowed) async{
      if(!isAllowed){
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }

    });
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod:onNotificationCreatedMethod ,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod
      );

  }
  static Future<void>onNotificationCreatedMethod(ReceivedNotification receivedNotification)async{
debugPrint("onNotificationCreatedMethod");

  }

   static   Future<void>onNotificationDisplayedMethod(ReceivedNotification receivedNotification)async{
debugPrint("onNotificationDisplayedMethod");

  }
   static   Future<void>onDismissActionReceivedMethod(ReceivedAction recieviedAction)async{
debugPrint("onDismissActionReceivedMethod");
  }
    static  Future<void>onActionReceivedMethod(ReceivedAction recieviedAction)async{
debugPrint("onActionReceivedMethod");
final payload=recieviedAction.payload??{};
if(payload["Navigate"]=="true"){
  MyApp.navigatorkey.currentState?.pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
}

  }
  static Future<void> showNotification({
    required final int id,

    required final String title,
    required final String body,
    final String? summary,
    final Map<String,String>? payload,
    final ActionType actionType=ActionType.Default,
    final NotificationLayout notificationLayout=NotificationLayout.Default,
    final NotificationCategory? category,
    final String?bigpicture,
    final List<NotificationActionButton>? actionButton,
    final bool sheduled=false,
    final int? interval,
  })async{
assert(!sheduled|| (sheduled&&interval!=null));
 await AwesomeNotifications().createNotification(content: 
 NotificationContent(id: id, 
 channelKey:"high importance channel" ,
 title: title,
 body: body,
 actionType: actionType,
 notificationLayout: notificationLayout,
 summary: summary,
 category: category,
 payload: payload,
 bigPicture: bigpicture

 ),
 actionButtons: actionButton,
 schedule: sheduled?
 NotificationInterval(interval: interval,
 timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
 preciseAlarm: true
 ):null


 );


  }
 

}