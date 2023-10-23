import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:saverstatus/screens/home_page.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermission extends StatefulWidget {
  @override
  _StoragePermissionState createState() => _StoragePermissionState();
}

class _StoragePermissionState extends State<StoragePermission> {
  Future<int>? storagePermissionChecker;

  Future<int> checkStoragePermission() async {
    if (await Permission.manageExternalStorage.request().isGranted) {
      storagePermissionChecker = requestStoragePermission();
      return 1;
    }
    storagePermissionChecker = requestStoragePermission();
    setState(() {});

    return 1;
  }

  Future<int> requestStoragePermission() async {
    print("CHRCLLL");
    print(await Permission.storage.request().isGranted);
    print("CHRCLLL");
    print("MAANAG");
    // print(await Permission.manageExternalStorage.request().isGranted);
    print("MAANAG");
    bool result = (await Permission.storage.request().isGranted ||
        await Permission.photos.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted);
    print("result");
    print(result);
    print("result");
    setState(() {});
    return result == true ? 1 : 0;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: storagePermissionChecker,
        builder: (context, status) {
          if (status.connectionState == ConnectionState.done) {
            if (status.hasData) {
              if (status.data == 1) {
                return Center(
                  child: HomePage(),
                );
              } else {
                return Scaffold(
                  body: Center(
                    child: TextButton(
                      // color: Colors.teal,
                      child: Text(
                        "Allow storage Permission",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {
                        storagePermissionChecker = requestStoragePermission();
                        setState(() {});
                      },
                    ),
                  ),
                );
              }
            } else {
              return Scaffold(
                  body: Center(
                child: Text(
                    'Something went wrong.. Please uninstall and Install Again'),
              ));
            }
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
