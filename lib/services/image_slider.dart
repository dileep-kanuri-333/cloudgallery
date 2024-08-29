// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:galleryproject999666333/contsants/constants.dart';
import 'package:galleryproject999666333/contsants/video_player_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageSlider extends StatefulWidget {
  List<DocumentSnapshot> imageslist;
 int index;
 String name;
   ImageSlider({
    super.key,
    required this.imageslist,
    required this.index,
    required this.name,




  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
      
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Appconstants.mainthemeColor,
        foregroundColor: Appconstants.mainforegroundcolor,
      
      ),
      
      body:
      
 PhotoViewGallery.builder(itemCount: widget.imageslist.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : 1,
          ),
        ),
      ),
      backgroundDecoration: BoxDecoration(color:theme.backgroundColor ),
      enableRotation: true,
      gaplessPlayback: true,
      allowImplicitScrolling:true,
     
      pageController: PageController(initialPage: widget.index),
      builder: (context,index){
        return PhotoViewGalleryPageOptions.customChild(
          child:widget.imageslist[index][widget.name].toString().contains(".mp4")?VideoPlayerScreen(mediaTable: widget.imageslist,videoUrl:widget.imageslist[index][widget.name] ,) :CachedNetworkImage(imageUrl: widget.imageslist[index][widget.name],
           placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>const Icon(Icons.network_check),

          ),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes: PhotoViewHeroAttributes(tag:widget.imageslist[widget.index]
          //  widget.imageslist[index]
           ),
          
          
        );

      })
    );
  }
}

  // options: CarouselOptions(height: 400.0),

//  CarouselSlider.builder(
//         options: CarouselOptions(height: 400.0),
//   itemCount: 15,
//   itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
//     Container(
//       child: Text(itemIndex.toString()),
      
//     ),
// )
// CachedNetworkImage(
//                                   imageUrl: pro["url"],
//                                 placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
//                                 errorWidget: (context, url, error) =>const Icon(Icons.error),
//  