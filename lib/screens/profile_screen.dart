// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galleryproject999666333/contsants/constants.dart';
import 'package:galleryproject999666333/repsotiory/database_methods.dart';
import 'package:galleryproject999666333/services/profile_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

final profileuploadingProvider=StateProvider((ref) => false);

TextEditingController profileNameController=TextEditingController();
TextEditingController profileageController=TextEditingController();
TextEditingController profilegmailController=TextEditingController();
TextEditingController profilephoneController=TextEditingController();



class ProfileScreen extends ConsumerStatefulWidget {
   String id;
 ProfileScreen({super.key,required this.id});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends ConsumerState<ProfileScreen> {
    final ImagePicker _picker = ImagePicker();
  File? imageFile;
  
  @override
  Widget build(BuildContext context) {
               bool isprofileUploading=ref.watch(profileuploadingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Appconstants.mainthemeColor,
        foregroundColor: Appconstants.mainforegroundcolor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 23,),
            Stack(
              children: [
                StreamBuilder(
                  stream:  DatabaseMethods().getImageDetailsStreamById(widget.id,"profileimage"),
                  builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                         else {
                          Map<String, dynamic> data = snapshot.data ?? {};
                          String profileImageUrl = data["profilepic"] ?? ""; //
        
                    return isprofileUploading? const CircleAvatar(
                    radius: 63,
                     child: Center(child: CircularProgressIndicator()),
                   
                    // backgroundImage: CircularProgressIndicator(),
                    
                   
                                    ):InkWell(
                                      onTap:(){
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileViewer(image: profileImageUrl)));
                                       }
                                       ,
                                      child: CircleAvatar(
                                         radius: 63,
                                        // child: Center(child: CircularProgressIndicator()),
                                         backgroundImage:  
                                         (profileImageUrl!="")?
                                         CachedNetworkImageProvider(
                                         profileImageUrl, ):
                                          const  CachedNetworkImageProvider(
                                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHvZ0pbf4bXvAJgVZVuRQqrNWnoWl96cV6wQ&s", )
                                         
                                        ),
                                    );
                                      }
                  }
                ),
              Positioned(
                bottom: -13,
                left: 83,
                child:IconButton(onPressed: (){
                  showingImages();
                },
                
                 icon:const Icon(Icons.add_a_photo)) )
              ],
            ),
            const SizedBox(height: 13,),
           const Padding(
             padding: EdgeInsets.only(left: 39,right: 39),
        
              child: Row(
                children: [
                  Text("name"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33,right: 33),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 9,right: 9),
                  child: TextFormField(
                    controller: profileNameController,
                    decoration:const InputDecoration(
                      border: InputBorder.none,
        
                    ),
                  ),
                ),
              ),
            ),
                          const SizedBox(height: 13,),
           const Padding(
             padding: EdgeInsets.only(left: 39,right: 39),
        
              child: Row(
                children: [
                  Text("age"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33,right: 33),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 9,right: 9),
                  child: TextFormField(
                    controller: profileageController,
                    decoration:const InputDecoration(
                      border: InputBorder.none,
        
                    ),
                  ),
                ),
              ),
            )         ,
                 const SizedBox(height: 13,),
           const Padding(
             padding: EdgeInsets.only(left: 39,right: 39),
        
              child: Row(
                children: [
                  Text("email"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33,right: 33),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 9,right: 9),
                  child: TextFormField(
                    controller: profilegmailController,
                    decoration:const InputDecoration(
                      border: InputBorder.none,
        
                    ),
                  ),
                ),
              ),
            ),
                               const SizedBox(height: 13,),
           const Padding(
             padding: EdgeInsets.only(left: 39,right: 39),
        
              child: Row(
                children: [
                  Text("phone number"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 33,right: 33),
              child: Card(
                elevation: 3,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 9,right: 9),
                  child: TextFormField(
                    controller: profilephoneController,
                    readOnly: true,
                    decoration:const InputDecoration(
                      
                      border: InputBorder.none,
        
                    ),
                  ),
                ),
              ),
            ),
                               const SizedBox(height: 13,),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Appconstants.mainthemeColor),
            foregroundColor: MaterialStatePropertyAll(Appconstants.mainforegroundcolor),
        
          ),
          onPressed: (){
            if(profileNameController.text!=""){
            if(profileNameController.text!=""){
            if(profilegmailController.text!=""){
              if(profilegmailController.text.contains("@gmail.com")){
                  addprofiledetails();}
                  else{
                    Fluttertoast.showToast(msg: "enter a valid email");

                  }
                  }
                  else{
                    Fluttertoast.showToast(msg: "email should not be emprty");
                  }
                }
                else{
                Fluttertoast.showToast(msg: "age should not be emprty");
                 }
                }
                else{
                    Fluttertoast.showToast(msg: "name should not be emprty");
        
            }
        
          },
           child: const Text("Edit"))
          ],
        ),
      ),
    );
  }
  void cancel() {
  Navigator.pop(context);
           imageFile=null;
      showingImages();
}
void showingImages(){
  showModalBottomSheet(context: context, builder: (context){
    return
    SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
                                imageFile != null? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [


                        IconButton(onPressed:(){
                        cancel();
                        
                        } , icon: const Icon(Icons.cancel)),
                         InstaImageViewer(
                                child: Image.file( imageFile!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,),
                              ),
                        const Text("selected image"),

                       ],
                     ):const Text(""),
                    ListTile(
                     leading: const Icon(Icons.photo_library),
                          
      
                      title:const Text('Pick from Gallery'),
                      onTap: () {
                        openImagePicker(ImageSource.gallery);
                      },
                    ),
                                        ListTile(
                     leading: const Icon(Icons.camera_enhance),
                          
      
                      title:const Text('Pick from camera'),
                      onTap: () {
                        openImagePicker(ImageSource.camera);
                      },
                    ),
                                                            ListTile(
                     leading: const Icon(Icons.delete),
                          
      
                      title:const Text('Remove profile image'),
                      onTap: () {
                        removeprofile();
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      style:const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                        foregroundColor: MaterialStatePropertyAll(Colors.white)

                      ),
                      onPressed: (){
                        if(imageFile!=null){
                                Fluttertoast.showToast(msg: "profile uploading...").then((value) => 
      ref.read(profileuploadingProvider.notifier).state=true );
                        edituserprofilepic().then((value) => ref.read(profileuploadingProvider.notifier).state=false);
                        Navigator.pop(context);
                            imageFile=null;
                        }
                        else{
                                Fluttertoast.showToast(msg: "profile select an image");

                        }
                      }, 
                      child: const Text("change profile"))
          ],
        ),
      ),
    );

  });
}
// Stream<Map<String, dynamic>> getImageDetailsStreamById(String id) {
//   return FirebaseFirestore.instance.collection("images").doc(id).snapshots().map((snapshot) {
//     // Check if the document exists
//     if (snapshot.exists) {
//       // Access the document data
//       Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

//       // Update the data with the new profile image URL
//       data['profile'] = data['profile'] ?? ""; // If profile field doesn't exist, initialize it with an empty string

//       return data;
//     } else {
//       // Document does not exist, return null or handle accordingly
//       return {}; // Return an empty map, or you can return null
//     }
//   });
// }
// Stream<Map<String, dynamic>> getImageDetailsStreamById(String id,String profileimage) {
//   try {
//     CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(id).collection('profileimage');

//     return imageSubCollection.doc("profileimage").snapshots().map((snapshot) {
//       if (snapshot.exists) {
//         // Retrieve profile image URL from document data
//         Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//         return data;
//       } else {
//         // Document doesn't exist, return empty map
//         return {};
//       }
//     });
//   } catch (error) {
//     // Handle errors
//     print('Error getting image details stream: $error');
//     // Return an empty stream in case of error
//     return Stream.value({});
//   }
// }


   void openImagePicker(ImageSource source) async {
  final pickedFile = await _picker.pickImage(source: source);
  if (pickedFile != null) {
    setState(() {
      imageFile = File(pickedFile.path);
    });
           Navigator.pop(context);
      showingImages();
  }
}
  // Future<bool> checkUserInFirestore(String phoneNumber) async {
  //   try {
  //     // Query Firestore collection for the given phone number
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection("Users")
  //         .where("employeephoneNo", isEqualTo: phoneNumber)
  //         .get();

  //     // If there's a document matching the phone number, return true
  //     return querySnapshot.docs.isNotEmpty;
  //   } catch (e) {
  //     Get.snackbar(e.toString(), "...");
  //     return false;
  //   }
  // }
     Future<void> edituserprofilepic()async{
      
try {
      Reference ref = FirebaseStorage.instance.ref().child("images/${DateTime.now().toString()}");

    UploadTask uploadTask = ref.putFile(imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    String profileimagurl = await taskSnapshot.ref.getDownloadURL();
    // String epoch = DateTime.now().millisecondsSinceEpoch.toString();
    //   DateTime now = DateTime.now();
    
    // // Extract only the date part
    // String formattedDate = "${now.year}-${now.month}-${now.day}";
    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(widget.id).collection('profileimage');

      await imageSubCollection.doc("profileimage").set({"profilepic":profileimagurl});
Fluttertoast.showToast(msg: "profile pic changed");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to edit'),
        ),
      );
    }
  }
//    Future<void> edituserprofile()async{
      
// try {


//     await FirebaseFirestore.instance.collection("images").doc(widget.id).update(
//       {
//       'Name': profileNameController.text,
//       "gender":"",
//       "age":profileageController.text,
//       "gmail":profilegmailController.text,
//       "last edited ": ""
      
//       }
      
//     );

//    Fluttertoast.showToast(msg: "profile details changed...");
//     } catch (error) {
//       Fluttertoast.showToast(msg: error.toString());
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //  const SnackBar(
//       //     content: Text(error.toString()),
//       //   ),
//       // );
//     }
//   }
//      Future<void> addImagetoprofile(String profileimagurl)async{
      
// try {
//     // String epoch = DateTime.now().millisecondsSinceEpoch.toString();
//       DateTime now = DateTime.now();
    
//     // Extract only the date part
//     String formattedDate = "${now.year}-${now.month}-${now.day}";

//     CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(widget.id).collection('profileimage');

//       await imageSubCollection.doc("profileimage").set({"profilepic":profileimagurl});
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
      Future<void> addprofiledetails()async{
      
try {
    // String epoch = DateTime.now().millisecondsSinceEpoch.toString();
      // DateTime now = DateTime.now();
    
    // Extract only the date part
    // String formattedDate = "${now.year}-${now.month}-${now.day}";

    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(widget.id).collection('profiledetails');

      await imageSubCollection.doc("profiledetails").set({     
      'Name': profileNameController.text,
      "gender":"",
      "age":profileageController.text,
      "gmail":profilegmailController.text,
      "last edited ": ""});
     Fluttertoast.showToast(msg: "profile details changed...");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to add'),
        ),
      );
    }
  }
        Future<void> removeprofile()async{
      
try {
    // String epoch = DateTime.now().millisecondsSinceEpoch.toString();
    //   DateTime now = DateTime.now();
    
    // // Extract only the date part
    // String formattedDate = "${now.year}-${now.month}-${now.day}";

    CollectionReference imageSubCollection = FirebaseFirestore.instance.collection("images").doc(widget.id).collection('profileimage');

      await imageSubCollection.doc("profileimage").update({"profilepic":""});
     Fluttertoast.showToast(msg: "profile image removed");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(
          content: Text('Failed to add'),
        ),
      );
    }
  }
  
}