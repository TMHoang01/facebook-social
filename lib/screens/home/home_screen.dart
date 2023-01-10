import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/screens/home/setting_screen.dart';
import 'package:fb_copy/screens/loading_screen.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:fb_copy/screens/post/post_screen.dart';
import 'package:fb_copy/screens/user/profile_screen.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('facebook',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 27.0, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
              Icon(Icons.search, color: Colors.black),
              SizedBox(width: 15.0),
              // Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black)
            ]),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          tabs: [
            Tab(icon: Icon(Icons.home, size: 30.0)),
            Tab(icon: Icon(Icons.people, size: 30.0)),
            Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
            Tab(icon: Icon(Icons.account_circle, size: 30.0)),
            Tab(icon: Icon(Icons.notifications, size: 30.0)),
            Tab(icon: Icon(Icons.menu, size: 30.0))
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PostScreen(),
          LoadingScreen(text: 'Friend'),
          ProfileScreen(),
          LoadingScreen(text: 'Watch'),
          LoadingScreen(text: 'Notify'),
          MenuTabScreen(),
        ],
      ),
    );
  }
}
