// // ignore_for_file: camel_case_types, must_be_immutable, sized_box_for_whitespace

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:galleryproject999666333/contsants/constants.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class Favorites_slider extends StatefulWidget {
//   List<DocumentSnapshot> favoriteslist;
//   int index;

//   Favorites_slider({
//     super.key,
//     required this.favoriteslist,
//        required this.index,


//   });


//   @override
//   State<Favorites_slider> createState() => _Favorites_sliderState();
// }


// class _Favorites_sliderState extends State<Favorites_slider> {


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Favorites"),
//         backgroundColor: Appconstants.mainthemeColor,
//         foregroundColor: Appconstants.mainforegroundcolor,
      
//       ),
//       body: 
//       PhotoViewGallery.builder(itemCount: widget.favoriteslist.length,
//       loadingBuilder: (context, event) => Center(
//         child: Container(
//           width: 20.0,
//           height: 20.0,
//           child: CircularProgressIndicator(
//             value: event == null
//                 ? 0
//                 : 1,
//           ),
//         ),
//       ),
     
//       pageController: PageController(initialPage: widget.index),
//       builder: (context,index){
//         return PhotoViewGalleryPageOptions.customChild(
//           child: CachedNetworkImage(imageUrl: widget.favoriteslist[index]["Favorites"],
//              placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
//               errorWidget: (context, url, error) =>const Icon(Icons.network_check),
//              ),
//           initialScale: PhotoViewComputedScale.contained * 0.8,
//           heroAttributes: PhotoViewHeroAttributes(tag: widget.favoriteslist[index]),
          
          
          
//         );

//       })
//     );
//   }
// }
// // CarouselSlider.builder(
// //         options: CarouselOptions(height: 400.0),
// //   itemCount: widget.favoriteslist.length,
// //   disableGesture:false,
// //   itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
// //     Container(
// //       child:InstaImageViewer(child: Image.network(widget.favoriteslist[itemIndex].toString()))
      
// //     ),
// // ),
// // CachedNetworkImage(
// //                                   imageUrl: pro["url"],
// //                                 placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
// //                                 errorWidget: (context, url, error) =>const Icon(Icons.error),
// //                                               ),