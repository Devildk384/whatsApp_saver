import 'dart:io';

import 'package:flutter/material.dart';
import 'package:saverstatus/screens/GenerateVideoFromPath.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../utils/video_play.dart';

final Directory _videoDir =
    Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);
  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory('${_videoDir.path}').existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Install WhatsApp\n',
            style: TextStyle(fontSize: 18.0),
          ),
          const Text(
            "Your Friend's Status Will Be Available Here",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );
    } else {
      return VideoGrid(directory: _videoDir);
    }
  }
}

class VideoGrid extends StatefulWidget {
  final Directory? directory;

  const VideoGrid({Key? key, this.directory}) : super(key: key);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  Future<String?> _getImage(videoPathUrl) async {
    await Future.delayed(Duration(milliseconds: 500));
    final thumb = await VideoThumbnail.thumbnailFile(video: videoPathUrl);
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    final videoList = widget.directory!
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.mp4'))
        .toList(growable: false);

    if (videoList.isNotEmpty) {
      if (videoList.length > 0) {
        return Container(
            margin: const EdgeInsets.all(8.0),
            child: GridView.builder(
                key: PageStorageKey(widget.key),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250),
                itemCount: videoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GenrateVideoFrompath(
                    videoList[index],
                    true,
                  );
                }
                // crossAxisCount: 2,
                // childAspectRatio: 1 / 1.5,
                // children: List<Widget>.generate(
                //     videoList.length,
                //     (index) => Padding(
                //         padding: const EdgeInsets.all(5.0),
                //         child: GenrateVideoFrompath(
                //           videoList[index],
                //           true,
                //         ))),
                ));
      } else {
        return const Center(
          child: Text(
            'Sorry, No Videos Found.',
            style: TextStyle(fontSize: 18.0),
          ),
        );
      }
    } else {
      // return const Center(
      //   child: CircularProgressIndicator(),
      // );
      return const Center(
        child: Text(
          'Sorry, No Videos Found.',
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }
  }
}
