import 'dart:io';

import 'package:flutter/material.dart';
import 'package:saverstatus/screens/GenerateVideoFromPath.dart';

import 'viewphotos.dart';

final Directory _newPhotoDir = Directory('/storage/emulated/0/Pictures');
final Directory _newVideoDir =
    Directory('/storage/emulated/0/whatsapp_status_saver');

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);
  @override
  SavedScreenState createState() => SavedScreenState();
}

class SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    print("_newPhotoDir");
    print(_newPhotoDir.listSync());
    print("_newPhotoDir");
    print(_newVideoDir.listSync());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory('${_newPhotoDir.path}').existsSync()) {
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
      var imageList = _newPhotoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.jpg'))
          .toList(growable: false);
      var videoList = _newVideoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.mp4'))
          .toList(growable: false);
      final finalList = [...videoList, ...imageList];
      if (finalList.length > 0) {
        return Container(
            margin: const EdgeInsets.all(8.0),
            child: GridView.builder(
              key: PageStorageKey(widget.key),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250),
              itemCount: finalList.length - 1,
              itemBuilder: (BuildContext context, int index) {
                final String data = finalList[index];
                if (data.endsWith('.mp4')) {
                  return GenrateVideoFrompath(
                    videoList[index],
                    true,
                  );
                } else {
                  return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPhotos(
                                imgPath: data,
                              ),
                            ),
                          );
                        },
                        child: Image.file(
                          File(imageList[index]),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.medium,
                        ),
                      ));
                }
              },
            )
            // child: StaggeredGrid.count(
            //   crossAxisCount: 4,
            //   children: [
            //     ...imageList.map((imgPath) => StaggeredGridTile.count(
            //           crossAxisCellCount: 2,
            //           mainAxisCellCount:
            //               imageList.indexOf(imgPath).isEven ? 2 : 3,
            //           child: Material(
            //             elevation: 8.0,
            //             borderRadius: const BorderRadius.all(Radius.circular(8)),
            //             child: InkWell(
            //               onTap: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => ViewPhotos(
            //                       imgPath: imgPath,
            //                     ),
            //                   ),
            //                 );
            //               },
            //               child: Hero(
            //                   tag: imgPath,
            //                   child: Image.file(
            //                     File(imgPath),
            //                     fit: BoxFit.cover,
            //                   )),
            //             ),
            //           ),
            //         ))
            //   ],
            //   mainAxisSpacing: 8.0,
            //   crossAxisSpacing: 8.0,
            // ),
            );
      } else {
        return Scaffold(
          body: Center(
            child: Container(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: const Text(
                  'Sorry, No Image Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
      }
    }
  }
}
