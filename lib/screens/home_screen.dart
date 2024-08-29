// ignore_for_file: use_build_context_synchronously, unnecessary_cast, prefer_is_empty, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:galleryproject999666333/contsants/constants.dart';
import 'package:galleryproject999666333/contsants/video_player_view.dart';
import 'package:galleryproject999666333/contsants/video_thumbnail.dart';
import 'package:galleryproject999666333/main.dart';
import 'package:galleryproject999666333/provider/gallery_controller.dart';
import 'package:galleryproject999666333/repsotiory/awesome_notifications.dart';
import 'package:galleryproject999666333/repsotiory/database_methods.dart';
import 'package:galleryproject999666333/screens/deleted_images.dart';
import 'package:galleryproject999666333/screens/folder_view.dart';
import 'package:galleryproject999666333/screens/login_screen.dart';
import 'package:galleryproject999666333/screens/profile_screen.dart';
import 'package:galleryproject999666333/services/favorites_slider.dart';
import 'package:galleryproject999666333/services/image_slider.dart';
import 'package:galleryproject999666333/services/theme_services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:share_plus/share_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:path/path.dart' as path;
// import 'package:connectivity/connectivity.dart';


final uploadingProvider=StateProvider((ref) => false);
final isSwitchingprovider=StateProvider((ref) => false);
final sharingProvider=StateProvider((ref) => false);
final downloadingProvider=StateProvider((ref) => false);
final startLoaderProvider=StateProvider((ref) => false);

// final sharingProvideroforfav=StateProvider((ref) => false);



     DateTime date=DateTime.now();
          //  String epochs =  DateTime.now().microsecondsSinceEpoch.toString();
String todaydate=DateFormat('yyyy-MM-dd').format(date);
TextEditingController dateController=TextEditingController();
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  PageController pageController=PageController();
  int selectedIndex=0;
  String? selectedfolder;
      String imageUrlcamera = "";
      final picker = ImagePicker();
       late File imageFiled;
        late File? image;
  String? uploadedFileURL;

                     
   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  
late StreamSubscription<QuerySnapshot<Map<String,dynamic>>> subscription; 
  List<DocumentSnapshot<Map<String, dynamic>>> documentslist = [];
  List<DocumentSnapshot<Map<String, dynamic>>> documentslistfav=[];
  List<DocumentSnapshot<Map<String, dynamic>>> documentslistdeleted=[];


  String imageUrl="";
  String id = '';
  Set<String> favorites = {};

 
@override
  void initState() {
    super.initState();
    getSavedPhoneNumber().then((savedPhoneNumber) {
      // setState(() {
        id = savedPhoneNumber;
    //  });
    subscribeToSubCollection(id);
    subscribeToSubCollection1(id);


    loadFavorites();
    // subscribeToSubCollection2(id);

    });
    // 
    
  }
  Future<String> getSavedPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("phoneNumber") ?? "";
  }


 subscribeToSubCollection(String usId) {

    // String userId =id; 
   final galprov=ref.watch(galleryProvider);
   galprov.isStartLoading=true;
    
    CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");
    DocumentReference mainDocumentRef = mainCollection.doc(usId);
    Query<Map<String, dynamic>> subCollection = mainDocumentRef.collection('subcol');

    subscription = subCollection.snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      setState(() {
        documentslist = snapshot.docs;

      });
   galprov.isStartLoading=false;

    }, onError: (error) {
      
      Get.snackbar("error", "");
    });
  }
  
 void subscribeToSubCollection1(String usId) {
    final galprov=ref.watch(galleryProvider);
   galprov.isStartLoading=true;
    // String userId =id; 
    CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");
    DocumentReference mainDocumentRef = mainCollection.doc(usId);
    Query<Map<String, dynamic>> subCollection = mainDocumentRef.collection('favorites');

    subscription = subCollection.snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      setState(() {
        documentslistfav= snapshot.docs;
      });
   galprov.isStartLoading=false;

    }, onError: (error) {
      
      Get.snackbar("error", "");
    });
  }
  //  void subscribeToSubCollection2(String usId) {
  //   // String userId =id; 
  //   CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");
  //   DocumentReference mainDocumentRef = mainCollection.doc(usId);
  //   Query<Map<String, dynamic>> subCollection = mainDocumentRef.collection('deletedimages');

  //   subscription = subCollection.snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
  //     setState(() {
  //       documentslistfav= snapshot.docs;
  //     });
  //   }, onError: (error) {
      
  //     Get.snackbar("error", "");
  //   });
  // }
//    void getDataFromSubCollection33(String folderName) {
//   getSubCollectionDocuments33(folderName).listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
//       setState(() {
//         documentslistfol = snapshot.docs;
//       });
//     }, onError: (error) {
      
//       Get.snackbar("error", "");
//     });
// }
Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionDocuments33(String folderName) {
  CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");

  DocumentReference mainDocumentRef = mainCollection.doc(id);

  
   Query<Map<String, dynamic>>  subCollection = mainDocumentRef.collection('subcol').where('folder', isEqualTo: folderName) as Query<Map<String, dynamic>>;

  return subCollection.snapshots();
}
   void getDataFromSubCollection4(String folderName) {
  getSubCollectionDocuments4(folderName).listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      setState(() {
        documentslistfav = snapshot.docs;
      });
    }, onError: (error) {
      
      Get.snackbar("error", "");
    });
}
Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionDocuments4(String favurl) {
  CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");

  DocumentReference mainDocumentRef = mainCollection.doc(id);

   Query<Map<String, dynamic>>  subCollection = mainDocumentRef.collection('subcol').where('Favorites', isEqualTo: favurl) as Query<Map<String, dynamic>>;

  return subCollection.snapshots();
}
      
Stream<QuerySnapshot<Map<String, dynamic>>> getSubCollectionDocuments1(String userid) {
  CollectionReference mainCollection = FirebaseFirestore.instance.collection("images");

  DocumentReference mainDocumentRef = mainCollection.doc(userid);

   Query<Map<String, dynamic>>  subCollection = mainDocumentRef.collection('subcol') as Query<Map<String, dynamic>>;

  return subCollection.snapshots();
}
loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favorites = prefs.getStringList('favorites')?.toSet() ?? {}; // Convert list to set
      
    });
  }
void addToFavorites(String imageUrl) async{
    setState(() {
      favorites.add(imageUrl);
    });
      SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setStringList('favorites', favorites.toList()); // Convert set to list for storage

  }
    void removeFromFavorites(String imageUrl) async {
    setState(() {
      favorites.remove(imageUrl);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setStringList('favorites', favorites.toList()); // Convert set to list for storage

  }
   bool _isFavorite(String imageUrl) {
    return favorites.contains(imageUrl);
  }

  @override
   
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

   
    List<Widget> bodylist=[
    maingallery(theme),
    foldersview(theme),
    favourties(theme)
  ];
onPageChanged(int index){
  return
  setState(() {
  selectedIndex=index;
    
  });

}
onItemTapped(int i){
  return
pageController.jumpToPage(i);
}


               bool isUploading=ref.watch(uploadingProvider);
              //  bool isTheme=ref.watch(themeProvider);
              //  bool isSwitch=ref.watch(isSwitchingprovider);
                //    bool isUploadingimage=ref.watch(uploadingProvider);
                bool isSharingMG=ref.watch(sharingProvider);
                bool isdownloading=ref.watch(downloadingProvider);
   final galprov=ref.watch(galleryProvider);
               


    return Scaffold(
      appBar: AppBar(
        title:Text("CloudGallery",style: GoogleFonts.pacifico().copyWith(color: Appconstants.mainforegroundcolor,fontSize: 23),)
,
        centerTitle: true,
        // backgroundColor:  Colors.blue,


        backgroundColor: Appconstants.mainthemeColor,
        foregroundColor: Appconstants.mainforegroundcolor,
         actions: [
           ThemeSwitcher(
            clipper:const ThemeSwitcherBoxClipper(),
            builder: (context) {
              bool isDarkMode =
                  ThemeModelInheritedNotifier.of(context).theme.brightness ==
                      Brightness.light;
              String themeName = isDarkMode ? 'dark' : 'light';
              return DayNightSwitcherIcon(
                isDarkModeEnabled: isDarkMode,
                onStateChanged: (bool darkMode) async {
                  var service = await ThemeService.instance
                    ..save(darkMode ? 'light' : 'dark');
                  var theme = service.getByName(themeName);
                  ThemeSwitcher.of(context)
                      .changeTheme(theme: theme, isReversed: darkMode);
                },
              );
            },
          ),
            // IconButton(onPressed: showLoadingDialog(true), icon: Icon(Icons.timelapse)),
                    //             isTheme?IconButton(onPressed: ()async{
                    // //                   SharedPreferences prefs = await SharedPreferences.getInstance();
                    // // bool isUsers = true;
                    // // await prefs.setBool('isUsers', isUsers);
                    //              ref.read(isSwitchingprovider.notifier).state=!isSwitch;
                    //               ref.read(themeProvider.notifier).state=!isTheme;


                    //             }, icon: const Icon(Icons.light_mode_outlined)):
                    //             IconButton(onPressed: () async{
                    // //                SharedPreferences prefs = await SharedPreferences.getInstance();
                    // // bool isUsers = false;
                    // // await prefs.setBool('isUsers', isUsers);
                    //               ref.read(isSwitchingprovider.notifier).state=!isSwitch;
                    //               ref.read(themeProvider.notifier).state=!isTheme;
                    //             }, icon: const Icon(Icons.dark_mode_outlined)),
                                const SizedBox(width: 23,)]
        // actions:    [IconButton(onPressed: ()async{
        //   phoneNoController.text="";
        //   FirebaseAuth.instance.signOut();
        //                 SharedPreferences prefs = await SharedPreferences.getInstance();
        //       await prefs.remove('isUser');
        //                 ref.read(phNoloadingprovider.notifier).state=false;

        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
        // }, icon:const Icon(Icons.logout))],
      ),
      drawer: Drawer(
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Appconstants.mainthemeColor
              ),
              child: 
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(19),

                    child: Image.asset('assets/images/galleryappimage.jpeg',
                    height: 90,
                    width: 90,
                    ),
                    
                  ),
                 const SizedBox(height: 9,),
                  Text("CloudGallery",style: GoogleFonts.pacifico().copyWith(color: Appconstants.mainforegroundcolor,fontSize: 19),)
                ],
              ),),
              Column(
                children: [
                 ListTile(
              leading: const Icon(Icons.home),
              onTap:(){
           Navigator.pop(context);
          } ,
              title: const Text("Home"),
            ),
           StreamBuilder(
             stream:
             DatabaseMethods().getImageDetailsStreamById(id,"profiledetails"),
              // getImageDetailsStreamById(id),
             builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (snapshot.hasError) {
      return Center(
        child: Text('Error: ${snapshot.error}'),
      );}
      else{
        Map<String, dynamic> data = snapshot.data ?? {};
               return ListTile(
                  leading: const Icon(Icons.account_circle),
                  onTap:(){
                    profileNameController.text=data["Name"]??"";
                    profileageController.text=data["age"]??"";
                    profilegmailController.text=data["gmail"]??"";
                    profilephoneController.text=id;
               Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen(id: id,)));
                         } ,
                  title: const Text("Profile"),
                );
             }}
           ),
            // ListTile(
            //       leading: Icon(Icons.account_circle),
            //       onTap:(){
            //         profileNameController.text="Dileep";
            //    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen(id: id,)));
            //              } ,
            //       title: Text("Profile"),
            //     ),
                                       ListTile(
             leading: const Icon(Icons.delete),
              onTap:()async{
      
         
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DeletedImages(id: id, )));

          } ,
              title: const Text("Deleted Images"),
            ),
                           ListTile(
             leading: const Icon(Icons.logout),
              onTap:()async{
            phoneNoController.text="";
            FirebaseAuth.instance.signOut();
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('isUser');
                          ref.read(phNoloadingprovider.notifier).state=false;
        
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
          } ,
              title: const Text("Log out"),
            ),
            
                  
                ],
              )
              

     
          //   ListTile(
          //     trailing: Icon(Icons.logout),
          //     onTap:()async{
          //   phoneNoController.text="";
          //   FirebaseAuth.instance.signOut();
          //                 SharedPreferences prefs = await SharedPreferences.getInstance();
          //       await prefs.remove('isUser');
          //                 ref.read(phNoloadingprovider.notifier).state=false;
        
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
          // } ,
          //     title: Text("Log out"),
          //   )
          ],
        ),
      ),
      body:
      // isUploading?const Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Center(child: Text("Image is uploading...")),

      //     Center(child: CircularProgressIndicator()),
      //   ],
      // ):
       galprov.isStartLoading?const Center(child: CircularProgressIndicator()):
       LiquidPullRefresh(
                                      height: 133,
                color: Appconstants.mainthemeColor,
                backgroundColor:theme.backgroundColor,  
                showChildOpacityTransition:true,
                onRefresh: refresh,
         child: Column(
           children: [
                          isSharingMG? LinearProgressIndicator():const Text(""),
         
             Expanded(
               child: PageView(
                controller: pageController,
                onPageChanged: onPageChanged,
                 children:bodylist
                //    Column(
                //    children: [
                //                  isSharingMG?const Center(child: LinearProgressIndicator(),):const Text(""),
                    
                //      Expanded(child: bodylist[selectedIndex]),
                //       isdownloading?  Row(
                //                                 children: [
                //                                   SizedBox(width:MediaQuery.of(context).size.width*0.3),
                 
                //                                   const CircularProgressIndicator(),
                //                                   const SizedBox(width: 20),
                //                                   const Text("Downloading..."),
                //                                 ],
                //                               ): isUploading?const Center(child: LinearProgressIndicator(),):const Text("")
                 
                //    ],
                //  ),
                 
               ),
             ),
                                 isdownloading?  Row(
                                                children: [
                                                  SizedBox(width:MediaQuery.of(context).size.width*0.3),
                 
                                                  const CircularProgressIndicator(),
                                                  const SizedBox(width: 20),
                                                  const Text("Downloading..."),
                                                ],
                                              ): isUploading?const Center(child: LinearProgressIndicator(),):const Text("")
           ],
         ),
       ),
bottomNavigationBar: CurvedNavigationBar(
  height: 50,
  items: const [
    Icon(Icons.photo),
    Icon(Icons.folder),
    Icon(Icons.favorite),
  ],
  backgroundColor: theme.backgroundColor, // Use theme background color
  color: Appconstants.mainthemeColor,
  animationDuration: Duration(milliseconds: 300),
  onTap: onItemTapped,
  index: selectedIndex,
),
      //  BottomNavigationBar(
      //   backgroundColor:     Appconstants.mainthemeColor,
      //   selectedIconTheme: const IconThemeData(
      //     color: Colors.white
      //   ),
      //   unselectedIconTheme:const IconThemeData(
      //     color: Colors.black
      //   ),
      //   selectedLabelStyle: const TextStyle( color: Colors.white ),
      //   unselectedLabelStyle: const TextStyle(color: Colors.black),
      //   selectedItemColor: Colors.white,
      //   onTap: (index){
      //  setState(() {
      //    currentPsoition=index;
      //  });
      //   },
      //   currentIndex: currentPsoition,
      //   items: 
      // const[
      //   BottomNavigationBarItem(icon: Icon(Icons.photo),label: "Photos"),
      //   BottomNavigationBarItem(icon: Icon(Icons.folder),label: "Folders"),
      //   BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
      //   BottomNavigationBarItem(icon: Icon(Icons.delete_outline_outlined))


      // ]),
      floatingActionButton:
      isUploading?null: FloatingActionButton(
        onPressed: (){
          selectedfolder = null;
           imageFile=null;
           dateController.text="";
        addingimages();
      },
      backgroundColor:     Appconstants.mainthemeColor,
      foregroundColor: Appconstants.mainforegroundcolor,
      child:const Icon(Icons.add),),
    );
  }
// Stream<Map<String, dynamic>> getImageDetailsStreamById(String id) {
//   return FirebaseFirestore.instance.collection("images").doc(id).snapshots().
//   map((snapshot) {
//     // Check if the document exists
//     if (snapshot.exists) {
//       // Access the document data
//       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

//       // // Update the data with the edited profile details
//       // data['Name'] = profileNameController.text;
//       // data['age'] = profileageController.text;
//       // data['gmail'] = profilegmailController.text;
//       // data['last edited'] = DateTime.now().toString(); // Add the current timestamp

//       return data;
//     } else {
//       // Document does not exist, return null or handle accordingly
//       return {}; // Return an empty map, or you can return null
//     }
//   }
//   );
// }

     maingallery(theme){
      documentslist.sort((a, b) => b['time'].compareTo(a['time']));
             documentslist.sort((a, b) => b['date'].compareTo(a['date']));
                Map<String, List<DocumentSnapshot>> groupedDocuments = Appconstants.groupDocumentsByDate(documentslist);
              //  bool isUploadingimage=ref.watch(uploadingProvider);
                bool isSharingMG=ref.watch(sharingProvider);
                bool isdownloading=ref.watch(downloadingProvider);

    return
    // isUploading? const Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     CircularProgressIndicator(),
    //     Text("Image is Uloading...")
    //   ],
    // ):
     id.isEmpty?


      Center(child: Container(
        child:const Center(child: Center(child: CircularProgressIndicator())),)):
    Container(
    child:
     documentslist.isEmpty
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset("assets/images/startuploading.png")),
             const Text("start your gallery",style: TextStyle(fontSize: 23,color: Colors.grey),)
            ],
          )
          : 
         Column(
           children: [
                      //  isSharingMG?const Center(child: LinearProgressIndicator(),):const Text(""),

             Expanded(
               child: ListView.builder(
                          itemCount: groupedDocuments.length,
                          itemBuilder: (context, index) {
                            // final pros=documentslist[index]["url"];
                            String date = groupedDocuments.keys.elementAt(index);
                            List<DocumentSnapshot> documentsForDate = groupedDocuments[date]!;
                            int n=index;
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
                                    String proz=documentsForDate[index]["url"];
                                    int m=index;
                                    
                final isFavorite = _isFavorite(pro["url"]);
                                   
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          pro["url"].toString().contains(".mp4")?
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayerScreen(mediaTable: documentsForDate,videoUrl: pro["url"],)))
                                          
                                          :
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageSlider(imageslist: documentsForDate,index: index,name: "url",)));
                                        },
                                        onLongPress: (){
                                          isdownloading?Fluttertoast.showToast(msg: "downloading is still in progress..."):
                                          isSharingMG?Fluttertoast.showToast(msg: "Sharing is still in progress..."): 
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
                          children: [
                            // isSharing?Center(child: CircularProgressIndicator(),):Text(""),
               ListTile(
                 leading: const Icon(Icons.share, color: Colors.blue),
                 title: const Text("Share"),
                 onTap: ()  async{
                   Fluttertoast.showToast(msg: "wait for few secs...").then((value) => ref.read(sharingProvider.notifier).state=true);
                   // sharing(pro["url"]).then((value) => ref.read(sharingProvider.notifier).state=false);
                   Navigator.pop(context);
                   String shareUrl = pro["url"];
                  
               shareUrl.contains(".mp4") ?shareVideo(shareUrl): shareImage(shareUrl);
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
                     final path = '${temp.path}/downloaded_file.mp4'; // Replace 'extension' with the appropriate file extension
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
               
               
                                  ),
               
                            ListTile(
                              leading:const Icon(Icons.delete,color: Colors.red,),
                              title: const Text('Delete'),
                              onTap: (){
                                addImagetodelete(id,pro["date"],pro["url"],pro["folder"],pro["time"]);
               
                                deleteImage(pro["time"], pro["url"]);
                                  Navigator.pop(context);
                              },
                            ),
                            isFavorite?  ListTile(
                              leading:const Icon(Icons.favorite,color: Colors.grey,),
                              title: const Text('remove from favourties'),
                              onTap: (){
                                removeFromFavorites(pro["url"]);
                                removeImagetofav(pro["time"], pro["url"]);
                //                   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                // content: Text('removed from favourties'),
                //        ),);
               
                                Navigator.pop(context);
                                
                              },
                            ):
                            ListTile(
                              leading:const Icon(Icons.favorite,color: Colors.red,),
                              title: const Text('add to favourties'),
                              onTap: (){
                                addToFavorites(pro["url"]);
                                addImagetofav(pro["time"], pro["url"]);
               
                //                   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                // content: Text('Add to favourties'),
                //        ),);
                                Navigator.pop(context);
                                
                              },
                            ),
                            
                            // Add more options as needed
                          ],
                        ),
                      ),
                    );
                  },
                          );
                                        },
                                        child: Stack(
                    alignment: Alignment.topRight,
               
                                          children: [Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 0.3,color: Colors.grey)
                                            ),
                                            child:pro["url"].toString().contains(".mp4")?
                                            Center(child: VideoThumbnailWidget(videoPath: pro["url"],)):
                                                                          Center(
                                                              child: CachedNetworkImage(
                                                              imageUrl: pro["url"],
                                                        placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
                                                        errorWidget: (context, url, error) =>const Icon(Icons.network_check),
                                          ),
                                                                          ),                                                          
                                          ),
                                      pro["url"].toString().contains(".mp4")?
                                       Positioned(
                                        top: 0,
                                        right: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: Icon(Icons.play_arrow_rounded,size: 66,)):Text(""),
                                           
                         Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                                            ),
                         
                                          ]
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
                      // isdownloading?  Row(
                      //                 children: [
                      //                   SizedBox(width:MediaQuery.of(context).size.width*0.3),

                      //                   CircularProgressIndicator(),
                      //                   SizedBox(width: 20),
                      //                   Text("Downloading..."),
                      //                 ],
                      //               ): isUploading?const Center(child: LinearProgressIndicator(),):const Text("")

           ],
         ),);
   
    
     
  }
   shareImage(shareUrl) async{
                    try {
                     final response = await http.get(Uri.parse(shareUrl));
                     if (response.statusCode == 200) {
                       final bytes = response.bodyBytes;
               
                       // Check if the response contains valid image data
                       if (bytes.length == 0) {
                             Fluttertoast.showToast(msg: "Image data is empty");
               
                         Get.snackbar("Error", "Image data is empty");
                         return;
               
                       }
               
                       final temp = await getTemporaryDirectory();
                       final path = '${temp.path}/image.jpg';
                       await File(path).writeAsBytes(bytes).then((value) => ref.read(sharingProvider.notifier).state=false);
                       final xFile = XFile(path);
                       await Share.shareXFiles([xFile], text: "Shared by dileep");
                     } else {
                             Fluttertoast.showToast(msg: "Failed to fetch image: ${response.statusCode}").then((value) =>  ref.read(sharingProvider.notifier).state=false);
               
                       // Get.snackbar("Error", "Failed to fetch image: ${response.statusCode}");
                     }
                   } catch (e) {
                             Fluttertoast.showToast(msg: "Failed to share: ${e.toString()}").then((value) =>  ref.read(sharingProvider.notifier).state=false);
               
                     // Get.snackbar("Error", "Failed to share: ${e.toString()}");
                   }
}
shareVideo(shareUrl)async{
       try {
      final response = await http.get(Uri.parse(shareUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Check if the response contains valid video data
        if (bytes.isEmpty) {
          Fluttertoast.showToast(msg: "Video data is empty");
          Get.snackbar("Error", "Video data is empty");
          return;
        }

        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/video.mp4';
        await File(path).writeAsBytes(bytes).then((value) => ref.read(sharingProvider.notifier).state = false);

        final xFile = XFile(path);
        await Share.shareXFiles([xFile], text: "Shared by dileep");
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch video: ${response.statusCode}")
            .then((value) => ref.read(sharingProvider.notifier).state = false);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to share: ${e.toString()}")
          .then((value) => ref.read(sharingProvider.notifier).state = false);
    } 
}

  Future<void>refresh()async{
return await Future.delayed(const Duration(milliseconds: 1300));
  }
  Future<void> deleteImage(String documentId,url) async {
    try {
      await FirebaseFirestore.instance.collection("images").doc(id).collection('subcol').doc(documentId).delete();
      // update(
      //   {'url': "",
      //   "deletedurl":url
      //   });
      // ScaffoldMessenger.of(context).showSnackBar(
      //  const SnackBar(
      //     content: Text('Image deleted successfully'),
      //   ),
      // );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to delete image'),
        ),
      );
    }
  }
     Future<void> addImagetodelete(String documentId,date,imagurls,folder,time)async{
      
try {
    String epoch = DateTime.now().millisecondsSinceEpoch.toString();
      // DateTime now = DateTime.now();
     
    // Extract only the date part
    // String formattedDate = "${now.year}-${now.month}-${now.day}";

    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('deletedimages');

      await imageSubCollection.doc(time).set(
           {  "user": id,
      'date': date,
      'deletedurl': imagurls,
      "folder": folder,
      "time": time,
      }
        );
        Fluttertoast.showToast(msg: "deleted successfully");
      // ScaffoldMessenger.of(context).showSnackBar(
      //  const SnackBar(
      //     content: Text('added to favorties successfully'),
      //   ),
      // );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to delete'),
        ),
      );
    }
  }
  //   Future<void> sharing(prourl)async{
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


     List<String> folders=['camera','gallery','instagram','facebook',"personal"];
   foldersview(theme){
                // bool isSharingMG=ref.watch(sharingProvider);

  
    return
    Column(
      children: [
                  //  isSharingMG?const Center(child: LinearProgressIndicator(),):const Text(""),
    
    
        Expanded(
          child: Padding(
                          padding: const EdgeInsets.all(13),
        
            child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 13,crossAxisSpacing: 13),itemCount: folders.length, itemBuilder: (context,int index){
            // String date = groupedDocuments.keys.elementAt(index);
            //                 List<DocumentSnapshot> documentsForDate = groupedDocuments[date]!;
                    //  final pro = documentsForDate[index]["folder"];
                    //  final folderlength=pro['folder'];
              return StreamBuilder(
            stream: getSubCollectionDocuments33(folders[index]),
               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                 if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                }
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
            documents.sort((a, b) => b['time'].compareTo(a['time']));
                         documents.sort((a, b) => b['date'].compareTo(a['date']));
              Map<String, List<DocumentSnapshot>> groupedDocuments =Appconstants.groupDocumentsByDate(documents);
                return InkWell(
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (contesxt)=>CameraScreen(names: folders[index],folderslist: groupedDocuments,foldersimageslist: documents,id: id,))) ;
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(width: 0.3,color: Colors.grey)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                            height:130,
                            width: 150,
                            child:documents.length!=0? CachedNetworkImage(imageUrl: documents[documents.length-1]["url"].toString(),
                             placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>const Icon(Icons.network_check),):
                            const Center(child: Text("no images")),
                          ),
                        ),
                        Container(
                        width: 150,
                        height: 20,
                          child: Center(child: Text(folders[index]+("(${documents.length.toString()})"))),
                        ),
                      ],
                    ),
                  ),
                );
            }
              );
            }),
          ),
        ),
       
      ],
    );
  }
 
 
 void openImagePicker(ImageSource source) async {
  final pickedFile = await _picker.pickImage(source: source);
  if (pickedFile != null) {
    setState(() {
      imageFile = File(pickedFile.path);

    });
      Navigator.pop(context);
      addingimages();
     
  }
}
  void pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
            Navigator.pop(context);
      addingimages();
    }
  }
void cancel() {
  Navigator.pop(context);
  selectedfolder = null;
           imageFile=null;
           dateController.text="";
      addingimages();
}
void loader() {
  Navigator.pop(context);

      addingimages();
}
  bool isImageFile(File file) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    final extension = file.path.split('.').last.toLowerCase();
    return imageExtensions.contains(extension);
  }
   void addingimages([DocumentSnapshot? documentSnapshot ]){
    showModalBottomSheet(context: context, builder: (context){

      return
  
    SingleChildScrollView(
      child: Container(
       
        width: MediaQuery.of(context).size.width,
        child: 
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     imageFile != null? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                        IconButton(onPressed:(){
                        cancel();
                        
                        } , icon: const Icon(Icons.cancel)),
                       isImageFile(imageFile!)? InstaImageViewer(
                                child: Image.file( imageFile!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,),
                              ):
                              Container(
                                 width: 60,
                                    height: 60,
                                child: Text("Video"),
                              ),
                        const Text("selected image"),

                       ],
                     ):const Text(""),
                    ListTile(
                     leading: const Icon(Icons.photo_library),
                          
      
                      title:const Text('Pick from Gallery'),
                      onTap: () {
                        openImagePicker(ImageSource.gallery);
                       selectedfolder=null;
                      },
                    ),
                 
                    ListTile(
                      leading:const Icon(Icons.camera_alt),
                      title:const Text('Take a Picture'),
                      onTap: () {
                        openImagePicker(ImageSource.camera);
                        selectedfolder="camera";
                      },
                    ),
                                        ListTile(
                     leading: const Icon(Icons.photo_library),
                          
      
                      title:const Text('Pick video'),
                      onTap: () {
                        pickVideo();
                       selectedfolder=null;
                      },
                    ),
                    
                  ],
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "date",
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none
                    )
                  ),
                  readOnly: true,
                  onTap: (){
                   selectdate();
                  },
                ),
               DropdownButtonFormField<String>(
        value: selectedfolder,
        onChanged: (String? newValue) {
      setState(() {
        selectedfolder = newValue!;
      });
        },
        items: folders
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
        }).toList(),
        hint:const Text('Select a folder'), // Placeholder text
      ),
             
        
                 
      const SizedBox(height: 33,),
              Center(
                child: ElevatedButton(onPressed: (){
                  
                  if(imageFile!=null){
                  if(dateController.text!=""){
             if(selectedfolder!=null) {
             

AwesomeNotificationsService.showNotification(id: 0, title: "Image", body: "uploading...",summary: "wait few seconds",notificationLayout: NotificationLayout.ProgressBar).then((value) => 
      ref.read(uploadingProvider.notifier).state=true );


              uploadImage(selectedfolder!).then((value) => 
              ref.read(uploadingProvider.notifier).state=false);

      // LocalNotifications().showNotification(id:0,title:"Image" ,body: "uploading...");
      AwesomeNotificationsService.showNotification(id: 0, title: "Image", body: "uploading...",summary: "wait few seconds",notificationLayout: NotificationLayout.ProgressBar);
                              Fluttertoast.showToast(msg: "uploading...");
              
                               Navigator.pop(context);
                               selectedfolder = null;
                               imageFile=null;
                               }
                               else{
                              Fluttertoast.showToast(msg: "please select a folder");

                               }
                               }
                               else {
                           Fluttertoast.showToast(msg: "please select a date");

                               }
                               }
                               else{
                                         Fluttertoast.showToast(msg: "please select an image");

                               }
      
                },
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Appconstants.mainthemeColor),
                foregroundColor: MaterialStatePropertyAll(Appconstants.mainforegroundcolor)
                ),
                 child:const Text("Save")),
              )
            ],
          ),
        ),
        
        ),
    );}
    );
  }
  
  Future<void>selectdate()async{
DateTime? picked= await showDatePicker(context: context,initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime.now());

if(picked!=null){
  dateController.text=picked.toString().split(" ")[0];
}
  }
  

Future<XFile?> compressImage(XFile? file) async {
  if (file == null) return null;

  
  String filePath = file.path;

  Uint8List? compressedImageData =
      await FlutterImageCompress.compressWithFile(filePath,
          quality: 30);

  if (compressedImageData == null) {
    return null;
  }

  final directory = await getTemporaryDirectory();
  String compressedFilePath = '${directory.path}/compressed_image.jpg';

 
  File compressedFile = File(compressedFilePath);
  await compressedFile.writeAsBytes(compressedImageData);

 
  return XFile(compressedFilePath);
  
}
 //   XFile? xImageFile = imageFile != null ? XFile(imageFile!.path) : null;
  //  XFile? compressedImage = await compressImage(xImageFile);
  
Future<String> uploadImage(String selectedfolder) async {
  // Return an initial value (empty string) before starting the upload process
  String initialImageUrl = "";
//                bool isUploading=ref.watch(uploadingProvider);
// ref.read(uploadingProvider.notifier).state=true;
// isUploading?Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Uploading()), (route) => false):null;
  try {
    String finalPath=("images/${DateTime.now().toString()}")+path.basename(imageFile!.path);
    Reference ref = FirebaseStorage.instance.ref().child(("files/${path.basename(imageFile!.path)}"));
 
    UploadTask uploadTask = ref.putFile(imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    
print(imageFile);
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    String epoch = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection("images").doc(id).set({
      "profile":"",
      'Name': "",
      "gender":"",
      "age":"",
      'phone nujmber': id,
      "gmail": "",
      "last edited ": ""
    });

    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('subcol');

    await imageSubCollection.doc(epoch).set({
      "user": id,
      'date': dateController.text,
      'url': imageUrl,
      "folder": selectedfolder,
      "time": epoch,
      "fileUrl":finalPath

    }).then((value) => Fluttertoast.showToast( msg: "uploaded successfully"));
      // LocalNotifications().showNotification(id:0,title:"Image" ,body: "uploaded successfully");
      AwesomeNotificationsService.showNotification(id: 0, title: "pic", body: "uploaded successfully",summary: "Cloud Gallery",notificationLayout: NotificationLayout.BigPicture,bigpicture:imageUrl );
    setState(() {
      imageFile = null;
    });

    return imageUrl;
  } catch (error) {
    print("Error uploading image: $error");
    // You can handle error cases here, e.g., show error message, return null, etc.
    return initialImageUrl; // Return initial value in case of error
  }
}

  Future<void> updateImage(String documentId,String favimagurl)async{
      
try {
      await FirebaseFirestore.instance.collection("images").doc(id).collection('subcol').doc(documentId).update({"Favorites":favimagurl});
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('added to favorties'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to add'),
        ),
      );
    }
  }




     favourties(theme){
    // final mainlist=documentslist.where((ids) => ids[0]["id"]=id)
    bool isSharingfav=ref.watch(sharingProvider);
    bool isdownloading=ref.watch(downloadingProvider);


         documentslistfav.sort((a, b) => b['time'].compareTo(a['time']));
             documentslistfav.sort((a, b) => b['date'].compareTo(a['date']));
                Map<String, List<DocumentSnapshot>> groupedDocuments = Appconstants.groupDocumentsByDate(documentslistfav);
    return 
         
     id.isEmpty?


      Center(child: Container(
        child:const Center(child: Center(child: CircularProgressIndicator())),)):
    Container(
    child:
     documentslistfav.isEmpty
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset("assets/images/favs.png")),
             const Text("start your gallery",style: TextStyle(fontSize: 23,color: Colors.grey),)
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
                                    String proz=documentsForDate[index]["Favorites"];
                                    int m=index;
                                    
                // final isFavorite = _isFavorite(pro["Favorites"]);
                                   
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          pro["Favorites"].toString().contains(".mp4")?
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayerScreen(mediaTable: documentsForDate,videoUrl: pro["Favorites"] ,))):

                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageSlider(imageslist: documentsForDate,index: m,name: "Favorites",)));
                                        },
                                        onLongPress: (){
                                           isdownloading?Fluttertoast.showToast(msg: "downloading is still in progress..."):
                                          isSharingfav?Fluttertoast.showToast(msg: "Sharing is still in progress..."): 
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
                              leading:const Icon(Icons.share,color: Colors.blue,),
                              title:const Text("share") ,
                              onTap :()  async{
    Fluttertoast.showToast(
      timeInSecForIosWeb: 2,
      msg: "wait for few secs...").then((value) => ref.read(sharingProvider.notifier).state=true);
    // sharing(pro["url"]).then((value) => ref.read(sharingProvider.notifier).state=false);
    Navigator.pop(context);
    final shareUrl = pro["Favorites"];
    try {
      final response = await http.get(Uri.parse(shareUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Check if the response contains valid image data
        if (bytes.length == 0) {
              Fluttertoast.showToast(msg: "Image data is empty");

          Get.snackbar("Error", "Image data is empty");
          return;

        }

        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/image.jpg';
        await File(path).writeAsBytes(bytes).then((value) => ref.read(sharingProvider.notifier).state=false);
        final xFile = XFile(path);
        await Share.shareXFiles([xFile], text: "Shared by dileep");
      } else {
              Fluttertoast.showToast(msg: "Failed to fetch image: ${response.statusCode}").then((value) =>  ref.read(sharingProvider.notifier).state=false);

        // Get.snackbar("Error", "Failed to fetch image: ${response.statusCode}");
      }
    } catch (e) {
              Fluttertoast.showToast(msg: "Failed to share: ${e.toString()}").then((value) =>  ref.read(sharingProvider.notifier).state=false);

      // Get.snackbar("Error", "Failed to share: ${e.toString()}");
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
 
  final downloadUrl = pro["Favorites"]; // Assuming pro["url"] contains the download URL

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


                                  ),
                         
                            ListTile(
                              leading:const Icon(Icons.favorite,color: Colors.grey,),
                              title: const Text('remove from favourties'),
                              onTap: (){
                              removeImagetofav(pro["time"], pro["Favorites"]);
                                removeFromFavorites(pro["Favorites"]);

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
                                                                          child:pro["Favorites"].toString().contains(".mp4")?                                                
                                                                            Stack(children: 
                                                [
                                                  Center(child: VideoThumbnailWidget(videoPath: pro["Favorites"],)),
                                              const  Positioned(
                                                              top: 0,
                                                              right: 0,
                                                              left: 0,
                                                              bottom: 0,
                                                              child: Icon(Icons.play_arrow_rounded,size: 66,))
                                                  ]
                                                  )  :CachedNetworkImage(
                                                                          imageUrl: pro["Favorites"],
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
         ),);
  }


//   void showLoadingDialog() {
   
// bool loadingdown=ref.watch(sharingProviderfoedown);

//   showDialog(
//     context: context,

//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: Column(
//           children: [
//             Row(
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(width: 20),
//                 Text("Downloading..."),
//               ],
//             ),
//         false?Text(""):TextButton(onPressed: (){
//           Navigator.pop(context);
//         }, child: Text("Dowloaded"))
//           ],
//         ),
//       );
//     },
//   );
//   loadingdown?null:Navigator.pop(context);

// }
   Future<void> addImagetofav(String documentId,String favimagurl)async{
      
try {
    // String epoch = DateTime.now().millisecondsSinceEpoch.toString();
      DateTime now = DateTime.now();
    
    // Extract only the date part
    String formattedDate = "${now.year}-${now.month}-${now.day}";

    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('favorites');

      await imageSubCollection.doc(documentId).set({"Favorites":favimagurl,"time":documentId,"date":formattedDate});
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('added to favorties successfully'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to add'),
        ),
      );
    }
  }
    Future<void> removeImagetofav(String documentId,String favimagurl)async{
      
try {
    // String epoch = DateTime.now().millisecondsSinceEpoch.toString();
    //   DateTime now = DateTime.now();
    
    // Extract only the date part
    // String formattedDate = "${now.year}-${now.month}-${now.day}";

    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('favorites');

      await imageSubCollection.doc(documentId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('removed from favorites successfully'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to remove'),
        ),
      );
    }
  }
}
