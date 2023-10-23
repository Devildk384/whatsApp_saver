import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saverstatus/screens/saved_screen.dart';
import 'package:saverstatus/screens/video_screen.dart';

import 'image_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _themeColor = Color.fromARGB(255, 2, 114, 66);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _themeColor,
          title: const Text('WhatsApp Status Saver'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text('Video', style: TextStyle(fontSize: 16)),
              ),
              Tab(
                child: Text(
                  'Images',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  'Saved',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [VideoScreen(), ImageScreen(), SavedScreen()],
        ),
      ),
    );
  }
}
