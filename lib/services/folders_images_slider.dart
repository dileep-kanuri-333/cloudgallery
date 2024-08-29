// // ignore_for_file: must_be_immutable, sized_box_for_whitespace

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:galleryproject999666333/contsants/constants.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';

// class FoldersImageSlider extends StatefulWidget {
//   List<DocumentSnapshot> foldersimageslist;
//  int index;
//   FoldersImageSlider({
//     super.key,
//     required this.foldersimageslist,
//     required this.index,

//   });

//   @override
//   State<FoldersImageSlider> createState() => _FoldersImageSliderState();
// }

// class _FoldersImageSliderState extends State<FoldersImageSlider> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Appconstants.mainthemeColor,
//         foregroundColor: Appconstants.mainforegroundcolor,
//       ),
//       body: 
//            PhotoViewGallery.builder(itemCount: widget.foldersimageslist.length,
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
//           child: CachedNetworkImage(imageUrl: widget.foldersimageslist[index]["url"],
//            placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
//             errorWidget: (context, url, error) =>const Icon(Icons.network_check),

//           ),
//           initialScale: PhotoViewComputedScale.contained * 0.8,
//           heroAttributes: PhotoViewHeroAttributes(tag: widget.foldersimageslist[index]),
          
          
//         );

//       })
//     );
//   }
// }

// // CarouselSlider.builder(
// //         options: CarouselOptions(height: 400.0),
// //   itemCount: widget.foldersimageslist.length,
// //   disableGesture:false,
// //   carouselController: CarouselControllerImpl(),
// //   itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
// //     Container(
// //       child:InstaImageViewer(child: Image.network(widget.foldersimageslist[itemIndex]["url"].toString()))
      
// //     ),
// // ),
// // CachedNetworkImage(
// //                                   imageUrl: pro["url"],
// //                                 placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
// //                                 errorWidget: (context, url, error) =>const Icon(Icons.error),
// //  