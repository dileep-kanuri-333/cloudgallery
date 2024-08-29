// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Appconstants{
//  Color.fromRGBO(90, 75, 138, 1);

static Color mainthemeColor= Colors.deepPurple.shade300; 
//  Color.fromRGBO(105, 89, 158, 1)
 static Color mainforegroundcolor=Colors.white;  

 static Map<String, List<DocumentSnapshot>> groupDocumentsByDate(List<DocumentSnapshot> documents) {
    Map<String, List<DocumentSnapshot>> groupedDocuments = {};
    for (var document in documents) {
      String date = document["date"];
      if (groupedDocuments.containsKey(date)) {
        groupedDocuments[date]!.add(document);
      } else {
        groupedDocuments[date] = [document];
      }
    }
    return groupedDocuments;
  }
  static  String formatDate(String date) {
  DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(const Duration(days: 1));

  if (parsedDate == DateTime(now.year, now.month, now.day)) {
    return "Today";
  } else if (parsedDate == DateTime(yesterday.year, yesterday.month, yesterday.day)) {
    return "Yesterday";
  } else {
    return DateFormat("dd MMM, yyyy").format(parsedDate);
  }
}

//  static Future<void> deleteImage(String id,String documentId) async {
//     try {
//       await FirebaseFirestore.instance.collection("images").doc(id).collection('subcol').doc(documentId).delete();
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//        const SnackBar(
//           content: Text('Image deleted successfully'),
//         ),
//       );
//     } catch (error) {
//       print('Error deleting image: $error');
//       ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//        const SnackBar(
//           content: Text('Failed to delete image'),
//         ),
//       );
//     }
//   }

}
// Color.fromRGBO(196, 135, 198, .3)
//  color: Color.fromRGBO(49, 39, 79, 1),