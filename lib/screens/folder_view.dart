// ignore_for_file: use_build_context_synchronously, unnecessary_cast, must_be_immutable, avoid_unnecessary_containers, prefer_is_empty

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galleryproject999666333/contsants/constants.dart';
import 'package:galleryproject999666333/contsants/video_player_view.dart';
import 'package:galleryproject999666333/contsants/video_thumbnail.dart';
import 'package:galleryproject999666333/screens/home_screen.dart';
import 'package:galleryproject999666333/services/folders_images_slider.dart';
import 'package:galleryproject999666333/services/image_slider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class CameraScreen extends ConsumerStatefulWidget {
  final String  names;
  Map<String, List<DocumentSnapshot>> folderslist;
  List<DocumentSnapshot> foldersimageslist;
  String id;

   CameraScreen({
    super.key,
    required this.names,
    required this.folderslist,
    required this.foldersimageslist,
    required this.id,

  });
 

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  //  String id="";
  List<DocumentSnapshot<Map<String, dynamic>>> documentslist = [];

//    @override
//   void initState() {
//     super.initState();
//     getSavedPhoneNumber().then((savedPhoneNumber) {
//       setState(() {
//         id = savedPhoneNumber;
//       });
    
//     });
//   }

//   Future<String> getSavedPhoneNumber() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('phoneNumber') ?? "";
//   }
//    String formatDate(String date) {
//     DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
//     DateTime now = DateTime.now();
//     DateTime yesterday = now.subtract(const Duration(days: 1));

//     if (parsedDate == DateTime(now.year, now.month, now.day)) {
//       return "Today";
//     } else if (parsedDate == DateTime(yesterday.year, yesterday.month, yesterday.day)) {
//       return "Yesterday";
//     } else {
//       return DateFormat("dd/MM/yyyy").format(parsedDate);
//     }
//   }
//   Map<String, List<DocumentSnapshot>> groupDocumentsByDate(List<DocumentSnapshot> documents) {
//     Map<String, List<DocumentSnapshot>> groupedDocuments = {};
//     for (var document in documents) {
//       String date = document["date"];
//       if (groupedDocuments.containsKey(date)) {
//         groupedDocuments[date]!.add(document);
//       } else {
//         groupedDocuments[date] = [document];
//       }
//     }
//     return groupedDocuments;
//   }
//   void getDataFromSubCollection33(String folderName) {
//   getSubCollectionDocuments33(folderName).listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
//       setState(() {
//         documentslist = snapshot.docs;
//       });
//     }, onError: (error) {
      
//       Get.snackbar("error", "");
//     });
// }
// Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionDocuments33(String folderName) {
//   CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");

//   DocumentReference mainDocumentRef = mainCollection.doc(id);

//    Query<Map<String, dynamic>>  subCollection = mainDocumentRef.collection('subcol').where('folder', isEqualTo: folderName) as Query<Map<String, dynamic>>;

//   return subCollection.snapshots();
// }
  @override
  Widget build(BuildContext context) {
                bool isSharinfolders=ref.watch(sharingProvider);
                bool isdownloading=ref.watch(downloadingProvider);


    return Scaffold(
      appBar:AppBar(
        title:Text(widget.names,style:const TextStyle(fontSize: 19)) ,
        centerTitle: true,
        backgroundColor: Appconstants.mainthemeColor,
        foregroundColor: Appconstants.mainforegroundcolor,
      ) ,
      body: 
     widget.id.isEmpty?


      Center(child: Container(
        
        child:const Center(child: Center(child: CircularProgressIndicator())),)):
    Container(
    child:
     widget.folderslist.isEmpty
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset("assets/images/startuploading.png")),
              Text(("start your ")+ (widget.names)+(" images"),style: const TextStyle(fontSize: 23,color: Colors.grey),)
            ],
          )
          : 
         Column(
           children: [
                       isSharinfolders?const Center(child: LinearProgressIndicator(),):const Text(""),

             Expanded(
               child: ListView.builder(
                          itemCount: widget.folderslist.length,
                          itemBuilder: (context, index) {
                            String date = widget.folderslist.keys.elementAt(index);
                            List<DocumentSnapshot> documentsForDate = widget.folderslist[date]!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                   Appconstants.formatDate(date),
                                    style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics:const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0,
                                  ),
                                  itemCount: documentsForDate.length,
                                  itemBuilder: (context, index) {
                                    final pro = documentsForDate[index];
                                   
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          pro["url"].toString().contains(".mp4")?
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayerScreen(mediaTable: documentsForDate,videoUrl: pro["url"],)))
                                         : Navigator.push(context, MaterialPageRoute(builder: (contex)=>ImageSlider(imageslist: documentsForDate,index: index,name: "url",)));
                                        },
                                        onLongPress: (){
                                          isdownloading?Fluttertoast.showToast(msg: "downloading is still in progress..."):
                                         isSharinfolders?Fluttertoast.showToast(msg: "Sharing is still in progress..."):  showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                       
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                           ListTile(
                                    leading:const Icon(Icons.share,color: Colors.blue,),
                                    title:const Text("share") ,
                                    onTap :()  async{
                   Fluttertoast.showToast(msg: "wait for few secs...").then((value) => ref.read(sharingProvider.notifier).state=true);
                   // sharing(pro["url"]).then((value) => ref.read(sharingProvider.notifier).state=false);
                   Navigator.pop(context);
                   final shareUrl = pro["url"];
                   try {
                     final response = await http.get(Uri.parse(shareUrl));
                     if (response.statusCode == 200) {
                       final bytes = response.bodyBytes;
               
                       // Check if the response contains valid image data
                       if (bytes.length == 0) {
                    Fluttertoast.showToast(msg: "Image data is empty");
               
                // Get.snackbar("Error", "Image data is empty");
                return;
               
                       }
               
                       final temp = await getTemporaryDirectory();
                       final path = '${temp.path}/image.jpg';
                       await File(path).writeAsBytes(bytes).then((value) => ref.read(sharingProvider.notifier).state=false);
                       final xFile = XFile(path);
                       await Share.shareXFiles([xFile], text: "Shared by dileep");
                     } else {
                    Fluttertoast.showToast(msg: "Failed to fetch image: ${response.statusCode}").then((value) =>  ref.read(sharingProvider.notifier).state=false);
               
                      //  Get.snackbar("Error", "Failed to fetch image: ${response.statusCode}");
                     }
                   } catch (e) {
                    Fluttertoast.showToast(msg: "Failed to share: ${e.toString()}").then((value) =>  ref.read(sharingProvider.notifier).state=false);
               
                    //  Get.snackbar("Error", "Failed to share: ${e.toString()}");
                   }
                 },
                                  ),
                                  ListTile(
                                   leading:const Icon(Icons.download,color: Colors.green,),
                                    title:const Text("download") ,
                                    onTap: ()async {
                                       Navigator.pop(context);
                                      //  showLoadingDialog(context); // Show the loading dialog
                                  

  Fluttertoast.showToast(msg: "wait for few secs...").then((value) => ref.read(downloadingProvider.notifier).state=true);
 
  final downloadUrl = pro["url"]; // Assuming pro["url"] contains the download URL

  try {
    final response = await http.get(Uri.parse(downloadUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      // Check if the response contains valid file data
      if (bytes.length == 0) {
        Fluttertoast.showToast(msg: "File data is empty");
        return;
      }

      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/downloaded_file.jpg'; // Replace 'extension' with the appropriate file extension
      await File(path).writeAsBytes(bytes);
      
      // Save the image to the gallery
      await ImageGallerySaver.saveImage(bytes);

      Fluttertoast.showToast(msg: "image downloaded successfully" ).then((value) => ref.read(downloadingProvider.notifier).state=false);
    //  currentPsoition=1;
      // Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Failed to fetch image: ${response.statusCode}");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Failed to download image: ${e.toString()}");
  }
 
    // Navigator.pop(context);

}



                                  )
                            //   ListTile(
                            //   leading:const Icon(Icons.favorite,color: Colors.red,),
                            //   title: Text('Add to favourties'),
                            //   onTap: (){
                            //     updateImage(pro["time"],pro["url"]);
                            //       Navigator.pop(context);
                            //   },
                            // ),
                            
                            // Add more options as needed
                          ],
                        ),
                      ),
                    );
                  },
                          );
                                        },
                                        child: Container(
                                           decoration: BoxDecoration(
                                                    border: Border.all(width: 0.3,color: Colors.grey)
                                                  ),
                                          child:
                                                  pro["url"].toString().contains(".mp4")?
                                                  Stack(children: 
                                                [
                                                  Center(child: VideoThumbnailWidget(videoPath: pro["url"],)),
                                  const  Positioned(
                                        top: 0,
                                        right: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: Icon(Icons.play_arrow_rounded,size: 66,))
                                                  ]
                                                  )  
                                                  :  CachedNetworkImage(
                                        imageUrl: pro["url"],
                                        placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>const Icon(Icons.error),
                                                                          )
                                                                       
                                                    
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
             ),
           ],
         ),)
   
      
    );
  }
//    Future<void> updateImage(String documentId,String favimagurl)async{
      
// try {
//       await FirebaseFirestore.instance.collection("images").doc(widget.id).collection('subcol').doc(documentId).update({"Favorites":favimagurl});
//       ScaffoldMessenger.of(context).showSnackBar(
//        const SnackBar(
//           content: Text('added to favorties'),
//         ),
//       );
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//        const SnackBar(
//           content: Text('Failed to add'),
//         ),
//       );
//     }
//   }
  // Future<void> deleteImage(String documentId) async {
  //   try {
  //     await FirebaseFirestore.instance.collection("images").doc(widget.id).collection('subcol').doc(documentId).delete();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //    const   SnackBar(
  //         content: Text('Image deleted successfully'),
  //       ),
  //     );
  //   } catch (error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //      const SnackBar(
  //         content: Text('Failed to delete image'),
  //       ),
  //     );
  //   }
  // }
}