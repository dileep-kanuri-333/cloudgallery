// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Uploading extends StatefulWidget {
//   const Uploading({super.key});

//   @override
//   State<Uploading> createState() => _UploadingState();
// }

// class _UploadingState extends State<Uploading> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(),
//           Text("Image is Uploading...")
//         ],
//       ),
//     );
//   }
// }
   
// subscribeToSubCollection1(id);
//  void subscribeToSubCollection1(String usId) {
//     String userId =id; 
//     CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");
//     DocumentReference mainDocumentRef = mainCollection.doc(usId);
//     Query<Map<String, dynamic>> subCollection = mainDocumentRef.collection('favorites');

//     subscription = subCollection.snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
//       setState(() {
//         documentslistfav = snapshot.docs;
//       });
//     }, onError: (error) {
      
//       Get.snackbar("error", "");
//     });
//   }



//  Future<void> addImagetofav(String documentId,String favimagurl)async{
      
// try {
//     String epoch = DateTime.now().millisecondsSinceEpoch.toString();
//       DateTime now = DateTime.now();
    
//     // Extract only the date part
//     String formattedDate = "${now.year}-${now.month}-${now.day}";

//     CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('favorites');

//       await imageSubCollection.doc(documentId).set({"Favorites":favimagurl,"time":epoch,"date":formattedDate});
//       ScaffoldMessenger.of(context).showSnackBar(
//        const SnackBar(
//           content: Text('added to favorties successfully'),
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
//     Future<void> removeImagetofav(String documentId,String favimagurl)async{
      
// try {
//     String epoch = DateTime.now().millisecondsSinceEpoch.toString();
//       DateTime now = DateTime.now();
    
//     // Extract only the date part
//     String formattedDate = "${now.year}-${now.month}-${now.day}";

//     CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('favorites');

//       await imageSubCollection.doc(documentId).delete();
//       ScaffoldMessenger.of(context).showSnackBar(
//        const SnackBar(
//           content: Text('added to favorties successfully'),
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





//      favourties(){
//     // final mainlist=documentslist.where((ids) => ids[0]["id"]=id)
//          documentslistfav.sort((a, b) => b['time'].compareTo(a['time']));
//              documentslistfav.sort((a, b) => b['date'].compareTo(a['date']));
//                 Map<String, List<DocumentSnapshot>> groupedDocuments = Appconstants.groupDocumentsByDate(documentslistfav);
//     return 
         
//      id.isEmpty?


//       Center(child: Container(
//         child:const Center(child: Center(child: CircularProgressIndicator())),)):
//     Container(
//     child:
//      documentslist.isEmpty
//           ? Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(child: Image.asset("assets/images/startuploading.png")),
//              const Text("start your gallery",style: TextStyle(fontSize: 23,color: Colors.grey),)
//             ],
//           )
//           : 
//          Column(
//            children: [
//              Expanded(
//                child: ListView.builder(
//                           itemCount: groupedDocuments.length,
//                           itemBuilder: (context, index) {
                         
                          
                         
                           
//                             String date = groupedDocuments.keys.elementAt(index);
//                             List<DocumentSnapshot> documentsForDate = groupedDocuments[date]!;
                           
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                    Appconstants.formatDate(date),
//                                     style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 GridView.builder(
//                                   shrinkWrap: true,
//                                   physics:const NeverScrollableScrollPhysics(),
//                                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 3,
//                                     crossAxisSpacing: 4.0,
//                                     mainAxisSpacing: 4.0,
//                                   ),
//                                   itemCount: documentsForDate.length,
//                                   itemBuilder: (context, index) {
//                                     final pro = documentsForDate[index];
//                                     String proz=documentslist[index]["Favorites"];
//                                     int m=index;
                                    
//                 final isFavorite = _isFavorite(pro["Favorites"]);
                                   
//                                     return Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: InkWell(
//                                         onTap: (){
//                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageSlider(imageslist: documentsForDate,images: proz,index: m,)));
//                                         },
//                                         onLongPress: (){
//                                           showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (BuildContext context) {
//                     return SingleChildScrollView(
//                       child: Container(
                       
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                              ListTile(
//                               leading:const Icon(Icons.share,color: Colors.blue,),
//                               title:Text("share") ,
//                               onTap :() async{
//                                final shareUrl=pro["Favorites"];
// try {
//   final response = await http.get(Uri.parse(shareUrl));
//   if (response.statusCode == 200) {
//     final bytes = response.bodyBytes;
//         if (bytes.length > 10 * 1024 * 1024) {
//       // If the file size is too large, inform the user and exit
//       Navigator.pop(context);
//       Get.snackbar("File Size is too Long", "For sharing");
//       return;
//     }
//     final temp=await getTemporaryDirectory();
//     final path='${temp.path}/image.jpg';
//     File(path).writeAsBytes(bytes);
//     final xFile = XFile(path);
//     await Share.shareXFiles([xFile],text: "");
  
//   } else {
//   Get.snackbar("Error", response.statusCode.toString());
//   }
// } catch (e) {
//   Get.snackbar("Error",e.toString());

// }
//                               // await Share.share(pro["url"]);
//                               },
//                             ),
                         
//                             ListTile(
//                               leading:const Icon(Icons.favorite,color: Colors.grey,),
//                               title: Text('remove from favourties'),
//                               onTap: (){
//                               removeImagetofav(pro["time"], pro["Favorites"]);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                 content: Text('removed from favourties'),
//                        ),);
               
//                                 Navigator.pop(context);
                                
//                               },
//                             ),
        
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                           );
//                                         },
//                                         child: Stack(
//                     alignment: Alignment.topRight,
               
//                                           children: [Container(
//                                             decoration: BoxDecoration(
//                                               border: Border.all(width: 0.3,color: Colors.grey)
//                                             ),
//                                             child: Center(
//                                   child: CachedNetworkImage(
//                                   imageUrl: pro["Favorites"],
//                                 placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
//                                 errorWidget: (context, url, error) =>const Icon(Icons.network_check),
//                                               ),
//                                             )                                                           
//                                           ),
                                           
//                          Icon(
//                           isFavorite ? Icons.favorite : Icons.favorite_border,
//                           color: isFavorite ? Colors.red : Colors.white,
//                                             ),
          
//                                           ]
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//              ),
                      

//            ],
//          ),);
//   }