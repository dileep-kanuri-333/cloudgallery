import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galleryproject999666333/contsants/constants.dart';
import 'package:galleryproject999666333/provider/gallery_controller.dart';
import 'package:galleryproject999666333/screens/home_screen.dart';
import 'package:galleryproject999666333/services/image_slider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DeletedImages extends ConsumerStatefulWidget {
  String id;

   DeletedImages({super.key,required this.id});

  @override
  ConsumerState<DeletedImages> createState() => _DeletedImagesState();
}

class _DeletedImagesState extends ConsumerState<DeletedImages> {
  
late StreamSubscription<QuerySnapshot<Map<String,dynamic>>> subscription; 

  List<DocumentSnapshot<Map<String, dynamic>>> documentslistdeleted=[];

@override
  void initState() {
    super.initState();
subscribeToSubCollection2(widget.id);
    // 
    
  }



   void subscribeToSubCollection2(String usId) {
    // String userId =id; 
      final galprov=ref.watch(galleryProvider);
   galprov.isStartLoadingforDeletedImg=true;
    CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");
    DocumentReference mainDocumentRef = mainCollection.doc(usId);
    Query<Map<String, dynamic>> subCollection = mainDocumentRef.collection('deletedimages');

    subscription = subCollection.snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      setState(() {
        documentslistdeleted= snapshot.docs;
      });
   galprov.isStartLoadingforDeletedImg=false;

    }, onError: (error) {
      
      Get.snackbar("error", "");
    });
  }
  
  @override
  Widget build(BuildContext context) {
      final galprov=ref.watch(galleryProvider);

             documentslistdeleted.sort((a, b) => b['time'].compareTo(a['time']));
           documentslistdeleted.sort((a, b) => b['date'].compareTo(a['date']));
                Map<String, List<DocumentSnapshot>> groupedDocuments = Appconstants.groupDocumentsByDate( documentslistdeleted);
    return Scaffold(
      appBar:AppBar(
        title:const Text("Deleted Images",style:TextStyle(fontSize: 19)) ,
        centerTitle: true,
        backgroundColor: Appconstants.mainthemeColor,
        foregroundColor: Appconstants.mainforegroundcolor,
      ) , 
      body: 
   galprov.isStartLoadingforDeletedImg?Center(child: CircularProgressIndicator()):

      widget.id.isEmpty?


      Center(child: Container(
        child:const Center(child: Center(child: CircularProgressIndicator())),)):
    Container(
    child:
    documentslistdeleted.isEmpty
          ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Icon(Icons.delete_outline_outlined,size: 99,)),
             Text("no deleted images",style: TextStyle(fontSize: 23,color: Colors.grey),)
            ],
          )
          : 
         Column(
           children: [
          
                // istries?const Center(child: LinearProgressIndicator(),):const Text(""),
                      //  isSharingfav?const Center(child: LinearProgressIndicator(),):const Text(""),

             Expanded(
               child: ListView.builder(
                          itemCount: groupedDocuments.length,
                          itemBuilder: (context, index) {                        
                            String date = groupedDocuments.keys.elementAt(index);
                            List<DocumentSnapshot> documentsForDate = groupedDocuments[date]!;
                           
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
                                    String proz= documentsForDate[index]["deletedurl"];
                                    int m=index;
                                    
                // final isFavorite = _isFavorite(pro["Favorites"]);
                                   
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageSlider(imageslist: documentsForDate,index: m,name:"deletedurl" ,)));
                                        },
                                        onLongPress: (){
                                          //  isdownloading?Fluttertoast.showToast(msg: "downloading is still in progress..."):
                                          // isSharingfav?Fluttertoast.showToast(msg: "Sharing is still in progress..."): 
                                          showModalBottomSheet(
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
                              leading:const Icon(Icons.restore,color: Colors.grey,),
                              title: const Text('restore'),
                              onTap: (){
                              
                                restoredeletedimage(pro["time"], pro["date"], pro["deletedurl"], pro["folder"], pro["time"]);
                                deleteImagepermenantly(pro["time"]);
                //                   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                // content: Text('removed from favourties'),
                //        ),);
               
                                Navigator.pop(context);
                                
                              },
                            ),
                                                        ListTile(
                              leading:const Icon(Icons.delete_forever,color: Colors.red,),
                              title: const Text('delete permanently'),
                              onTap: (){
                              
                                
                                deleteImagepermenantly1(pro["time"]);
                //                   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                // content: Text('removed from favourties'),
                //        ),);
               
                                Navigator.pop(context);
                                
                              },
                            ),
        
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
                                          child: Center(
                                                                          child: CachedNetworkImage(
                                                                          imageUrl: pro["deletedurl"],
                                                                        placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
                                                                        errorWidget: (context, url, error) =>const Icon(Icons.network_check),
                                            ),
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
         ),) ,
    );
  }

  Future<void> deleteImagepermenantly(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection("images").doc(widget.id).collection('deletedimages').doc(documentId).delete();
      // update(
      //   {'url': "",
      //   "deletedurl":url
      //   });
        // Fluttertoast.showToast(msg: "deleted successfully");

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to delete image'),
        ),
      );
    }
  }
    Future<void> deleteImagepermenantly1(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection("images").doc(widget.id).collection('deletedimages').doc(documentId).delete();
      // update(
      //   {'url': "",
      //   "deletedurl":url
      //   });
        Fluttertoast.showToast(msg: "deleted permanently");

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to delete image'),
        ),
      );
    }
  }
     Future<void> restoredeletedimage(String documentId,date,imagurls,folder,time)async{
      
try {
    // String epoch = DateTime.now().millisecondsSinceEpoch.toString();
      // DateTime now = DateTime.now();
     
    // Extract only the date part
    // String formattedDate = "${now.year}-${now.month}-${now.day}";

    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(widget.id).collection('subcol');

      await imageSubCollection.doc(documentId).set(
           {  "user": widget.id,
      'date': date,
      'url': imagurls,
      "folder": folder,
      "time": time,
      }
        );
        Fluttertoast.showToast(msg: "restored successfully");

    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to restore'),
        ),
      );
    }
  }
    //   await FirebaseFirestore.instance.collection("images").doc(id).set({
    //   "profile":"",
    //   'Name': "",
    //   "gender":"",
    //   "age":"",
    //   'phone nujmber': id,
    //   "gmail": "",
    //   "last edited ": ""
    // });

    // CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('subcol');

    // await imageSubCollection.doc(epoch).set({
    //   "user": id,
    //   'date': dateController.text,
    //   'url': imageUrl,
    //   "folder": selectedfolder,
    //   "time": epoch,
      

    // }).then((value) => Fluttertoast.showToast( msg: "image uploaded successfully"));
}