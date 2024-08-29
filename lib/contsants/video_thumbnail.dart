import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailWidget extends StatefulWidget {
  final String videoPath;

  VideoThumbnailWidget({required this.videoPath});

  @override
  _VideoThumbnailWidgetState createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  late Image _thumbnail;

  @override
  void initState() {
    super.initState();
    _thumbnail = Image.asset("assets/images/videoImg.jpeg"); // Initialize with a placeholder image
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: widget.videoPath,
      imageFormat: ImageFormat.PNG,
      maxWidth: 200,
      quality: 25,
    );
    setState(() {
      _thumbnail = Image.memory(uint8list!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _thumbnail;
  }
}

    //   try {
    //   final response = await http.get(Uri.parse(shareUrl));
    //   if (response.statusCode == 200) {
    //     final bytes = response.bodyBytes;

    //     // Check if the response contains valid video data
    //     if (bytes.isEmpty) {
    //       Fluttertoast.showToast(msg: "Video data is empty");
    //       Get.snackbar("Error", "Video data is empty");
    //       return;
    //     }

    //     final temp = await getTemporaryDirectory();
    //     final path = '${temp.path}/video.mp4';
    //     await File(path).writeAsBytes(bytes).then((value) => ref.read(sharingProvider.notifier).state = false);

    //     final xFile = XFile(path);
    //     await Share.shareXFiles([xFile], text: "Shared by dileep");
    //   } else {
    //     Fluttertoast.showToast(msg: "Failed to fetch video: ${response.statusCode}")
    //         .then((value) => ref.read(sharingProvider.notifier).state = false);
    //   }
    // } catch (e) {
    //   Fluttertoast.showToast(msg: "Failed to share: ${e.toString()}")
    //       .then((value) => ref.read(sharingProvider.notifier).state = false);
    // }
