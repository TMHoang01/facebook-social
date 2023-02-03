import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/friend/friend_screen.dart';
import 'package:fb_copy/screens/home/setting_screen.dart';
import 'package:fb_copy/screens/loading_screen.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:fb_copy/screens/post/post_screen.dart';
import 'package:fb_copy/screens/user/profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<Widget> _tabs = [
    FriendsTab(),
    PostScreen(),
    // LoadingScreen(text: '( FriendScreen('),
    // ProfileScreen(),
    LoadingScreen(text: '( Watch('),
    LoadingScreen(text: '( Notify('),
    MenuTabScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: AppColor.backgroundColor,
            floating: true,
            snap: true,
            // title: _tabController!.index == 0 ? Center(child: TopBarApp()) : null,
            title: const Center(child: TopBarApp()),
            pinned: true,
            bottom: TabBar(
              controller: _tabController,
              unselectedLabelColor: Colors.grey,
              labelColor: AppColor.kPrimaryColor,
              // isScrollable: true,
              tabs: const <Widget>[
                Tab(icon: Icon(Icons.home, size: 30.0)),
                Tab(icon: Icon(Icons.people, size: 30.0)),
                Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
                Tab(icon: Icon(Icons.notifications, size: 30.0)),
                Tab(icon: Icon(Icons.menu, size: 30.0)),
                // Tab(icon: Icon(Icons.menu, size: 30.0)),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: _tabs,
        ),
      ),
    );
  }
}

// class TabBarApp extends StatelessWidget {
//   const TabBarApp({super.key, required TabController tabController}) : _tabController = tabController;
//   final TabController _tabController;

//   @override
//   Widget build(BuildContext context) {
//     return TabBar(
//       indicatorColor: Colors.blueAccent,
//       controller: _tabController,
//       unselectedLabelColor: Colors.grey,
//       labelColor: Colors.blueAccent,
//       tabs: const [
//         Tab(icon: Icon(Icons.home, size: 30.0)),
//         Tab(icon: Icon(Icons.people, size: 30.0)),
//         Tab(icon: Icon(Icons.ondemand_video, size: 30.0)),
//         Tab(icon: Icon(Icons.account_circle, size: 30.0)),
//         Tab(icon: Icon(Icons.notifications, size: 30.0)),
//         Tab(icon: Icon(Icons.menu, size: 30.0))
//       ],
//     );
//   }
// }

class TopBarApp extends StatelessWidget {
  const TopBarApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Text('facebook', style: TextStyle(color: Colors.blueAccent, fontSize: 27.0, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(Icons.search, color: Colors.black),
            SizedBox(width: 15.0),
            Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black)
          ],
        ),
      ],
    );
  }
}

void _scrollToTop(BuildContext context) {
  Scrollable.ensureVisible(
    context.findRenderObject() as BuildContext,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
}
