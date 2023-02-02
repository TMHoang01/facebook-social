import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/home/setting_screen.dart';
import 'package:fb_copy/screens/loading_screen.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:fb_copy/screens/notification/notifications_tab.dart';
import 'package:fb_copy/screens/post/post_screen.dart';
import 'package:fb_copy/screens/user/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final List<Widget> _tabs = [
    PostScreen(),
    LoadingScreen(text: '( FriendScreen('),
    LoadingScreen(text: 'watch tab'),
    ProfileScreen(),
    NotificationsTab(),
    MenuTabScreen(),
  ];

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
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: AppColor.backgroundColor,
            floating: true,
            snap: true,
            // title: _tabController!.index == 0 ? Center(child: TopBarApp()) : null,
            title: Center(child: TopBarApp()),
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
                Tab(icon: Icon(Icons.account_circle, size: 30.0)),
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

class TabBarApp extends StatelessWidget {
  const TabBarApp({required TabController tabController}) : _tabController = tabController;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
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
    );
  }
}

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
          children: <Widget>[
            Text('facebook', style: TextStyle(color: Colors.blueAccent, fontSize: 27.0, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          IconButton(onPressed: (){
            showSearch(
                context: context,
                delegate: CustomSearch()
            );
          }, icon:   Icon(Icons.search, color: Colors.black)),
          SizedBox(width: 15.0),
          Icon(FontAwesomeIcons.facebookMessenger, color: Colors.black)
        ]),
      ],
    );
  }
}

class CustomSearch extends SearchDelegate{
  List<String> allData = [
    'Phan Nguyen', 'Minh Hoang', 'Khanh Hung', 'Thu Hieu', 'Thu Ha',
    'Van Tien', 'Van Nhat'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
          onPressed: (){
            query = '';
          },
          icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return
      IconButton(
          onPressed: (){
           close(context, null);
          },
          icon: const Icon(Icons.arrow_back)
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return ListTile(
            title: Text(
              result,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.picsum.photos/id/769/200/200.jpg?hmac=M55kAfuYOrcJ8a49hBRDhWtVLbJo88Y76kUz323SqLU'),
            ),                  );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
        itemBuilder: (context, index){
         var result = matchQuery[index];
         return ListTile(
           title: Text(
             result,
             maxLines: 1,
             overflow: TextOverflow.ellipsis,
             style: TextStyle(
                 color: Colors.black54,
                 fontSize: 16,
                 fontWeight: FontWeight.bold),
           ),
           leading: CircleAvatar(
             backgroundImage: NetworkImage('https://i.picsum.photos/id/769/200/200.jpg?hmac=M55kAfuYOrcJ8a49hBRDhWtVLbJo88Y76kUz323SqLU'),
           ),
         );
        }
    );
  }

}