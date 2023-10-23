import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:saverstatus/screens/viewphotos.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:get_storage/get_storage.dart';

class GenrateImageFrompath extends StatefulWidget {
  final String path;
  final bool isHome;

  const GenrateImageFrompath(this.path, this.isHome, {super.key});
  @override
  _GenrateImageFrompathState createState() => _GenrateImageFrompathState();
}

class _GenrateImageFrompathState extends State<GenrateImageFrompath> {
  bool loading = true;
  var box = GetStorage();

  @override
  void initState() {
    void setTimeout(callback, time) {
      Duration timeDelay = Duration(milliseconds: time);
      print(
          "SStimeDelaytimeDelaytimeDelay..........................................dsdsddsdsdsb");
      Timer(timeDelay, callback);
      print(
          "timeDelaytimeDelaytimeDelay..........................................dsdsddsdsdsb");
    }

    void updateLoading() {
      setState(() {
        loading = false;
      });
    }

    setTimeout(updateLoading, 1000);

    super.initState();
  }

  _deleteImage(String path) async {
    List allImagesPathList = box.read("allImage") ?? [];
    List allData = box.read("all") ?? [];

    print(allImagesPathList);
    allImagesPathList.removeWhere((element) => element == path);
    allData.removeWhere((element) => element == path);

    box.write("allImage", allImagesPathList);
    box.write("all", allData);
    File(path).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: loading
          ? CupertinoActivityIndicator(
              color: Color.fromARGB(255, 238, 212, 13),
            )
          : Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewPhotos(
                          imgPath: widget.path,
                        ),
                      ),
                    );
                    // Get.to(
                    //     // PhotoView(imageProvider: FileImage(File(widget.path)))
                    //     );
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          // height: widget.isHome? 200 : 200,
                          decoration: BoxDecoration(
                            //  image: FileImage(File(widget.path)),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Image.file(
                            File(widget.path),
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
