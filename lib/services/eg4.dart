// // // ignore_for_file: use_build_context_synchronously

// // import 'dart:async';
// // import 'dart:io';
// // import 'dart:typed_data';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:galleryproject999666333/contsants/constants.dart';
// // import 'package:galleryproject999666333/screens/folder_view.dart';
// // import 'package:galleryproject999666333/screens/login_screen.dart';
// // import 'package:galleryproject999666333/services/image_slider.dart';
// // import 'package:get/get.dart';
// // import 'package:insta_image_viewer/insta_image_viewer.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:intl/intl.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:carousel_slider/carousel_slider.dart';
// // import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
// // import 'package:path_provider/path_provider.dart';

// // import 'package:flutter_image_compress/flutter_image_compress.dart';


// //      DateTime date=DateTime.now();
// //           //  String epochs =  DateTime.now().microsecondsSinceEpoch.toString();
// // String todaydate=DateFormat('yyyy-MM-dd').format(date);
// // TextEditingController dateController=TextEditingController();
// // class HomeScreen extends ConsumerStatefulWidget {
// //   const HomeScreen({super.key});

// //   @override
// //   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends ConsumerState<HomeScreen> {
// //   int currentPsoition=0;
// //   String? selectedfolder;
// //       String imageUrlcamera = "";
// //       final picker = ImagePicker();
// //        late File imageFiled;
// //         late File? image;
// //   String? uploadedFileURL;

                     
// //    final FirebaseFirestore firestore = FirebaseFirestore.instance;
// //   final FirebaseStorage storage = FirebaseStorage.instance;
// //   final ImagePicker _picker = ImagePicker();
// //   File? imageFile;

  
// // late StreamSubscription<QuerySnapshot<Map<String,dynamic>>> subscription; 
// //   List<DocumentSnapshot<Map<String, dynamic>>> documentslist = [];
// //   List<DocumentSnapshot<Map<String, dynamic>>> documentslistfol=[];
// //   List<DocumentSnapshot<Map<String, dynamic>>> documentslistfav=[];

// //   String imageUrl="";
// //   String id = '';
// //   Set<String> favorites = {};

  
// // @override
// //   void initState() {
// //     super.initState();
// //     getSavedPhoneNumber().then((savedPhoneNumber) {
// //       // setState(() {
// //         id = savedPhoneNumber;
// //     //  });
// //     subscribeToSubCollection(id);
// //     loadFavorites();
// //     });
// //     // 
    
// //   }
// //   Future<String> getSavedPhoneNumber() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     return prefs.getString("phoneNumber") ?? "";
// //   }


// //  void subscribeToSubCollection(String u) {
// //     String userId =id; 
// //     CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");
// //     DocumentReference mainDocumentRef = mainCollection.doc(u);
// //     Query<Map<String, dynamic>> subCollection = mainDocumentRef.collection('subcol');

// //     subscription = subCollection.snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
// //       setState(() {
// //         documentslist = snapshot.docs;
// //       });
// //     }, onError: (error) {
      
// //       Get.snackbar("error", "");
// //     });
// //   }
// //    void getDataFromSubCollection33(String folderName) {
// //   getSubCollectionDocuments33(folderName).listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
// //       setState(() {
// //         documentslistfol = snapshot.docs;
// //       });
// //     }, onError: (error) {
      
// //       Get.snackbar("error", "");
// //     });
// // }
// // Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionDocuments33(String folderName) {
// //   CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");

// //   DocumentReference mainDocumentRef = mainCollection.doc(id);

// //    Query<Map<String, dynamic>>  subCollection = mainDocumentRef.collection('subcol').where('folder', isEqualTo: folderName) as Query<Map<String, dynamic>>;

// //   return subCollection.snapshots();
// // }
// //    void getDataFromSubCollection4(String folderName) {
// //   getSubCollectionDocuments4(folderName).listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
// //       setState(() {
// //         documentslistfav = snapshot.docs;
// //       });
// //     }, onError: (error) {
      
// //       Get.snackbar("error", "");
// //     });
// // }
// // Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionDocuments4(String favurl) {
// //   CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");

// //   DocumentReference mainDocumentRef = mainCollection.doc(id);

// //    Query<Map<String, dynamic>>  subCollection = mainDocumentRef.collection('subcol').where('Favorites', isEqualTo: favurl) as Query<Map<String, dynamic>>;

// //   return subCollection.snapshots();
// // }
      
// // Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionDocuments1(String userid) {
// //   CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");

// //   DocumentReference mainDocumentRef = mainCollection.doc(userid);

// //    Query<Map<String, dynamic>>  subCollection = mainDocumentRef.collection('subcol') as Query<Map<String, dynamic>>;

// //   return subCollection.snapshots();
// // }
// // loadFavorites() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     setState(() {
// //       favorites = prefs.getStringList('favorites')?.toSet() ?? {}; // Convert list to set
      
// //     });
// //   }
// // void addToFavorites(String imageUrl) async{
// //     setState(() {
// //       favorites.add(imageUrl);
// //     });
// //       SharedPreferences prefs = await SharedPreferences.getInstance();
// //        prefs.setStringList('favorites', favorites.toList()); // Convert set to list for storage

// //   }
// //     void removeFromFavorites(String imageUrl) async {
// //     setState(() {
// //       favorites.remove(imageUrl);
// //     });
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //        prefs.setStringList('favorites', favorites.toList()); // Convert set to list for storage

// //   }
// //    bool _isFavorite(String imageUrl) {
// //     return favorites.contains(imageUrl);
// //   }

// //   @override
   
// //   Widget build(BuildContext context) {
   
// //     List<Widget> bodylist=[
// //     maingallery(),
// //     foldersview(),
// //     favourties()
// //   ];
// //     return Scaffold(
// //       appBar: AppBar(
// //         title:const Text("Welcome to the gallery"),
// //         centerTitle: true,
// //         // backgroundColor:  Colors.blue,


// //         foregroundColor: Appconstants.mainthemeColor,
// //         actions:    [IconButton(onPressed: ()async{
// //           phoneNoController.text="";
// //           FirebaseAuth.instance.signOut();
// //                         SharedPreferences prefs = await SharedPreferences.getInstance();
// //               await prefs.remove('isUser');
// //                         ref.read(phNoloadingprovider.notifier).state=false;

// //           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
// //         }, icon:const Icon(Icons.logout))],
// //       ),
// //       body: bodylist[currentPsoition],
// //       bottomNavigationBar: BottomNavigationBar(
// //         backgroundColor:     Appconstants.mainthemeColor,


// //         selectedItemColor: Colors.white,
// //         onTap: (index){
// //        setState(() {
// //          currentPsoition=index;
// //        });
// //         },
// //         currentIndex: currentPsoition,
// //         items: 
// //       const[
// //         BottomNavigationBarItem(icon: Icon(Icons.photo),label: "Photos"),
// //         BottomNavigationBarItem(icon: Icon(Icons.folder),label: "Folders"),
// //         BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites")


// //       ]),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: (){
// //           selectedfolder = null;
// //            imageFile=null;
// //            dateController.text="";
// //         addingimages();
// //       },
// //       backgroundColor:     Appconstants.mainthemeColor,
// //       foregroundColor: Appconstants.mainforegroundcolor,
// //       child:const Icon(Icons.add),),
// //     );
// //   }
// //      maingallery(){
// //       documentslist.sort((a, b) => b['time'].compareTo(a['time']));
// //              documentslist.sort((a, b) => b['date'].compareTo(a['date']));
// //                 Map<String, List<DocumentSnapshot>> groupedDocuments = Appconstants.groupDocumentsByDate(documentslist);
// //     return
// //      id.isEmpty?


// //       Center(child: Container(
// //         color: Colors.white,
// //         child:const Center(child: Center(child: CircularProgressIndicator())),)):
// //     Container(color: Colors.white,
// //     child:
// //      documentslist.isEmpty
// //           ? Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Center(child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo8xgVLOj4yCFyA8WRnfGZlOR15Dcz0x_Ygg&s")),
// //              const Text("start your gallery",style: TextStyle(fontSize: 23,color: Colors.grey),)
// //             ],
// //           )
// //           : 
// //          ListView.builder(
// //                     itemCount: groupedDocuments.length,
// //                     itemBuilder: (context, index) {
// //                       final pros=documentslist[index]["url"];
// //                       String date = groupedDocuments.keys.elementAt(index);
// //                       List<DocumentSnapshot> documentsForDate = groupedDocuments[date]!;
// //                       return Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.all(8.0),
// //                             child: Text(
// //                              Appconstants.formatDate(date),
// //                               style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                           GridView.builder(
// //                             shrinkWrap: true,
// //                             physics:const NeverScrollableScrollPhysics(),
// //                             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                               crossAxisCount: 3,
// //                               crossAxisSpacing: 4.0,
// //                               mainAxisSpacing: 4.0,
// //                             ),
// //                             itemCount: documentsForDate.length,
// //                             itemBuilder: (context, index) {
// //                               final pro = documentsForDate[index];
// //                               String proz=documentslist[index]["url"];
                              
// //           final isFavorite = _isFavorite(pro["url"]);
                             
// //                               return Padding(
// //                                 padding: const EdgeInsets.all(8.0),
// //                                 child: InkWell(
// //                                   onTap: (){
// //                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageSlider(imageslist: documentslist,images: proz,)));
// //                                   },
// //                                   onLongPress: (){
// //                                     showModalBottomSheet(
// //             context: context,
// //             isScrollControlled: true,
// //             builder: (BuildContext context) {
// //               return SingleChildScrollView(
// //                 child: Container(
                 
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.stretch,
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: <Widget>[
// //                       ListTile(
// //                         leading:const Icon(Icons.delete,color: Colors.red,),
// //                         title: Text('Delete'),
// //                         onTap: (){
// //                           deleteImage(pro["time"]);
// //                             Navigator.pop(context);
// //                         },
// //                       ),
// //                         ListTile(
// //                         leading:const Icon(Icons.favorite,color: Colors.red,),
// //                         title: Text('Add to favourties'),
// //                         onTap: (){
// //                           addToFavorites(pro["url"]);
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //        const SnackBar(
// //           content: Text('Add to favourties'),
// //         ),);
// //                           Navigator.pop(context);
                          
// //                         },
// //                       ),
                      
// //                       // Add more options as needed
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //                     );
// //                                   },
// //                                   child: Stack(
// //               alignment: Alignment.topRight,

// //                                     children: [Container(
// //                                       color: Colors.grey,
// //                                       child:
// //                                                   CachedNetworkImage(
// //                                     imageUrl: pro["url"],
// //                                     placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
// //                                     errorWidget: (context, url, error) =>const Icon(Icons.error),
// //                                                                       )
                                                                   
                                                
// //                                     ),
                                     
// //                    Icon(
// //                     isFavorite ? Icons.favorite : Icons.favorite_border,
// //                     color: isFavorite ? Colors.red : Colors.grey,
// //                   ),
                 
                
                                    
// //                                     ]
// //                                   ),
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ],
// //                       );
// //                     },
// //                   ),);
   
    
     
// //   }
// //   Future<void>refresh()async{

// //   }
// //   Future<void> deleteImage(String documentId) async {
// //     try {
// //       await FirebaseFirestore.instance.collection("images").doc(id).collection('subcol').doc(documentId).delete();
// //       ScaffoldMessenger.of(context).showSnackBar(
// //        const SnackBar(
// //           content: Text('Image deleted successfully'),
// //         ),
// //       );
// //     } catch (error) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //        const SnackBar(
// //           content: Text('Failed to delete image'),
// //         ),
// //       );
// //     }
// //   }


// //      List<String> folders=['camera','gallery','instagram','facebook',"favourites"];
// //    foldersview(){
  
// //     return
// //     Padding(
// //       padding: const EdgeInsets.all(13),
// //       child: Container(
// //         color: Colors.white,
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 13,crossAxisSpacing: 13),itemCount: folders.length, itemBuilder: (context,int index){
// //       // String date = groupedDocuments.keys.elementAt(index);
// //       //                 List<DocumentSnapshot> documentsForDate = groupedDocuments[date]!;
// //                       //  final pro = documentsForDate[index]["folder"];
// //                       //  final folderlength=pro['folder'];
// //                 return StreamBuilder(
// //               stream: getSubCollectionDocuments33(folders[index]),
// //  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
// //    if (!snapshot.hasData) {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //                     List<DocumentSnapshot> documents = snapshot.data!.docs;
// //               documents.sort((a, b) => b['time'].compareTo(a['time']));
// //                            documents.sort((a, b) => b['date'].compareTo(a['date']));
// //                 Map<String, List<DocumentSnapshot>> groupedDocuments =Appconstants.groupDocumentsByDate(documents);
// //                   return InkWell(
// //                     onTap: () {
// //                      Navigator.push(context, MaterialPageRoute(builder: (contesxt)=>CameraScreen(names: folders[index],folderslist: groupedDocuments,foldersimageslist: documents,))) ;
// //                     },
// //                     child: Container(
// //                       height: double.infinity,
// //                       width: double.infinity,
// //                       decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(13),
// //                         border: Border.all(width: 0.3,color: Colors.grey)
// //                       ),
// //                       child: Column(
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.only(top: 8),
// //                             child: SizedBox(
// //                               height:130,
// //                               width: 150,
// //                               child:documents.length!=0? Image.network(documents[documents.length-1]["url"].toString()):Center(child: Text("no images")),
// //                             ),
// //                           ),
// //                           Container(
// //                           width: 150,
// //                           height: 20,
// //                             child: Center(child: Text(folders[index]+("(${documents.length.toString()})"))),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //               }
// //                 );
// //               }),
// //             ),
           
// //           ],
// //         ),
// //       ),
// //     );
// //   }
 
 
// //  void openImagePicker(ImageSource source) async {
// //   final pickedFile = await _picker.pickImage(source: source);
// //   if (pickedFile != null) {
// //     setState(() {
// //       imageFile = File(pickedFile.path);
// //     });
// //       Navigator.pop(context);
// //       addingimages();
// //   }
// // }
// // void cancel() {
// //   Navigator.pop(context);
// //   selectedfolder = null;
// //            imageFile=null;
// //            dateController.text="";
// //       addingimages();
// // }
// //    void addingimages([DocumentSnapshot? documentSnapshot ]){
// //     showModalBottomSheet(context: context, builder: (context)=>
// //     SingleChildScrollView(
// //       child: Container(
// //         color:Colors.white,
// //         width: MediaQuery.of(context).size.width,
// //         child: 
// //         Padding(
// //           padding: const EdgeInsets.all(13.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const SizedBox(height: 30,),
// //               Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                      imageFile != null? Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                        children: [
// //                         IconButton(onPressed:(){
// //                         cancel();
                        
// //                         } , icon: Icon(Icons.cancel)),
// //                          InstaImageViewer(
// //                                 child: Image.file( imageFile!,
// //                                     width: 60,
// //                                     height: 60,
// //                                     fit: BoxFit.cover,),
// //                               ),
// //                         Text("selected image"),

// //                        ],
// //                      ):Text(""),
// //                     ListTile(
// //                      leading: const Icon(Icons.photo_library),
                          
      
// //                       title:const Text('Pick from Gallery'),
// //                       onTap: () {
// //                         openImagePicker(ImageSource.gallery);
// //                        selectedfolder=null;
// //                       },
// //                     ),
                 
// //                     ListTile(
// //                       leading:const Icon(Icons.camera_alt),
// //                       title:const Text('Take a Picture'),
// //                       onTap: () {
// //                         openImagePicker(ImageSource.camera);
// //                         selectedfolder="camera";
// //                       },
// //                     ),
                    
// //                   ],
// //                 ),
// //                 TextField(
// //                   controller: dateController,
// //                   decoration: const InputDecoration(
// //                     labelText: "date",
// //                     filled: true,
// //                     prefixIcon: Icon(Icons.calendar_today),
// //                     enabledBorder: OutlineInputBorder(
// //                       borderSide: BorderSide.none
// //                     ),
// //                     focusedBorder: OutlineInputBorder(
// //                       borderSide: BorderSide.none
// //                     )
// //                   ),
// //                   readOnly: true,
// //                   onTap: (){
// //                    selectdate();
// //                   },
// //                 ),
// //                DropdownButtonFormField<String>(
// //         value: selectedfolder,
// //         onChanged: (String? newValue) {
// //       setState(() {
// //         selectedfolder = newValue!;
// //       });
// //         },
// //         items: folders
// //         .map<DropdownMenuItem<String>>((String value) {
// //       return DropdownMenuItem<String>(
// //         value: value,
// //         child: Text(value),
// //       );
// //         }).toList(),
// //         hint:const Text('Select a folder'), // Placeholder text
// //       ),
             
        
                 
// //       const SizedBox(height: 33,),
// //               Center(
// //                 child: ElevatedButton(onPressed: (){
// //                   if(imageFile!=null){
// //                   if(dateController.text!=""){
// //              if(selectedfolder!=null) {uploadImage(selectedfolder);
// //                                Navigator.pop(context);
// //                                selectedfolder = null;
// //                                imageFile=null;
// //                                }
// //                                else{
// //                                  Get.snackbar("please select a folder", "");
// //                                }
// //                                }
// //                                else {
// //                                 Get.snackbar("please select a date", "");
// //                                }
// //                                }
// //                                else{
// //                                 Get.snackbar("please select an image", "");
// //                                }
      
// //                 },
// //                 style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Appconstants.mainthemeColor),
// //                 foregroundColor: MaterialStatePropertyAll(Appconstants.mainforegroundcolor)
// //                 ),
// //                  child:const Text("Save")),
// //               )
// //             ],
// //           ),
// //         ),
        
// //         ),
// //     ));
// //   }
  
// //   Future<void>selectdate()async{
// // DateTime? picked= await showDatePicker(context: context,initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime.now());

// // if(picked!=null){
// //   dateController.text=picked.toString().split(" ")[0];
// // }
// //   }
  

// // Future<XFile?> compressImage(XFile? file) async {
// //   if (file == null) return null;

  
// //   String filePath = file.path;

// //   Uint8List? compressedImageData =
// //       await FlutterImageCompress.compressWithFile(filePath,
// //           quality: 30);

// //   if (compressedImageData == null) {
// //     return null;
// //   }

// //   final directory = await getTemporaryDirectory();
// //   String compressedFilePath = '${directory.path}/compressed_image.jpg';

 
// //   File compressedFile = File(compressedFilePath);
// //   await compressedFile.writeAsBytes(compressedImageData);

 
// //   return XFile(compressedFilePath);
// // }

  
// // void uploadImage(selectedfolder) async {
// //     XFile? xImageFile = imageFile != null ? XFile(imageFile!.path) : null;
// //    XFile? compressedImage = await compressImage(xImageFile);
  
  
// //   Reference ref =
// //       FirebaseStorage.instance.ref().child("images/${DateTime.now().toString()}");

// //  UploadTask uploadTask = ref.putFile(File(compressedImage!.path));
// //  TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

// //   imageUrl = await taskSnapshot.ref.getDownloadURL();

// //      String epoch =DateTime.now().millisecondsSinceEpoch.toString();
// //   await FirebaseFirestore.instance.collection("images").doc(id).set({
// //     'date': todaydate,
// //     'url': "",
// //     "folder": "",
// //     "time": ""
// //   });

// //   CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('subcol');

// //   await imageSubCollection.doc(epoch).set({
// //     "user":id,
// //     'date': dateController.text,
// //     'url': imageUrl,
// //     "folder": selectedfolder,
// //     "time": epoch,
// //     "Favorites":"",
// //   });

// //   ScaffoldMessenger.of(context).showSnackBar(
// //    const SnackBar(
// //       content: Text('Image uploaded'),
// //     ),
// //   );

// //   setState(() {
// //     imageFile = null;
// //   });

// // }
// //   Future<void> updateImage(String documentId,String favimagurl)async{
      
// // try {
// //       await FirebaseFirestore.instance.collection("images").doc(id).collection('subcol').doc(documentId).update({"Favorites":favimagurl});
// //       ScaffoldMessenger.of(context).showSnackBar(
// //        const SnackBar(
// //           content: Text('added to favorties'),
// //         ),
// //       );
// //     } catch (error) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //        const SnackBar(
// //           content: Text('Failed to add'),
// //         ),
// //       );
// //     }
// //   }
// //    favourties(){
// //         // favorites.sort((a, b) => b.compareTo(a));
// //             //  favorites.sort((a, b) => b['date'].compareTo(a['date']));
// //                 // Map<String, List<DocumentSnapshot>> groupedfavDocuments = Appconstants.groupDocumentsByDate(favorites);
// //   return
  
// //       id.isEmpty?


// //       Center(child: Container(
// //         color: Colors.white,
// //         child:const Center(child: Center(child: CircularProgressIndicator())),)):
// //     Container(color: Colors.white,
// //     child:
// //      favorites.isEmpty
// //           ? Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Center(child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQo8xgVLOj4yCFyA8WRnfGZlOR15Dcz0x_Ygg&s")),
// //              const Text("start your gallery",style: TextStyle(fontSize: 23,color: Colors.grey),)
// //             ],
// //           )
// //           : 
// //         Padding(
// //           padding: const EdgeInsets.only(top: 23,left: 13,right: 13),
// //           child: GridView.builder(
// //              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 16,mainAxisSpacing: 16),
// //                       itemCount: favorites.length,
// //                       itemBuilder: (context, index) {
                            
// //              return 
// //                 InkWell(
// //                  onLongPress: (){
// //                         showModalBottomSheet(
// //                context: context,
// //                isScrollControlled: true,
// //                builder: (BuildContext context) {
// //                  return SingleChildScrollView(
// //                    child: Container(
// //                      child: Column(
// //                        crossAxisAlignment: CrossAxisAlignment.stretch,
// //                        mainAxisAlignment: MainAxisAlignment.center,
// //                        mainAxisSize: MainAxisSize.min,
// //                        children: <Widget>[
                         
// //                            ListTile(
// //                            leading:const Icon(Icons.favorite,color: Colors.grey,),
// //                            title: Text('Remove from favourties'),
// //                            onTap: (){
// //                              removeFromFavorites(favorites.toList()[index]);
// //                              Navigator.pop(context);
// //                                     ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(
// //              content: Text('removed from favourties'),
// //                       ),);
                      
                      
// //                            },
// //                          ),
                         
// //                          // Add more options as needed
// //                        ],
// //                      ),
// //                    ),
// //                  );
// //                },
// //                        );
// //                  },
// //                  child: Container(
// //                   color: Colors.grey,
// //                   child: Image.network(favorites.toList()[index])));
             
// //                       },
// //                  ),
// //         ),
// //                   );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

// // class PdfWebView extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('PDF Viewer'),
// //       ),
// //       body: Web(
// //         initialUrl: 'https://example.com/path/to/pdf.pdf',
// //         javascriptMode: JavascriptMode.unrestricted,
// //       ),
// //     );
// //   }
// // }


// class CustomPdfViewer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return PDF(
//       enableSwipe: true,
//       swipeHorizontal: true,
//       autoSpacing: false,
//       pageFling: false,
//       onError: (error) {
//         print(error.toString());
//       },
//       onPageError: (page, error) {
//         print('$page: ${error.toString()}');
//       },
//     ).cachedFromUrl('https://example.com/path/to/pdf.pdf');
//   }
// }
