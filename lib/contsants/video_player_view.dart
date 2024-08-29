// import 'package:chewie/chewie.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:video_player/video_player.dart';

// class VideoPlayerScreen extends ConsumerStatefulWidget {
//   VideoPlayerScreen({this.mediaTable, this.videoUrl, Key? key})
//       : super(key: key);
//  List<DocumentSnapshot>? mediaTable;
//   String? videoUrl;
//   @override
//   ConsumerState<VideoPlayerScreen> createState() => _VideoPageState();
// }

// class _VideoPageState extends ConsumerState<VideoPlayerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return VideoPlayerWidget(
//       mediaTable: widget.mediaTable!,
//       videoUrl: widget.videoUrl!,
//     );
//   }
// }

// class VideoPlayerWidget extends ConsumerStatefulWidget {
//   const VideoPlayerWidget({
//     Key? key,
//     required this.mediaTable,
//     required this.videoUrl,
//   }) : super(key: key);

//   final List<DocumentSnapshot> mediaTable;
//   final String videoUrl;

//   @override
//   ConsumerState<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _initPlayer();
//   }

//   void _initPlayer() async {
//     var videoUri = Uri.parse(widget.videoUrl);
//     _videoPlayerController = VideoPlayerController.networkUrl(videoUri);
//     await _videoPlayerController.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       aspectRatio: _videoPlayerController.value.aspectRatio,
//       autoInitialize: true,
//       looping: true,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(
//             errorMessage,
//             style: const TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_videoPlayerController.value.isInitialized) {
//       return Chewie(controller: _chewieController);
//     } else {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
// }
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:percent_indicator/percent_indicator.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  VideoPlayerScreen({this.mediaTable, this.videoUrl, Key? key}) : super(key: key);
  final List<DocumentSnapshot>? mediaTable;
  final String? videoUrl;

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPageState();
}

class _VideoPageState extends ConsumerState<VideoPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(
      mediaTable: widget.mediaTable!,
      videoUrl: widget.videoUrl!,
    );
  }
}

class VideoPlayerWidget extends ConsumerStatefulWidget {
  const VideoPlayerWidget({
    Key? key,
    required this.mediaTable,
    required this.videoUrl,
  }) : super(key: key);

  final List<DocumentSnapshot> mediaTable;
  final String videoUrl;

  @override
  ConsumerState<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isLoading = true;
  double _progress = 0.0;
  String? _localVideoPath;

  @override
  void initState() {
    super.initState();
    _downloadAndInitializeVideo();
  }

  Future<void> _downloadAndInitializeVideo() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final videoPath = '${directory.path}/video.mp4';

      final dio = Dio();
      await dio.download(
        widget.videoUrl,
        videoPath,
        onReceiveProgress: (received, total) {
          setState(() {
            _progress = received / total;
          });
        },
      );

      setState(() {
        _localVideoPath = videoPath;
        _isLoading = false;
      });

      _videoPlayerController = VideoPlayerController.file(File(videoPath));
      await _videoPlayerController.initialize();
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        autoInitialize: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );

      setState(() {});
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 10.0,
              percent: _progress,
              center: Text('${(_progress * 100).toStringAsFixed(2)}%'),
              progressColor: Colors.blue,
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    } else if (_videoPlayerController.value.isInitialized) {
      return Chewie(controller: _chewieController);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
