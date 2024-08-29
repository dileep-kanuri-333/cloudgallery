// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:galleryproject999666333/contsants/constants.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ProfileViewer extends StatefulWidget {
   String image;
  ProfileViewer({super.key,required this.image});

  @override
  State<ProfileViewer> createState() => _ProfileViewerState();
}

class _ProfileViewerState extends State<ProfileViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    foregroundColor: Appconstants.mainforegroundcolor,
    backgroundColor: Appconstants.mainthemeColor,
  ),
  body: PhotoViewGallery.builder(itemCount: 1,
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
     
      pageController: PageController(initialPage: 0),
      builder: (context,index){
        return PhotoViewGalleryPageOptions.customChild(
          child: CachedNetworkImage(imageUrl: widget.image,
           placeholder: (context, url) =>const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>const Icon(Icons.network_check),

          ),
          initialScale: PhotoViewComputedScale.contained * 1,
          // heroAttributes: PhotoViewHeroAttributes(tag: widget.imageslist[index]),
          
          
        );

      })
    );
  }
}